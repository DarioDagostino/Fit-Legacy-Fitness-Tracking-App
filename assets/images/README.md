# Fit Legacy Logo Assets

This directory contains the logo assets for the Fit Legacy fitness tracking app.

## Available Assets

### logo.svg (Primary)
- Vector format (SVG)
- Scalable to any size without quality loss
- Used by default in the app via `AuthLogo` widget
- Dimensions: 200x200 viewBox
- Features: "FL" text with gradient and modern styling

### logo.png (Fallback)
- Raster format (PNG)
- Recommended size: 512x512 pixels for high-resolution displays
- Used as fallback when SVG support is not available

## Generating PNG from SVG

If you need to regenerate the PNG file from the SVG, you can use one of these methods:

### Method 1: Online Converter
1. Go to https://cloudconvert.com/svg-to-png
2. Upload `logo.svg`
3. Set dimensions to 512x512 pixels
4. Download and save as `logo.png`

### Method 2: ImageMagick (Command Line)
```bash
# Install ImageMagick if not already installed
# Ubuntu/Debian: sudo apt-get install imagemagick
# macOS: brew install imagemagick
# Windows: choco install imagemagick

# Convert SVG to PNG at 512x512
convert -background none -size 512x512 logo.svg logo.png
```

### Method 3: Inkscape (Command Line)
```bash
# Install Inkscape if not already installed
# Ubuntu/Debian: sudo apt-get install inkscape
# macOS: brew install --cask inkscape
# Windows: choco install inkscape

# Convert SVG to PNG
inkscape logo.svg --export-type=png --export-filename=logo.png --export-width=512 --export-height=512
```

### Method 4: Browser Developer Tools
1. Open `logo.svg` in a web browser
2. Open Developer Tools (F12)
3. Take a screenshot or use browser extensions to save as PNG

## Usage in Code

The `AuthLogo` widget (`lib/widgets/auth_logo.dart`) automatically selects the best available format:
1. First tries to load `assets/images/logo.svg`
2. Falls back to `assets/images/logo.png` if SVG is not available
3. Shows "FL" text fallback if neither asset is found

## Design Notes

- **Colors**: The logo uses the app's dark theme colors (#0F172A and #1E293B)
- **Style**: Modern, minimalist design suitable for a fitness app
- **Brand**: "FL" represents "Fit Legacy"
- **Circular**: Designed to work well in circular containers (as used throughout the app)

## Customization

To customize the logo:
1. Edit `logo.svg` in any vector graphics editor (Inkscape, Adobe Illustrator, Figma)
2. Maintain the 200x200 viewBox dimensions
3. Keep the circular design for consistency with the app's UI
4. Regenerate the PNG after making changes

## File Locations

These assets are registered in `pubspec.yaml` under the `assets:` section:
```yaml
flutter:
  assets:
    - assets/
```

This includes all files in the `assets/` directory and subdirectories.
