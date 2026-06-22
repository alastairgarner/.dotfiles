---
name: second-nature-brand
description: Applies Second Nature's official brand colours, typography, and design principles to any artefact that may benefit from having Second Nature's look-and-feel. Use it when brand colours or style guidelines, visual formatting, company design standards, or Second Nature's distinctive visual identity apply.
license: Complete terms in LICENSE.txt
---

# Second Nature Brand Guidelines

## Overview

To access Second Nature's official brand identity and style resources, use this skill. Second Nature is a digital health programme that uses behavioural science to help people lose weight sustainably by building healthier habits.

**Keywords**: branding, corporate identity, visual identity, styling, brand colours, typography, Second Nature brand, visual formatting, visual design, health coaching, weight loss, behavioural science

## Brand Foundation

### Brand mission

To eradicate obesity and type 2 diabetes by changing minds about losing weight. Make losing weight feel easier; make it feel second nature.

### Brand values

- **Integrity**: Vocal and honest about the journey, sharing real truth about sustainable healthy habits
- **Growth**: Focus on 'how' and 'why' rather than just 'what' to do, bringing self-growth through understanding
- **Empowerment**: Provide information and support to help people make the right decisions for themselves

### Brand personality

**Rebellious sage** - Challenge the status quo whilst seeking truth and sharing evidence-based information. Action-oriented with fresh perspectives, leaning on science as the source of authority.

### Tone of voice

- **Confident**: Expert in healthy living without being arrogant or condescending
- **Empathetic**: Compassionate and understanding, never blaming members
- **Knowing**: Observant with verve, using science-backed understanding to disrupt diet beliefs
- **Inclusive**: Space for everyone at any stage of their journey

## Design Guidelines

### Colour palette

**Primary colours (with Tailwind class names):**

- Blue: `#042D49` (Tailwind: `blue` / `blue-DEFAULT`) - Primary colour for all text (headings, body, and data points)
  - Shades: `blue-50: #F2F4F6`, `blue-100: #E6EAED`, `blue-200: #CDD5DB`, `blue-400: #9BABB6`, `blue-600: #688192`, `blue-800: #36576D`
- Purple: `#C7B5F0` (Tailwind: `purple` / `purple-DEFAULT`) - Complementary colour for data series and accents
  - Shades: `purple-50: #FAF8FE`, `purple-200: #F4F0FC`, `purple-400: #E9E1F9`, `purple-600: #DDD3F6`, `purple-800: #D2C4F3`
- Salmon: `#FEB7BB` (Tailwind: `salmon` / `salmon-DEFAULT`) - Complementary colour for data series and accents
  - Shades: `salmon-50: #FFFBFB`, `salmon-200: #FFF1F1`, `salmon-400: #FFE2E4`, `salmon-600: #FED4D6`, `salmon-800: #FEC5C9`
- Dawn blue: `#6B91CB` (Tailwind: `dawn-blue` / `dawn-blue-DEFAULT`) - Complementary colour for data series and accents
  - Shades: `dawn-blue-50: #F7F9FC`, `dawn-blue-150: #E9EFF7`, `dawn-blue-200: #E1E9F5`, `dawn-blue-400: #C4D3EA`, `dawn-blue-600: #A6BDE0`, `dawn-blue-800: #89A7D5`
- Teal: `#26D9D8` (Tailwind: `teal` / `teal-DEFAULT`) - Complementary colour for data series and accents
  - Shades: `teal-50: #F4FDFD`, `teal-200: #D4F7F7`, `teal-400: #A8F0EF`, `teal-600: #7DE8E8`, `teal-800: #51E1E0`
- Grey: `#F2F2F2` (Tailwind: `grey` / `grey-DEFAULT`) - Backgrounds and subtle separators
  - Shades: `grey-400: #FAFAFA`, `grey-600: #F7F7F7`, `grey-800: #F5F5F5`

**Monochrome colours:**

- Dark grey: `#41616D` (Tailwind: `mono-grey`) - Secondary UI text only (form labels, captions, helper text, metadata). Never use for headings or body copy — use `text-blue` for those
- White: `#FFFFFF` (Tailwind: `mono-white` or `white`) - Text on dark backgrounds and spacing
- Black: `#000000` (Tailwind: `mono-black` or `black`)

**System colours:**

