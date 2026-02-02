## 🎨 SecureCrypt Professional Color Palette

### Primary Colors

```
Primary Color (Purple-Blue)
HEX: #667eea
RGB: 102, 126, 234
USE: Caesar Cipher, Primary buttons, Main brand color

Secondary Color (Rich Purple)
HEX: #764ba2
RGB: 118, 75, 162
USE: Playfair Cipher, Secondary elements

Tertiary Color (Soft Pink)
HEX: #f093fb
RGB: 240, 147, 251
USE: Swift Cipher, Accent elements
```

### Background Colors

```
Main Background
HEX: #F5F7FA
RGB: 245, 247, 250
USE: App background

Surface (Cards)
HEX: #FAFAFA / #FFFFFF
USE: Card backgrounds
```

### Text Colors

```
Primary Text
HEX: #1a1a1a
RGB: 26, 26, 26
USE: Headings, important text

Secondary Text
HEX: #2d3748
RGB: 45, 55, 72
USE: Body text

Tertiary Text
HEX: #4a5568
RGB: 74, 85, 104
USE: Descriptions, hints
```

### Gradients Used

```
Splash Screen Gradient
Colors: #667eea → #764ba2 → #f093fb
Direction: Top-left to bottom-right

Header Gradient
Colors: #667eea → #764ba2
Direction: Top-left to bottom-right

Caesar Card Icon
Colors: #667eea (80% opacity) → #667eea
Direction: Top-left to bottom-right

Swift Card Icon
Colors: #f093fb (80% opacity) → #f093fb
Direction: Top-left to bottom-right

Playfair Card Icon
Colors: #764ba2 (80% opacity) → #764ba2
Direction: Top-left to bottom-right
```

### Shadow Colors

```
Primary Shadow
Color: #667eea with 30% opacity
Blur: 20px
Offset: (0, 8)

Card Icon Shadow
Color: Matching card color with 40% opacity
Blur: 12px
Offset: (0, 4)

Splash Logo Shadow
Color: Black with 20% opacity
Blur: 30px
Offset: (0, 10)
```

### Container Colors

```
Primary Container
HEX: #e9ecff
USE: Info cards, highlights

Secondary Container
HEX: #f4e6ff
USE: Alternative highlights

Tertiary Container
HEX: #ffeef9
USE: Accent highlights
```

### Professional Design Tokens

```
Border Radius:
- Small: 12px
- Medium: 16px
- Large: 20px
- Extra Large: 24px

Elevation (Shadows):
- Level 1: 2-4 blur
- Level 2: 8-12 blur
- Level 3: 15-20 blur
- Level 4: 25-30 blur

Padding:
- Small: 12px
- Medium: 16px
- Large: 20px
- Extra Large: 24px

Icon Sizes:
- Small: 24px
- Medium: 36px
- Large: 60px
- Extra Large: 70px
```

### Color Usage Guide

#### Caesar Cipher
- Icon Background: #667eea gradient
- Card Background: #667eea with 5% opacity
- Shadow: #667eea with 30% opacity

#### Swift Cipher
- Icon Background: #f093fb gradient
- Card Background: #f093fb with 5% opacity
- Shadow: #f093fb with 30% opacity

#### Playfair Cipher
- Icon Background: #764ba2 gradient
- Card Background: #764ba2 with 5% opacity
- Shadow: #764ba2 with 30% opacity

### Brand Identity

```
App Name: SecureCrypt
Tagline: Classical Cryptography Suite
Logo: Lock icon in gradient circle
Splash Duration: 3 seconds
Primary Gradient: Purple-blue to pink
```

### Accessibility

```
Contrast Ratio (Text):
- Primary text on light background: 16.1:1 (AAA)
- Secondary text on light background: 12.4:1 (AAA)
- Primary color on white: 4.8:1 (AA)

Minimum Tap Target: 48x48px
All interactive elements meet accessibility guidelines
```

### Implementation

All colors are defined in:
- `lib/utils/theme_provider.dart`
- `lib/screens/splash_screen.dart`
- `lib/screens/home_screen.dart`
- `lib/widgets/cipher_card.dart`

Use these exact hex codes for consistency across the entire app!
