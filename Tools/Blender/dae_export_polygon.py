bl_info = {
    "name": "Export Lines as OBJ by DAE",
    "blender": (2, 80, 0),
    "category": "Import-Export",
    "version": (1, 0, 0),
    "location": "File > Export > Lines as OBJ (.obj)",
    "description": "Export polygons as lines in OBJ format",
    "author": "Koen Samyn"
}

import bpy
import os
from bpy_extras.io_utils import ExportHelper
from bpy.props import StringProperty
from bpy.types import Operator

class ExportLinesAsOBJ(Operator, ExportHelper):
    bl_idname = "export_lines_as_obj.export"
    bl_label = "Export Lines as OBJ"
    bl_options = {"PRESET"}

    filename_ext = ".obj"
    filter_glob: StringProperty(
        default="*.obj",
        options={"HIDDEN"},
        maxlen=255,
    )

    def execute(self, context):
        filepath = self.filepath
        if not filepath.lower().endswith(".obj"):
            filepath += ".obj"

        obj_file = open(filepath, "w")

        vertex_index = 1
        for obj in bpy.context.selected_objects:
            if obj.type == "MESH":
                mesh = obj.to_mesh()
                mesh.transform(obj.matrix_world)

                for edge in mesh.edges:
                    v1, v2 = edge.vertices

                    obj_file.write("v {} {} {}\n".format(*mesh.vertices[v1].co))
                    obj_file.write("v {} {} {}\n".format(*mesh.vertices[v2].co))
                    obj_file.write("l {} {}\n".format(vertex_index, vertex_index + 1))

                    vertex_index += 2

                obj.to_mesh_clear()
                bpy.data.meshes.remove(mesh)
            elif obj.type == "CURVE":
                depsgraph = bpy.context.evaluated_depsgraph_get()
                curve_eval = obj.evaluated_get(depsgraph)
                curve = curve_eval.to_mesh()

                for v in curve.vertices:
                    obj_file.write("v {} {} {}\n".format(*v.co))

                lastIndex = -1
                
                for edge in curve.edges:
                    v1, v2 = edge.vertices
                    if v1 == lastIndex:
                        obj_file.write(" {}".format(v2+vertex_index))
                    else:
                        obj_file.write("\nl {} {}".format(v1 + vertex_index, v2 + vertex_index))
                    lastIndex = v2
                obj_file.write("\n");
                vertex_index += len(curve.vertices)

                curve_eval.to_mesh_clear()
                #bpy.data.meshes.remove(curve)

        obj_file.close()
        return {"FINISHED"}

def menu_func_export(self, context):
    self.layout.operator(ExportLinesAsOBJ.bl_idname, text="Lines as OBJ (.obj)")

def register():
    bpy.utils.register_class(ExportLinesAsOBJ)
    bpy.types.TOPBAR_MT_file_export.append(menu_func_export)

def unregister():
    bpy.utils.unregister_class(ExportLinesAsOBJ)
    bpy.types.TOPBAR_MT_file_export.remove(menu_func_export)

if __name__ == "__main__":
    register()