- Success: `#99F3C9` (Tailwind: `system-success`)
- Info: `#9B6BFF` (Tailwind: `system-info`)
- Warning: `#FFE178` (Tailwind: `system-warning`)
- Error: `#FF8686` (Tailwind: `system-error`)

**Colour usage principles:**

- Use Blue (`text-blue`) for all text: headings, body copy, and key data points. Use lighter blue shades (`text-blue-600`, `text-blue-400`) for secondary text
- Use complementary colours (Purple, Salmon, Dawn blue, Teal) for data series, chart elements, and accent pieces
- Use Grey for backgrounds and subtle separators
- Use mono-grey (`text-mono-grey`) sparingly — only for secondary UI elements like form labels, captions, helper text, and metadata. Never for headings or body copy
- Use White for text on dark backgrounds and spacing elements
- Use shade variants (50–800) for lighter/darker versions of each colour

**Colour intensity guidelines:**

- Use the shade scale (50–800) to vary colour intensity rather than applying CSS opacity
- For example, use `bg-blue-200` for a lighter blue background instead of `bg-blue opacity-20`
- DEFAULT (no shade suffix) is the full-strength brand colour
- Lower shades (50, 100, 200) are for backgrounds, hover states, and subtle elements
- Higher shades (600, 800) are for stronger accents and emphasis

### Typography

**Typefaces:**

- **Headings**: TT Firs Neue (Demibold for main headings, Medium for subtitles)
- **Body text**: Cera Pro (Light for main copy, Medium for emphasis)

**Tailwind font classes and fallbacks:**

- Headings: `font-firs` — resolves to `TTFirsNeue` (basecamp) or `var(--font-firs)` (website)
- Body: `font-cera` — resolves to `CeraPro, sans-serif` (basecamp) or `var(--font-cera), sans-serif` (website)

**Font sizes and weights:**

- Headers and titles: TT Firs Neue Demibold, 40px
- Subtitles: TT Firs Neue Medium, 24px
- Axis labels and legends: Cera Pro Medium, 18px
- Data labels and values: Cera Pro Light, 16px
- Intro body copy: Cera Pro Medium, 18px (for introductions or summaries)
- Main body copy: Cera Pro Light, 16px

**Typography principles:**

- Apply TT Firs Neue to all headings and titles
- Apply Cera Pro to all body text
- Maintain clear text hierarchy
- Keep paragraph length short (2-4 sentences max)
- Use sentence case for titles (not Title Case)

### Graphic elements

**Corner radius:**

- Apply 14px corner radius to all rectangles, cards, containers, and square images
- Maintain consistency across all visual elements

**Spacing:**

- Consistent padding of 24px around chart elements
- 16px spacing between related elements
- 32px spacing between different chart sections

**Shadows:**

- Use subtle shadows for emphasis: `0px 4px 12px rgba(4, 45, 73, 0.1)`
- Apply sparingly to maintain clean aesthetic

**Illustrative graphic elements:**

- Organic shapes derived from brain lobes (cerebellum, frontal, parietal, temporal, occipital)
- Use as framing devices, background textures, or to add visual interest
- Can be used as solid shapes or outline strokes
- Scale, rotate, and position flexibly whilst maintaining brand recognition

### Logo usage

**Stacked logo (primary):**

- Use where possible as the primary logo format
- Maintain minimum border using the height of the 'E' in 'Second'

**Horizontal logo (secondary):**

- Use only when stacked logo doesn't fit comfortably in the space

**Logo colours:**

- Deep blue version for light backgrounds
- White version for dark backgrounds (ensure visibility and legibility)
- Never place white logo on bright, neon, or desaturated colours

**Logo rules:**

- Never redraw or alter the logo
- Capitalise 'Second Nature' when referring to the company name
- Use lowercase 'second nature' when referring to making habits automatic (except when making a pun in titles)

## Content Guidelines

### Writing style

