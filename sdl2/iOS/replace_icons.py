#!/usr/bin/env python3
"""
Icon replacement script - run this after placing Icon-1024.png in the current directory
"""
from PIL import Image
import os

def create_icon_sizes():
    """Create all required icon sizes from Icon-1024.png"""
    
    if not os.path.exists('Icon-1024.png'):
        print("Please place your 1024x1024 icon as 'Icon-1024.png' first")
        return False
    
    try:
        # Load the 1024x1024 source image
        source = Image.open('Icon-1024.png')
        print(f"Source image: {source.size}")
        
        # Required icon sizes
        sizes = {
            'Icon.png': (57, 57),           # iPhone 1x (legacy)
            'Icon-72.png': (72, 72),        # iPad 1x (legacy)
            'Icon-120.png': (120, 120),     # iPhone 2x
            'Icon-152.png': (152, 152),     # iPad 2x
            'Icon-167.png': (167, 167),     # iPad Pro
            'Icon-180.png': (180, 180),     # iPhone 3x
        }
        
        # Generate all sizes
        for filename, (width, height) in sizes.items():
            resized = source.resize((width, height), Image.Resampling.LANCZOS)
            resized.save(filename)
            print(f"Created {filename} ({width}x{height})")
            
        # Copy to asset catalog
        asset_path = 'Images.xcassets/AppIcon.appiconset'
        if os.path.exists(asset_path):
            for filename in ['Icon-72.png', 'Icon-120.png', 'Icon-152.png', 'Icon-167.png', 'Icon-180.png']:
                if os.path.exists(filename):
                    import shutil
                    shutil.copy2(filename, asset_path)
                    print(f"Copied {filename} to asset catalog")
        
        print("\nAll icons generated successfully!")
        return True
        
    except Exception as e:
        print(f"Error: {e}")
        return False

if __name__ == "__main__":
    create_icon_sizes()