import struct
import json
import sys

def check_glb(filename):
    try:
        with open(filename, 'rb') as f:
            magic = f.read(4)
            if magic != b'glTF':
                print(f"Not a valid GLB file: {filename}")
                return
            version = struct.unpack('<I', f.read(4))[0]
            length = struct.unpack('<I', f.read(4))[0]
            
            chunk0_length = struct.unpack('<I', f.read(4))[0]
            chunk0_type = f.read(4)
            if chunk0_type != b'JSON':
                print("First chunk is not JSON.")
                return
                
            json_data = f.read(chunk0_length).decode('utf-8')
            gltf = json.loads(json_data)
            
            has_animations = 'animations' in gltf
            has_skins = 'skins' in gltf
            
            print(f"--- File: {filename} ---")
            print(f"Has Rig (Skins): {has_skins}")
            if has_skins:
                print(f"Number of skins: {len(gltf['skins'])}")
                
            print(f"Has Animations: {has_animations}")
            if has_animations:
                print(f"Number of animations: {len(gltf['animations'])}")
                for i, anim in enumerate(gltf['animations']):
                    print(f"  Animation {i}: {anim.get('name', 'Unnamed')}")
                    
            print(f"Total Nodes (Bones/Meshes): {len(gltf.get('nodes', []))}")
            print(f"Total Meshes: {len(gltf.get('meshes', []))}")
            print("---------------------------------")
    except Exception as e:
        print(f"Error reading {filename}: {e}")

if len(sys.argv) > 1:
    check_glb(sys.argv[1])
else:
    print("Please provide a file path.")
