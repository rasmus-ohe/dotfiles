# Hyprshade configuration

## Installation

Follow the installation steps the [official GitHub](https://github.com/loqusion/hyprshade?tab=readme-ov-file#user-content-fnref-1-d4bf09d7aa48b91d23b2e6bf0726cb86)

## Configuration

### Option 1

Edit one of the pre-existing files in `/usr/share/hyprshade/shaders`

### Option 2

Create a new `.glsl` file in `/usr/share/hyprshade/shaders`

## Turn on shader

```bash
hyprshade on blue-light-filter

# or a full path name
hyprshade on ~/.config/hypr/shaders/blue-light-filter.glsl
```

If you provide the basename, Hyprshade searches in `~/.config/hypr/shaders` and `/usr/share/hyprshade`.
