#%%
import os
from typing import Generator
from dataclasses import dataclass
from pycparser import c_parser, c_ast, parse_file

work_dir = os.path.dirname(os.path.abspath(__file__))
# print(work_dir)
escapse_list = [
    'FPDF_InitLibraryWithConfig',
    'FPDF_VIEWERREF_GetDuplex'
]
c_type_map = {
    'long': 'int32',
    'long int': 'int32',
    'long unsigned int': 'uint32',
    'int': 'int32',
    'unsigned long': 'uint32',
    'long double': 'double',
    'unsigned short': 'uint8'
}

pdfium_type_map = {
    'FPDF_STRING': '*char',
    'FPDF_BYTESTRING': '*char',
    'FPDF_WIDESTRING': '*uint8'
}

@dataclass(init=True)
class PdfiumFunc():
    name: str
    documentation: str
    parameterTypes: list
    parameterNames: list
    returnType: str

    def __init__(self, name='', documentation='', parameterTypes=[], parameterNames=[], returnType=''):
        self.name = name
        self.documentation = documentation
        self.parameterNames = parameterNames
        self.parameterTypes = parameterTypes
        self.returnType = returnType
    def __repr__(self) -> str:
        return f'''
        Func(
            name: "{self.name}",
            parameterTypes: {self.parameterTypes},
            parameterNames: {self.parameterNames},
            returnType: "{self.returnType}"
        )'''

# %%

def header2dart(header_file: str):
    parser = parse_file(
        header_file, use_cpp=True
        )
#%%
test_file = '/Users/zhonghua/workspace/c-space/pdfium/pdfium/public/fpdf_doc.h'
head = parse_file(
    test_file, use_cpp=True, cpp_path='clang',
    cpp_args=['-E', r'-Iutils/fake_libc_include']
    )

#%%
def_list = list(head.children())
func = def_list[78]

#%% 
def get_type(decl):
    if isinstance(decl, c_ast.IdentifierType):
        # if len(decl.names) > 1:
        #     print(decl, decl.names)
        return ' '.join(decl.names)
    elif type(decl) in  [c_ast.Enum, c_ast.Struct]:
        return type(decl)
    return get_type(decl.type)

def get_funcs(head_file):
    for idx, def_el in parse_file(
        filename=head_file,
        use_cpp=True, cpp_path='clang', cpp_args=['-E', r'-Iutils/fake_libc_include']
        ).children():
        ### point
        if isinstance(def_el.type, c_ast.PtrDecl):
            def_el_type = get_type(def_el)
            if isinstance(def_el_type, str):
                yield def_el_type, def_el.name
            else:
                yield def_el.type, def_el.name
        elif isinstance(def_el.type, c_ast.TypeDecl):
            type_el = get_type(def_el)
            if type(type_el) in [c_ast.Struct, c_ast.Enum]: continue
            yield def_el.type, type_el
        elif isinstance(def_el.type, c_ast.FuncDecl):
            args = def_el.type.args
            # print(f'func: {def_el.name}')
            if args is None:
                # print(f'void: {def_el.name}')
                continue
            params = def_el.type.args.params
            params_names = [x.name for x in params]

            params_types = [get_type(x) for x in params]
            return_type = get_type(def_el.type)
            # print(
            #     f'func name: {def_el.name}, params names: {params_names}, param types: {params_types}'
            #     f'return type: {return_type}'
            # )
            func = PdfiumFunc(
                name=def_el.name, parameterNames=params_names,
                parameterTypes=params_types, returnType=return_type
            )
            yield def_el.type, func

def add_pointer(param_name, prt_list, type_map):
    param_type = type_map.get(param_name, param_name)
    param_type = pdfium_type_map.get(param_type, param_type)
    if isinstance(param_type, str):
        param_name = c_type_map.get(param_type, param_type)
    return f'*{param_name}' if param_name in prt_list else param_name

# Get ptr decl variable list
ptr_decl_list = [x for t, x in get_funcs(test_file) if isinstance(t, c_ast.PtrDecl)]
type_map = dict((t.declname, x) for t, x in get_funcs(test_file) if isinstance(t, c_ast.TypeDecl))
#print(ptr_decl_list)
auto_gen_header_file = os.path.join(work_dir, 'fpdf_doc.dart')
header_tpl = open(os.path.join(work_dir, 'gen_ffi_tpl.txt')).read()
with open(auto_gen_header_file, 'w') as w:
    func_list = []
    for decl_type, func_el in get_funcs(test_file):
        if isinstance(decl_type, c_ast.FuncDecl):
            if func_el.name in escapse_list: 
                continue
            func_el.parameterTypes = list(map(lambda x: add_pointer(x, ptr_decl_list, type_map), func_el.parameterTypes))
            func_el.returnType = add_pointer(func_el.returnType, ptr_decl_list, type_map)
            func_list.append(str(func_el))
    w.write(header_tpl.format(','.join(func_list)))




# %%
