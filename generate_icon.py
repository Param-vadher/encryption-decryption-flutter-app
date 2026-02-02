from PIL import Image, ImageDraw

# Create 1024x1024 icon (will be resized by flutter_launcher_icons)
size = 1024
img = Image.new('RGB', (size, size), color='#0891b2')

draw = ImageDraw.Draw(img)

# Draw gradient effect
for y in range(size):
    r = int(8 + (16 - 8) * y / size)
    g = int(145 + (185 - 145) * y / size)
    b = int(178 + (129 - 178) * y / size)
    draw.line([(0, y), (size, y)], fill=(r, g, b))

# Draw lock body (rounded rectangle)
lock_width = int(size * 0.4)
lock_height = int(size * 0.35)
lock_x = (size - lock_width) // 2
lock_y = int(size * 0.45)

draw.rounded_rectangle(
    [lock_x, lock_y, lock_x + lock_width, lock_y + lock_height],
    radius=30,
    fill='white'
)

# Draw lock shackle (arc)
shackle_width = int(lock_width * 0.6)
shackle_height = int(lock_height * 0.8)
shackle_x = lock_x + (lock_width - shackle_width) // 2
shackle_y = lock_y - int(shackle_height * 0.5)

draw.arc(
    [shackle_x, shackle_y, shackle_x + shackle_width, shackle_y + shackle_height],
    start=180,
    end=0,
    fill='white',
    width=45
)

# Draw keyhole
keyhole_size = int(lock_width * 0.2)
keyhole_x = lock_x + (lock_width - keyhole_size) // 2
keyhole_y = lock_y + int(lock_height * 0.35)

draw.ellipse(
    [keyhole_x, keyhole_y, keyhole_x + keyhole_size, keyhole_y + keyhole_size],
    fill='#0891b2'
)

# Draw keyhole slot
slot_width = int(keyhole_size * 0.4)
slot_height = int(keyhole_size * 0.8)
slot_x = keyhole_x + (keyhole_size - slot_width) // 2
slot_y = keyhole_y + keyhole_size - 5

draw.rectangle(
    [slot_x, slot_y, slot_x + slot_width, slot_y + slot_height],
    fill='#0891b2'
)

# Save the icon
img.save('assets/icon.png')
print("Icon generated successfully!")