- Use British English spelling and grammar for UK communications
- Use U.S. English spelling and grammar for U.S. communications
- Write in plain language, avoiding jargon and slang
- Use abbreviations (don't, it's, you're) to maintain conversational tone
- Use single quotation marks
- Use Oxford commas (comma before 'and' in a list)
- Speak in first person (I, we, our) or second person (you)
- Keep sentences varied in length to maintain interest
- Start sentences with 'And', 'Because', or 'But' in informal contexts

### Terminology

**Preferred terms:**

- Health coach (UK) or Coach (U.S.) - not Mentor
- Members - not Users, Customers, or Clients
- People - general reference
- 1-1 chat - not Private chat
- Registered nutritionist or dietitian - not Certified, Qualified, or Experienced
- Programme or subscription - not Digital programme
- Used by the NHS - not Backed by or Approved by
- While - not Whilst

### Message approach

**Audience mindset:**

The target audience is often:
- Sceptical about weight loss solutions
- Losing hope after years of yo-yo dieting
- Ready for a holistic healthy living solution
- Experiencing weight loss urgency

**Communication principles:**

- Root everything in science or member reviews
- Challenge self-doubt with rational truths
- Show realistic and accessible tools
- Use first-person stories from members where possible
- Let success stories and science speak for themselves

**Evidence-based claims:**

- Twice as effective as other weight loss programmes (British Medical Journal 2022)
- 9/10 people lose weight and keep it off for 12+ months (JMIR Diabetes 2020)
- 40% saw blood sugar levels drop below type 2 diabetes threshold in three months (JMIR Diabetes 2020)
- 90% of Trustpilot reviews rate as 'excellent' with 4.8 star rating

## Data Visualisation Guidelines

### Chart types and styling

**Bar charts:**

- Use rounded corners (14px radius) for bars
- Primary colour (Deep blue) for main data series
- Complementary colours for comparisons
- Maintain at least 40% space between bars
- Use horizontal bars for categorical data with long labels

**Line charts:**

- 2-3px line thickness for primary data
- Use Deep blue for primary trend lines
- Add subtle gradient fills below lines at 20% opacity
- Use round line joins and line caps

**Pie/donut charts:**

- Use complementary colours from the palette
- Apply 14px border radius to segments if technically possible
- Include percentage labels (Cera Pro Medium, 18px)
- Add subtle (2px) white separation between segments

**Tables:**

- Light grey alternating rows at 40% opacity
- Deep blue header backgrounds
- White text for headers
- 14px border radius on table corners
- Consistent cell padding of 16px

### Animation and interaction

**Transitions:**

- Smooth transitions with 300-400ms duration
- Easing function: `cubic-bezier(0.4, 0.0, 0.2, 1)`

**Hover states:**

- Increase opacity to 100% on hover
- Consider subtle scale transforms (1.02-1.05) for interactive elements
- Display tooltip with additional information

**Loading states:**

- Use brand colours in loading animations
- Consider incorporating organic brain-derived shapes

### Accessibility

- Ensure sufficient contrast ratios (minimum 4.5:1 for text)
- Don't rely solely on colour to convey information
- Include alternative text descriptions for complex visualisations
- Use patterns or textures in addition to colours for differentiation

## Photography Guidelines

### Brand foundation

- Showcase real people and celebrate the community
- Demonstrate diversity and inclusivity
- Get inside the mind of success
- Make future members feel they belong

### Portrait photography

**Shot list:**

1. Positive expression close-up (shot wide but can be cropped)
2. Three-quarter length with positive stance
3. Supporting candid moments capturing authenticity

**Crops and proportions:**

- 14px corner radius for all square images
- Replicate 9:16 or 16:9 format where possible for desktop and mobile

### Food photography

**Do:**

- Include hands suggesting preparing or enjoying food
- Use fresh lighting reflecting richness whilst retaining natural tones
- Use simple styling with light props in brand colours where possible
- Show comfortable interaction with food in social settings

**Don't:**

- Over-style food or surrounding props
- Include hands in contrived or uninvolved ways
- Use hard, unrealistic shadows or oversaturate colours
- Show people directly eating food
- Display eating or mouths

**Hand positioning:**

- Dressing food: Natural gestures
- Holding food: Light, natural hand positions without squeezing
- Eating and serving: Show only scooping and serving motions without faces

### Lifestyle photography

- Show people comfortable in social settings with food
- Reflect healthy relationships and habits with food
- Avoid showing direct consumption
- Focus on the experience and social aspects

## Implementation Guidelines

### For React.js visualisations

**Recommended libraries:**

- Recharts: For standard charts with good customisation
- D3.js: For complex, custom visualisations
- React-Table: For data table representations

**Tailwind configuration:**

The shared Tailwind config lives in `shared/tailwind-config/index.js` and is extended by each app. Colours are defined at the top level of `theme.colors` (not under `extend`), meaning they replace Tailwind defaults rather than extending them.

```javascript
// shared/tailwind-config/index.js (simplified)
module.exports = {
  theme: {
    colors: {
      blue: {
        DEFAULT: '#042D49',
        50: '#F2F4F6', 100: '#E6EAED', 200: '#CDD5DB',
        400: '#9BABB6', 600: '#688192', 800: '#36576D',
      },
      salmon: {
        DEFAULT: '#FEB7BB',
        50: '#FFFBFB', 200: '#FFF1F1', 400: '#FFE2E4',
        600: '#FED4D6', 800: '#FEC5C9',
      },
      teal: {
        DEFAULT: '#26D9D8',
        50: '#F4FDFD', 200: '#D4F7F7', 400: '#A8F0EF',
        600: '#7DE8E8', 800: '#51E1E0',
      },
      'dawn-blue': {
        DEFAULT: '#6B91CB',
        50: '#F7F9FC', 150: '#E9EFF7', 200: '#E1E9F5',
        400: '#C4D3EA', 600: '#A6BDE0', 800: '#89A7D5',
      },
      purple: {
        DEFAULT: '#C7B5F0',
        50: '#FAF8FE', 200: '#F4F0FC', 400: '#E9E1F9',
        600: '#DDD3F6', 800: '#D2C4F3',
      },
      grey: {
        DEFAULT: '#F2F2F2',
        400: '#FAFAFA', 600: '#F7F7F7', 800: '#F5F5F5',
      },
      mono: { grey: '#41616D', white: '#FFFFFF', black: '#000000' },
      system: {
        success: '#99F3C9', info: '#9B6BFF',
        warning: '#FFE178', error: '#FF8686',
      },
    },
    fontFamily: {
      cera: ['CeraPro', 'sans-serif'],
      firs: ['TTFirsNeue'],
    },
  },
}
```

**Chart configuration:**

```javascript
const chartConfig = {
  colors: {
    primary: '#042D49',
    secondary: ['#C7B5F0', '#FEB7BB', '#6B91CB', '#26D9D8'],
    background: '#F2F2F2',
    text: '#41616D'
  },
  typography: {
    title: {
      fontFamily: 'TTFirsNeue, sans-serif',
      fontSize: 24,
      fontWeight: 600
    },
    label: {
      fontFamily: 'CeraPro, sans-serif',
      fontSize: 16,
      fontWeight: 400
    }
  },
  borderRadius: 14,
  animation: {
    duration: 350,
    easing: 'ease-in-out'
  }
};
```

### For PowerPoint/documents

**Colour application:**

- Use RGB colour values for precise brand matching
- Apply via python-pptx's RGBColor class or equivalent
- Maintain colour fidelity across different systems

**Font application:**

- Apply TT Firs Neue to all headings (24pt and larger)
- Apply Cera Pro to all body text
- Automatically fall back to system fonts if custom fonts unavailable
- Preserve readability and text hierarchy

### Data storytelling principles

- Focus on user progress and success metrics
- Highlight behaviour change patterns over time
- Use comparative data to showcase improvement
- Present information with focus on empowerment, not criticism
- Include contextual insights alongside raw data
- Prioritise clarity and simplicity

## Application Examples

### Social media design

- Scale, colour, and position organic brain shapes to offset images
- Text panels can be scaled and repositioned around images
- Keep title text to approximately 8 words
- Ensure Second Nature logo is clearly legible
- Use 14px corner radius for all elements

### Performance assets

- Apply brand colours consistently
- Maintain typography hierarchy
- Use organic shapes as background elements or framing devices
- Include member testimonials with first-person narratives
- Ensure all elements align with brand personality

### Website design

- Follow consistent colour palette throughout
- Apply proper typography hierarchy
- Use 14px border radius for interactive elements
- Incorporate organic brain-derived shapes subtly
- Maintain clean, uncluttered layouts with appropriate spacing

## Creative Principles

As Second Nature, always:

- Show new and engaging ways to eat better and live healthily
- Empower with lasting knowledge and techniques
- Identify and challenge existing thought processes around losing weight
- Generously share expertise where invited
- Inspire growth in an empowering and hopeful way
- Foster curiosity and discovery
- Be transparent about and celebrate every step of the journey

## Brand Platform

The brand platform: **Make losing weight feel Second Nature**

This platform should underpin all communications, showing how Second Nature makes losing weight feel easier by retraining the mind to make healthy choices automatically. Celebrate members as the best example of success, using first-person narratives to demonstrate real transformation.
