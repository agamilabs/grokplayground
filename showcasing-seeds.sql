-- Showcase Categories
INSERT INTO `showcase_categories` (`id`, `name`, `slug`, `description`) VALUES
(1, 'Web & App Design', 'app-web-design', 'High-quality interfaces and UX concepts.'),
(2, 'Comic & Storyboard', 'comic-storyboard', 'Sequential art and character storytelling.'),
(3, 'Logo & Branding', 'logo-branding', 'Professional visual identities and symbols.'),
(4, 'Ecommerce & Products', 'ecommerce-main-image', 'Stunning product photography and marketing visuals.'),
(5, 'Gaming & Assets', 'game-asset', 'Environment art and character assets for games.'),
(6, 'Social Media', 'social-media-post', 'Engaging content for various platforms.') ON DUPLICATE KEY UPDATE name=VALUES(name), slug=VALUES(slug), description=VALUES(description);

-- Showcase Items
INSERT INTO `showcase_items` (`category_id`, `title`, `prompt`, `description`, `type`, `model_used`, `settings_json`, `output_url`, `votes`) VALUES
(NULL, 'Flat UI/Startup Style Illustration Prompt', 'Flat illustration of {argument name=\"subject\" default=\"[subject]\"}, startup-style vector art, bright colors, simple shapes, clean and professional design, white background, no text.', 'A simple, reusable prompt for Nano Banana Pro to generate flat, startup-style vector illustrations of a specified subject, emphasizing bright colors, simple shapes, clean design, and a white background, with an explicit instruction to exclude text.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1774248298494_hmspay_HEBU7CUakAAZ7B4.jpg', 0),
(NULL, 'Nano Banana 2 Note Illustration Prompt (Rothschild Historical Scene)', '# Instructions
You are a professional illustrator and prompt engineer.
Read the following [Blog Summary] and create an attractive illustration that intuitively conveys its content.
Display the title at the top of the illustration.

# Image Size
1280px × 670px (Aspect ratio 16:9)

# Output Conditions
Brand Color: [#06c7b0]
Simple and clean flat design.
Place figures and icons drawn with uniform black outlines, partially using pastel accent colors (sky blue, coral pink, etc.).
Emphasize rounded shapes and a soft impression.
Diagram-centric composition (e.g., Venn diagrams, bar graphs, speech bubbles) with a friendly tone suitable for materials viewed by students and young people, or for social media.
Design with ample white space, prioritizing visibility and balance.
The figures appearing should be dressed as 18th-century European nobility.

# Blog Summary
Mayer Amschel Rothschild was not born into a privileged class, but a turning point arrived. He gained the opportunity to provide antique coins to Wilhelm IX, the Elector of Hesse, the regional ruler. However, that alone would make him just another antique coin dealer. What made him unusual was that he continued to provide rare antique coins to Wilhelm IX \"at prices significantly lower than the market rate, disregarding profit.\" Normally, one would try to overcharge a person in power. But he prioritized gaining favor over picking up immediate small change.', 'A comprehensive system prompt for Nano Banana 2, instructing it to act as a professional illustrator and prompt engineer to create a visually appealing, flat-design illustration for a blog post about Mayer Amschel Rothschild. The prompt specifies style, color, composition, and historical context.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1773902679745_hzj4wl_HDpzz5DboAAofOu.jpg', 0),
(NULL, 'Cinematic Vector Fashion Portrait', 'Create A Cinematic Fashion-editorial Portrait Of A Person Using Their Photo As Identity Reference, Rendered In A Clean Flat Vector Illustration Style With Smooth Geometric Shapes, Crisp Outlines, And Simplified Facial Geometry, Framing Centered Head-and-shoulders Composition With Symmetrical Alignment, Subject Facing Forward With Relaxed Posture And A Subtle Friendly Smile Styling Minimal Modern Casual With A Simple Dark Crew-neck Shirt And Thin Round Eyeglasses, Paired With Small Wireless Earbuds As Understated Accessories, Background A Flat Warm Beige Studio Tone (#ebdbc6) With No Gradients Or Textures To Maintain A Graphic Design Aesthetic, Lighting Implied Through Stylized Flat Color Blocking Rather Than Realistic Shading, With A Gentle Warm Highlight Tone (-4800k) On One Side Of The Face And A Slightly Darker Tonal Block On The Opposite Side To Create Minimal Dimensional Contrast, Reflections Extremely Subtle On The Glasses Lenses, Lens Simulation Conceptually Equivalent To A Neutral Portrait Crop (50-70mm) Translated Into A Flat Graphic Design Perspective With No Depth Blur; Texture Perfectly Smooth Matte Vector Surfaces With Solid Color Fills And Clean Edges, Color Palette Warm Skin Tones, Muted Peach And Coral Accents, Charcoal Black Hair And Clothing, And Soft Beige Background, Overall Mood Friendly, Approachable, Modern Tech-avatar Aesthetic Suitable For Product Design Or Ui Identity Illustration Editorial, Modern, High-detail, Cinematic Composition, Ultra-realistic Textures, Professional Fashion Photography Style', 'A highly detailed, structured prompt for Nano Banana Pro to generate a cinematic fashion-editorial portrait in a clean, flat vector illustration style, using a reference photo for identity and specific color blocking for lighting.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1773729510053_0fgman_HDi6CJ9bcAA4LSI.jpg', 0),
(NULL, 'Liquid Chrome Metallic FX Prompt', 'Hyper-realistic liquid metallic chrome graphic with perfect reflective surfaces, fluid mercury-like distortions, high-gloss specular highlights, smooth gradients and dynamic liquid metal flow. Ultra-modern luxury product and tech branding aesthetic.', 'A prompt for generating a hyper-realistic liquid metallic chrome graphic with perfect reflective surfaces, fluid distortions, and high-gloss specular highlights, suitable for modern luxury product branding.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1773383476980_l7cc9a_HDNBFFSWAAADCkQ.jpg', 0),
(NULL, 'System Prompt for Nano Banana Pro Image Prompt Deconstruction', 'You are an expert image prompt deconstruction specialist. Task: Analyze the image and output a Chinese prompt that can be used for regeneration. Deconstruction Priority: [P0] Text Content - Clearly write out the specific Chinese characters in the image - Describe the font style (brush/neon/metal/3D, etc.) - Explain the layout and composition [P1] Visual Details - Supplement reasonable guesses for blurred parts', 'This is a system prompt designed to instruct Nano Banana Pro (an image generation model) to act as an expert image prompt deconstruction specialist. The task is to analyze an image and output a Chinese prompt that can be used to regenerate the image, prioritizing text content (P0) and visual details (P1). This is a meta-prompt used to generate other prompts, not a direct image generation prompt.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1773383503371_wptd0o_HDM9MF0bgAA7_Bd.jpg', 0),
(NULL, 'Modern Home Interior Architectural Blueprint Prompt', 'Modern home interior turned into a clean 2D architectural blueprint floor plan 🗺️', 'A prompt for transforming a modern home interior into a clean 2D architectural blueprint floor plan.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1773383481459_362ag9_HDLFzMgbMAAvwsu.jpg', 0),
(NULL, 'WordPress Header Image Generation Prompt (Nano Banana)', 'I am creating a WordPress site. I would like you to create a horizontal header image. The site is called \'Comfortable Memo for Living\'.', 'A simple prompt used with Nano Banana to generate a horizontal header image for a WordPress site titled \'Comfortable Memo for Living\' (\'暮らしの快適メモ\').', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1773297043698_pw1bg6_HDHn5YrboAA0bll.jpg', 0),
(NULL, 'Photorealistic 3D Floor Plan Render with Furniture', 'Use the uploaded image as reference, Create photorealistic 3D render of the entire floor plan, seen from afar, to the render, with furniture inside, Keep the exact same rooms at their location, with the right equipment, but remove the text from the final image. High resolution, pro quality.', 'A prompt for generating a photorealistic 3D render of an entire floor plan (Bungalow/Moville plan). It requires using an uploaded image as a reference to maintain the exact room locations and equipment, while adding furniture and removing text from the final high-resolution image.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772864615741_jydhli_HCuvGUYW4AAHCL8.jpg', 0),
(NULL, 'Floor Plan to Photorealistic 3D Render Conversion', 'Use the uploaded image as reference, Create photorealistic 3D render of the entire floor plan, seen from afar, to the render, with urniture inside, Keeplorized the exact same rooms at their location, with the right equipment, but remove the text from the final image. High resolution, pro quality.', 'A prompt for converting an uploaded floor plan image into a photorealistic 3D render, ensuring the exact room layout and equipment are maintained, but removing text from the final image.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772864621222_rumpq1_HCsGwucWMAEFeCQ.jpg', 0),
(NULL, 'Soft Pink Aesthetic Study Room Vibe', '{
  \"title\": \"Pink Soft Study Vibes\",
  \"description\": \"A cozy pastel-themed room with soft pink curtains and cute wall art in the background. A girl is sitting on a pink gaming chair beside a white desk with a matching pink keyboard and mouse. She is wearing a light pink full-sleeve top and a dark plaid skirt, creating a soft and aesthetic look. The overall vibe feels calm, dreamy, and perfectly coordinated in pink tones.\",
  \"theme\": \"Soft Pink Aesthetic\",
  \"mood\": \"Calm, dreamy, cozy, peaceful\",
  \"colors\": [\"soft pink\", \"white\", \"peach\", \"dark blue\", \"black\"],
  \"lighting\": \"Natural soft daylight through pink curtains\",
  \"setting\": \"Indoor bedroom study setup\",
  \"style\": \"Cute, pastel, aesthetic, cozy\",
  \"props\": [\"pink gaming chair\", \"white desk\", \"pink keyboard\", \"pink mouse\", \"wall art\", \"plush toys\"]
}', 'A structured JSON prompt detailing the creation of an image featuring a cozy, dreamy indoor study setup dominated by a soft pink aesthetic, including specific props like a pink gaming chair and matching peripherals, illuminated by natural soft daylight.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772605588740_o7edcz_HCchh8raEAAXoTg.jpg', 0),
(NULL, 'Office Renovation and Decoration Prompt', 'Please renovate this attached photo that showing a room under finishing work.

Please complete this finishing work for this toom to be home office of Mercedes branch.

Please renovate the ceilings, floor, windows, and wall professionally.

Decorate this main office room to be suitable for 2026 modern design.

Add cupboards, chairs, sofa, main office table with chair.', 'A simple text prompt used to renovate an attached photo of a room under finishing work, transforming it into a modern 2026 home office for a Mercedes branch, specifying the completion of ceilings, floors, windows, and walls, and the addition of furniture.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772519749314_5l01qt_HCbsZcPWMAAmJlQ.jpg', 0),
(NULL, 'Nano Banana Layout Preservation Prompt', 'the prompt help nano banana strictly maintain the exact layout, wall positions, door swing, shelving placement, toilet and sink position, and dimensions as shown. No structural or proportional changes', 'A prompt designed to ensure Nano Banana strictly maintains the exact structural layout, dimensions, and placement of elements (walls, doors, shelving, fixtures) when rendering a bedroom. This is a constraint-focused prompt for architectural rendering.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772519723088_7vauaz_HCaB0LFbIAABmSb.jpg', 0),
(NULL, 'Video Game Wiki Style Plunger', 'a plunger in the style of a video game wiki website\'s page', 'An image generation prompt for Google Gemini 3.1 via Nano Banana Pro, instructing the AI to create an image of a plunger rendered in the style of a video game wiki website\'s page.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772433524665_r15wio_HCEJKavaMAE1o8j.jpg', 0),
(NULL, 'Modern Minimalist Interior Design Presentation Board', 'Based on the uploaded 2D floor plan, generate a professional interior design presentation board in a single image. Layout : The final image should be a collage with one large main image at the top, and several smaller images below it. Content of Each Panel :

1. Main Image (Top) : A wide-angle perspective view of the main living area , showing the connection between the living room and dining area.

2. Small Image (Bottom Left) : A view of the Master Bedroom , focusing on the bed and window.

3. Small Image (Bottom Middle) : A view of the Home Office / Study room .

4. Small Image (Bottom Right) : A 3D top-down floor plan view showing the furniture layout. Overall Style : Apply a consistent Modern Minimalist style with warm oak wood flooring and off-white walls across ALL images. Quality : Photorealistic rendering, soft natural lighting.
Image Ratio 3:4', 'A prompt for generating a professional interior design presentation board based on an uploaded 2D floor plan. The output should be a collage featuring a large main image of the living/dining area and three smaller images showing the Master Bedroom, Home Office, and a 3D top-down floor plan, all rendered in a consistent Modern Minimalist style.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772346684789_0n5kmy_HCNiK1QaMAAFRnN.jpg', 0),
(NULL, 'Nano Banana Pro Prompt: 9:16 Wallpaper Generation', 'Make a beautiful 9:16 wallpaper. Leave natural negative space near the top and bottom. Give the wallpaper a subtle top to bottom gradient. No blur effects or cropping. Keep the scene simple.
({argument name=\"image concept\" default=\"[Enter the image concept you want to generate]\"})', 'A template prompt for Nano Banana Pro to generate high-quality 9:16 wallpapers suitable for mobile devices, emphasizing natural negative space, subtle gradients, and simplicity.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772001543764_6jyaz9_HB6DubIaoAA1t_C.jpg', 0),
(NULL, 'Origami Kitchen Cutaway', 'A large-scale origami-style kitchen cutaway in color, filling most of the frame. All elements are made from folded paper planes: cabinets, countertops, island, backsplash, floor, window, and appliances simplified into geometric forms. Soft pastel colors (warm white cabinetry, pale sage or soft blue accents, light wood tones). Clear fold lines, layered paper depth, visible paper texture. Natural daylight, subtle shadows, modern minimal kitchen aesthetic.', 'A prompt for generating a large-scale, origami-style cutaway of a modern kitchen, where all elements (cabinets, island, appliances) are rendered as folded paper planes, specifying soft pastel colors, visible fold lines, and natural daylight.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772001503565_6xqmmv_HB53rLUa0AA_O14.jpg', 0),
(NULL, 'Origami Living Room Architecture Concept', 'A large-scale origami-style living room cutaway in color, filling most of the frame. The entire space is constructed from folded paper planes: sofa, coffee table, floor, walls, window, shelving, and decor, all formed with crisp, architectural folds. Soft pastel palette ({argument name=\"color palette\" default=\"warm beige walls, muted gray sofa, soft terracotta accents, light wood tones\"}). Visible paper texture throughout. Natural daylight, gentle shadows between folds, clean geometry, premium modern interior feel.', 'A detailed prompt for generating a large-scale origami-style living room cutaway, emphasizing architectural folds, a soft pastel palette, and clean geometry for a premium modern interior feel.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772001510077_j423j7_HB5Q8lGa4AAO6WU.jpg', 0),
(NULL, 'Top-Down Flat Lay of Dog Formed from Keyboard Keycaps', 'Create a photorealistic 8K top-down flat lay composition of a dog formed entirely from real mechanical keyboard keycaps. The keycaps should be matte PBT plastic in OEM or Cherry profile, arranged in a tight, uniform grid. Every keycap must include crisp, realistic legends—letters, numbers, punctuation, function keys, arrows, and symbols—printed in double-shot or dye-sublimated style. No blank keycaps are allowed. The distribution of legends should feel naturally randomized, as if sourced from real keyboards, with believable variation.

The keycaps must be precisely arranged to form a clean, clearly recognizable side-profile silhouette of a dog. The silhouette should be sharp and well-defined, with smooth contour transitions that accurately capture the dog’s head, ears, body, legs, and tail. Outside the silhouette, there should be pure white negative space with no additional objects or distractions.

The background must be seamless, pure white. The composition should have a 16:9 aspect ratio and be perfectly centered in frame. The camera angle must be an exact 90-degree overhead view with minimal perspective distortion, maintaining a completely flat surface appearance.

Lighting should be soft, diffused studio lighting with very gentle contact shadows beneath each keycap and subtle edge highlights that emphasize the plastic texture. Avoid harsh shadows or dramatic contrast. The overall result should feel ultra-sharp, clean, noise-free, and highly detailed, showcasing realistic material texture and precise arrangement.', 'A detailed prompt for creating a photorealistic, top-down flat lay image of a dog silhouette formed entirely from mechanical keyboard keycaps, emphasizing precise arrangement, realistic legends, and soft studio lighting on a pure white background.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1772001523931_vt3vmu_HB4yLIaboAARdHP.jpg', 0),
(NULL, 'MacBook Mockup with User from Behind', 'Create a MacBook mockup placed in a minimalist room. Use the attached image on the laptop screen. A woman is sitting at the desk, using the computer, shown from behind. https://t.co/Kerh2vHqqE', 'A simple prompt for creating a photorealistic mockup of a MacBook in a minimalist room, featuring a woman sitting at the desk using the computer, viewed from behind. This prompt requires an attached image to be used on the laptop screen.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1771914980536_616501_HBz6dtPXMAEcrRF.png', 0),
(NULL, 'Vertical Split-Screen Branding Composition', 'A vertical split-screen composition. Left side: A high-resolution full-body photograph of a handsome man with a neat beard and dark hair, wearing a crisp white dress shirt tucked into navy blue trousers and brown leather oxford shoes. He is posing against a clean grey wall. Right side: A minimalist, black and white geometric low-poly vector illustration of the same man\'s face. Above the illustration, the bold sans-serif text \'{argument name=\"name\" default=\"BOB\"}\' is stacked over the word \'{argument name=\"profession\" default=\"Designer\"}\'. Professional branding aesthetic, clean and modern.', 'A prompt for creating a vertical split-screen image composition used for professional branding. The left side features a high-resolution photograph of a handsome man in business attire, and the right side displays a minimalist, black and white geometric low-poly vector illustration of his face, overlaid with the bold text \'BOB Designer\'.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1771828713855_2gs7n8_HBvk3V1bgAEVLrw.jpg', 0),
(NULL, 'Wabi-Sabi Veil Aesthetic Prompt', '{
  \"name\": \"Wabi-Sabi Veil\",
  \"type\": \"image\",
  \"description\": \"A subtle, imperfectly aged and weathered effect applied to the [OBJECT/PRODUCT/LOGO], embodying the Wabi-Sabi philosophy of finding beauty in imperfection, transience, asymmetry, and natural decay. The surface shows gentle patina with faint cracks that add character like a cherished cracked bowl, subtle discoloration from time\'s touch revealing proof of life, irregular textures like hand-thrown pottery with uneven glazing that\'s interesting rather than flawed, soft erosion at edges as if worn by wind and water evoking well-loved wear, minimalist simplicity with organic irregularities, muted natural imperfections such as tiny fissures filled with faint moss-like accents or tea-stain blooms that highlight resilience, and a sense of quiet humility in the object\'s form, levitating freely in space to highlight its humble beauty without distraction, rejecting polished perfection for memorable authenticity.\",
  \"negative_description\": \"No glossy perfection, no symmetrical precision, no vibrant artificial colors, no modern sleekness or polished chrome, avoid uniform textures, no digital sharpness or CGI smoothness, no ornate decorations or complexity, no bright highlights or harsh contrasts, no futuristic or mechanical elements, no cartoonish exaggeration, no heavy decay or broken appearance, no hidden cracks or over-polished surfaces.\",
  \"style\": \"In the authentic Japanese Wabi-Sabi aesthetic, blending the rustic simplicity of traditional tea ceremony ceramics with the aged elegance of Zen garden stones, hyper-realistic digital rendering mimicking ancient craftsmanship by artists like Isamu Noguchi or Tadao Ando, with subtle influences from organic minimalism and imperfection-focused photography akin to Hiroshi Sugimoto\'s serene seascapes.\",
  \"composition\": \"Centered asymmetrical floating composition in a soft three-quarter view to emphasize natural irregularities and volumetric depth, with the object occupying central focus but offset slightly for organic imbalance, generous white negative space surrounding to evoke solitude and introspection, rule of thirds placing key imperfections like cracks or patina blooms at intersection points for subtle visual poetry.\",
  \"camera_settings\": {
    \"lens\": \"50mm prime lens for natural perspective and intimate detail capture without distortion.\",
    \"aperture\": \"f/5.6 for balanced depth of field, keeping subtle textures in focus while allowing gentle fall-off.\",
    \"shutter_speed\": \"1/125s to capture stillness with a hint of natural motion blur in any faint steam or dust motes.\",
    \"iso\": \"200 for subtle grain that enhances the aged, organic feel without excessive noise.\"
  },
  \"lighting\": {
    \"type\": \"Soft, diffused natural daylight with minimal contrast for humble illumination.\",
    \"direction\": \"Gentle overhead light mimicking overcast sky from above, with subtle side fill from left to soft', 'A highly detailed JSON prompt for Nano Banana Pro defining an aesthetic filter called \'Wabi-Sabi Veil\'. It instructs the AI to apply a subtle, imperfectly aged and weathered effect to an object, embodying the Wabi-Sabi philosophy (beauty in imperfection, transience) using specific textures (patina, faint cracks, irregular textures) and lighting (soft, diffused natural daylight) for a hyper-realistic digital rendering mimicking ancient craftsmanship.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1771741702297_4rgqc5_HBq8FyXWMAAcLVx.jpg', 0),
(NULL, 'Flat Vector Llama Emoji Prompt', 'Flat vector emoji sheet of a llama face only, front view, close-up head portrait, no full body, no hands, no pose outside the face, pure 2D flat vector...', 'A prompt for Google Nano Banana Pro requesting a pure 2D flat vector emoji sheet of only a llama face, emphasizing a close-up head portrait and excluding full body, hands, or complex poses.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1771655080850_1p34xu_HBnAJi7b0AEg5Fm.jpg', 0),
(NULL, 'Minimalist Wallpaper Generation Prompt', 'Make a beautiful 9:16 wallpaper. Leave natural negative space near the top and bottom. Give the wallpaper a subtle top to bottom gradient. No blur effects or cropping. Keep the scene simple.

Put your subject and style at the end of the prompt.', 'A simple prompt instructing the AI to create a beautiful 9:16 wallpaper with a subtle top-to-bottom gradient, ensuring natural negative space at the top and bottom, and keeping the scene simple without blur effects or cropping.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1771483117173_jlr3oi_HBeAe4qXEAAJL40.jpg', 0),
(NULL, 'Neon Sign Text on Concrete Surface', 'A flat view of \"{argument name=\"neon text\" default=\"LOVART AI Design Agent\"}\" constructed from thin, soft pink or white neon tubes, placed flat on a concrete surface. The atmosphere is industrial yet elegant, with clean lines and a moody feel. Urban, modern, high fashion.', 'An image generation prompt for the Lovart model (using Nano Banana Pro) to create a neon sign of specific text on a concrete surface, emphasizing an industrial, elegant, and moody aesthetic.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1771483149229_3997lu_HBCRAb_bgAAm-fV.jpg', 0),
(NULL, 'Lavart Agent Text Correction for Jugemu Prompt', 'The corrected text is as follows:

“Jugemu Jugemu Gokou no Surikire Kaijari Suigyo no Suigyomatsu Unraimatsu Furaimatsu Kuuneru Tokoro ni Sumu Tokoro Yaburakouji no Yabukouji Paipo Paipo Paipo no Shuringan Shuringan no Gurindai Gurindai no Ponpokopi no Ponpokona no Choukyumei no Chousuke”

Now, we will generate a design where this text spirals clockwise from the top left, with the last characters, “Chousuke,” coming to the center.', 'This tweet shows the corrected Japanese text generated by the Lavart agent before feeding it to Nano Banana Pro, based on the complex text spiral prompt (Jugemu story) from a previous tweet. This demonstrates the agent\'s pre-processing capability.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770878362770_5v6b2q_HA3gTQ1asAA42UY.jpg', 0),
(NULL, 'Japanese Text Spiral Generation Prompt (Jugemu)', 'The Japanese text within the following quotation marks, arranged in a band, is spiraling clockwise from the top left, with the last characters coming to the center.
“{argument name=\"text\" default=\"Jugemu Jugemu Gokou no Surikire\\n\\nKaijari Suigyo no Suigyomatsu Unraimatsu Furaimatsu\\n\\nKuuneru Tokoro ni Sumu Tokoro\\n\\nYaburakouji no Burakouji\\n\\nPaipo Paipo Paipo no Shuringan\\n\\nShuringan no Gurindai\\n\\nGurindai no Ponpokopi no Ponpokona no\\n\\nChoukyumei no Chousuke\"}”
Please revise and correct the text to ensure proper Japanese notation.', 'A complex prompt designed to test text generation capabilities, requiring the long Japanese text of the \'Jugemu\' story to be arranged in a clockwise spiral starting from the top left, with the final characters centered. This prompt was used to compare Seedream 5.0 and Nano Banana Pro.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770878362482_f3pgfr_HA3dmkcbEAAU2sB.jpg', 0),
(NULL, 'Multi-Step Design Generation for \'Lovart\' Brand Identity', 'A logo mark for a company named \'Lovart\' with a base color gradient of vibrant {argument name=\"color 1\" default=\"emerald green\"} and vibrant {argument name=\"color 2\" default=\"blue\"}

Generate a color palette and font design guidelines from this logo mark

Generate the application UI design for this service. PC version and smartphone version

Design a website to introduce this service. PC version and smartphone version

Design image for the exhibition booth of this service

Merchandise design for this service. T-shirt, hoodie, cap, notebook, sticker', 'A multi-step workflow prompt sequence for Nano Banana Pro, designed to create a cohesive brand identity for a company named \'Lovart\'. The steps cover generating the logo, creating design guidelines (color palette, font), and then applying that identity to various assets like application UI, website design, exhibition booth, and merchandise.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770706233215_4x5j1y_HAuODnmbEAAGP8U.jpg', 0),
(NULL, 'Character Sheet and Illustration Generation for Bakumatsu Agents', 'Gather the team members again. Activate the nanobanana pro slide generator skill for the Bakumatsu Agent Team. Then, proceed with the following steps: 1. Create reference images (a) Collect images of the three people: {argument name=\"person 1\" default=\"Sakamoto Ryoma\"}, {argument name=\"person 2\" default=\"Hijikata Toshizo\"}, and {argument name=\"person 3\" default=\"Kondo Isami\"} from Wikipedia or similar sources. (b) Use these as reference and base images to create character sheets with nanobanana pro. (c) Create character illustrations based on the consistent reference images. 2. Visualize the document (a) Create insertion illustrations for each chapter of the finalized report using nanobanana pro. (b) Insert the created images into the preview within the MD (Markdown) file. (c) Arrange the insertion illustrations for each H1, H2, and H3 section and for Tips to structure the document clearly. Divide this work among the three people to proceed most effectively.', 'A complex, multi-step prompt designed to use Nano Banana Pro\'s slide generator skill to create consistent character sheets and illustrations for a team of Bakumatsu agents (Sakamoto Ryoma, Hijikata Toshizo, Kondo Isami), based on reference images from Wikipedia.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770532856467_be0ym0_HAkHfXga4AAADlj.jpg', 0),
(NULL, 'Minimal Layout Stress Test Composition', 'Ultra-minimal layout composition.
Single abstract element placed with intention,
large areas of negative space,
perfect alignment and proportion,
soft ambient lighting,
neutral tones only,
designed to feel deliberate and confident.', 'A prompt designed to test the AI\'s ability to handle ultra-minimalist composition. It focuses on perfect alignment, large areas of negative space, and a single abstract element, using only neutral tones and soft ambient lighting to create a deliberate and confident design.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770446104474_iill6q_G_dNyzyXUAAdnxD.jpg', 0),
(NULL, 'Futuristic Fluffy Glass Typography Art', '{
  \"model\": \"Nano Banana Pro \",
  \"aspect_ratio\": \"16:9\",
  \"style\": \"futuristic fluffy glass typography\",
  \"prompt\": {
    \"subject\": \"Futuristic AI name art\",
    \"text\": \"{argument name=\"text to render\" default=\"Future AI\"}\",
    \"text_position\": \"center\",
    \"text_design\": {
      \"font_style\": \"stylish futuristic custom typography\",
      \"texture\": \"soft fluffy fibers blended with transparent glass effect\",
      \"material\": \"frosted glass + plush fluffy surface\",
      \"shape\": \"bold, smooth, slightly curved futuristic letters\",
      \"depth\": \"high 3D depth with glass-like thickness\",
      \"edges\": \"rounded glass edges with soft fluffy diffusion\",
      \"finish\": \"premium, glossy, futuristic aesthetic\"
    },
    \"color_palette\": {
      \"text_colors\": [
        \"cyan\",
        \"electric purple\",
        \"neon pink\",
        \"aqua blue\"
      ],
      \"gradient\": \"multi-color futuristic gradient flowing through glass text\"
    },
    \"lighting\": {
      \"type\": \"soft futuristic studio lighting\",
      \"highlights\": \"glass reflections with subtle glow\",
      \"shadows\": \"soft ambient shadow beneath text\"
    },
    \"background\": {
      \"type\": \"plain attractive futuristic canvas\",
      \"color\": \"smooth gradient background ({argument name=\"background color\" default=\"deep blue to purple\"})\",
      \"texture\": \"clean matte with soft light falloff\",
      \"match_with_text\": \"harmonized futuristic color tones\"
    },
    \"composition\": {
      \"focus\": \"hero glass-fluffy name typography\",
      \"style\": \"clean, modern, high-end\",
      \"balance\": \"perfectly centered\"
    },
    \"quality\": {
      \"resolution\": \"ultra HD\",
      \"detail\": \"high-detail glass refraction and fluffy fibers\",
      \"sharpness\": \"crisp edges with soft diffusion\"
    }
  },
  \"negative_prompt\": [
    \"simple flat font\",
    \"opaque solid text\",
    \"rough glass\",
    \"dirty texture\",
    \"busy background\",
    \"extra objects\",
    \"logo\",
    \"watermark\",
    \"grain\",
    \"blur\"
  ]
}', 'A detailed JSON prompt for generating high-end 3D typography art. It focuses on rendering the text \'Future AI\' using a unique combination of frosted glass and plush fluffy fibers, set against a futuristic gradient background with soft studio lighting and high 3D depth.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770446058022_w9coqw_HAfEasPaYAAVBd7.jpg', 0),
(NULL, 'Architectural Floor Plan and Realistic Interior Photo Generation', 'Split composition, clearly divided into left and right halves.

Left half:
Detailed architectural floor plan illustration in modern minimalist style, matching the reference. Top-down view of the residential layout, labeling the living room, dining room, open kitchen, bedroom, foyer, balcony, bay window, and flow lines. Beige and warm gray tones, clear lines, soft shadows, subtle textures, interior design presentation style. Professional architectural visualization, blueprint aesthetic, clear furniture layout.

Right half:
Hyper-realistic interior photography of the living room shown in the floor plan. The living room is fully furnished, and the spatial layout precisely corresponds to the floor plan: {argument name=\"furniture combination\" default=\"curved sofa set, central coffee table, soft rug, warm wooden floor, neutral walls, natural light from large windows\"}. Modern, comfortable, contemporary interior design, earth tones, soft light, realistic materials, and life details.

Right half should resemble a real interior photograph, while the left half maintains a clear architectural drawing. The two parts are visually aligned, clearly demonstrating the \'concept versus reality\' contrast.

Style and Atmosphere

Architectural visualization meets real interior photography
Modern, warm, elegant residential design
Concise, professional, design studio presentation
Contrast from concept to realization

Lighting and Color

Left: Average lighting, neutral tones
Right: Natural daylight, soft shadows, warm highlights
Floor plan and room colors are harmoniously unified

Camera and Technical Details

Left: Top-down orthogonal view
Right: Interior wide-angle lens, eye-level perspective
High resolution, clear details, realistic textures

Negative Prompts:
Cartoon style, low detail, cluttered interior, inconsistent layout, unrealistic proportions, harsh lighting, exaggerated colors, text overlay, watermark', 'A detailed prompt for Nano Banana Pro designed to generate a split-composition image: the left side displays a detailed, minimalist architectural floor plan illustration, and the right side shows a hyper-realistic interior photograph of the corresponding living room, emphasizing the contrast between concept and reality. It specifies style, lighting, color palettes, and technical details for both halves.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770273487845_ffq4i6_HAS7qE7bsAAE3VO.jpg', 0),
(NULL, 'Nano Banana Pro Thumbnail Generation Example', '[ Theme ]
Advertisement for an accounting efficiency tool

This is a standard layout. People read from the top left and their gaze flows to the bottom right. The arrangement follows this rule. It continues with the main copy, sub-copy, and CTA button. The right side is the eye-catcher, whose role is to attract attention, evoke empathy, and make the viewer feel personally connected.', 'This tweet describes the layout and design principles for a thumbnail generated by Nano Banana Pro, specifically for an advertisement about an accounting efficiency tool. It explains the visual flow (top-left to bottom-right) for optimal viewer engagement, but the actual prompt text is mentioned to be in the replies (which are not provided).', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770187207321_l0fn8e_HAROPCBaYAA7MIa.jpg', 0),
(NULL, 'Editorial Background Visual Prompt for Premium Magazine Layouts', 'Editorial-style background visual.
Soft natural light with subtle directional shadows,
calm neutral tones,
organic depth with foreground blur,
ample negative space for text,
timeless and understated,
like a premium magazine layout backdrop.', 'A concise image generation prompt designed to create high-quality, expensive-looking editorial background visuals. It emphasizes soft natural light, neutral tones, and ample negative space, making it ideal for use as a backdrop in premium magazine layouts or marketing materials.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770187146032_b6e04s_G_dMx8jXMAA_FCZ.jpg', 0),
(NULL, 'Stylized Tech Illustration Template', 'A stylized illustration of {argument name=\"product or technology\" default=\"[PRODUCT / TECHNOLOGY]\"} visualized as {argument name=\"futuristic metaphor\" default=\"[FUTURISTIC METAPHOR]\"}. Isometric or 3D-inspired illustration, smooth surfaces, glowing accents.

Color scheme: {argument name=\"color scheme\" default=\"[NEON / DARK MODE / PASTEL TECH]\"}.
Clean background, soft shadows, premium startup aesthetic.

(Great for SaaS visuals, AI tools, landing pages.)', 'A template prompt for generating stylized product or technology illustrations, ideal for SaaS visuals or landing pages. It uses an isometric or 3D-inspired style, smooth surfaces, glowing accents, and a clean, modern aesthetic.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770187114900_6ywqrt_HAO1yGvaUAACtyq.jpg', 0),
(NULL, 'Conceptual Visual for Vision to Execution', 'Conceptual visual representing the transition from vision to execution.
Abstract forms evolving into structured elements,
controlled lighting,
balanced composition,
modern, grounded tone,
designed to communicate clarity and momentum.', 'A conceptual prompt designed to generate an abstract visual representing the transition from an initial \'vision\' to \'execution\'. It focuses on abstract forms evolving into structured elements, controlled lighting, and a modern, balanced composition to communicate clarity and momentum.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770187123206_marug9_G_K9SxSW0AAxmtK.jpg', 0),
(NULL, 'Ultra-high-end Abstract Composition', 'Ultra-high-end abstract composition.
Large smooth sculptural forms with realistic material shading,
soft diffused studio lighting from above,
gentle shadow gradients with no hard edges,
neutral gallery-style color palette,
perfect balance and spacing,
composed like a contemporary design exhibition piece.', 'A prompt designed to stress-test visual quality by generating an ultra-high-end abstract composition. It specifies large, smooth sculptural forms, soft diffused studio lighting, gentle shadow gradients, and a neutral gallery-style color palette, aiming for a contemporary design exhibition piece aesthetic.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770100868436_ozqc8w_G_dMh_UX0AA0dX_.jpg', 0),
(NULL, 'Minimalist Startup Presentation Cover Visual Prompt', 'Cover visual for a premium startup presentation.
Minimal layout,
strong visual hierarchy,
abstract brand motif,
ample negative space,
designed to set tone without overwhelming content.', 'A prompt designed for generating a minimalist, high-impact cover visual for a premium startup presentation. The focus is on restraint, strong visual hierarchy, abstract branding, and ample negative space to set a confident tone without overwhelming the content.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770100806599_g7qxko_G_K9BT-WUAAuyTG.jpg', 0),
(NULL, 'Prompt for Generating Architectural Floor Plan and Photorealistic Interior Comparison', 'The image uses a left-right split composition, with a clear boundary between the left and right halves, aligned overall, presenting a comparison effect of \"concept map versus actual implementation\".
The left half is a highly detailed modern minimalist architectural floor plan illustration, consistent with the reference image style. It shows a top-down orthogonal projection of the residential layout, clearly labeling spaces and circulation: living room, dining area, open kitchen, bedroom, entrance hall, corridor and flow lines, balcony or loggia space, bay window, and window opening locations. The color scheme uses neutral beige and warm gray, with clean lines, slight soft shadows, and delicate material textures, showcasing the quality of the interior design plan, presented in a blueprint-style flat visual, with visible and accurately scaled furniture placement.
The right half is an ultra-realistic interior photo effect of the same living room as the left floor plan, with spatial proportions and layout strictly corresponding to the floor plan. The living room includes a curved sofa set, a central coffee table, soft carpet, warm wooden floor, neutral walls, and large windows introducing natural light. The overall style is modern and warm home atmosphere, with earthy tones and soft lighting, realistic and tactile materials, details that feel lived-in yet remain neat and restrained. The right side presents a real interior photography texture, with clear textures and high-resolution details.
The style and atmosphere combine architectural visualization with real interior photography, modern, warm, elegant, conveying the professional design studio presentation feel, emphasizing the contrast between the plan and the actual scene.
Lighting and color requirements: The left side uses uniform flat light and neutral colors, while the right side uses natural daylight with soft shadows and warm highlights; the colors on both sides maintain a unified harmonious relationship.
Lens and technical requirements: The left side is a top-down orthogonal view, and the right side is a flat view using an interior wide-angle lens, with sharp image clarity, rich real materials, and details.
Negative prompt: cartoon style, rough details, messy interior, mismatch between floor plan and actual scene, distorted proportions, overly harsh light, exaggerated saturated colors, text overlay, watermark, logo, noise, blur.', 'A detailed prompt for Nano Banana Pro to generate a split-screen image comparing an architectural floor plan (left side) and a photorealistic interior rendering (right side) of the same space (a living room). It specifies composition, style, color palette, lighting, camera angles, and detailed elements for both the technical blueprint and the warm, modern interior shot.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1770100852289_d2xj4a_HAIWy6za4AA0z1y.jpg', 0),
(NULL, 'Top-Down Flat Lay of Custom-Shaped Conference Table', 'Ultra-wide-angle hyper-realistic top-down flat lay photography. The central focus is a custom physical conference table meticulously shaped like {argument name=\"Shape\" default=\"[SHAPE/NUMBER/SYMBOL]\"}.

The table features {argument name=\"Material\" default=\"[MATERIAL/TEXTURE/COLOR]\"} and placed on a [FLOOR COLOR] floor, creating significant negative space around it for a clean, minimalist composition. A group of {argument name=\"Number of People\" default=\"[NUMBER]\"} real people are sitting around the edges of this [SHAPE]-shaped table. [POSITIONING: e.g., 3 on each side, 1 top/bottom]

Actions: [DESCRIBE PEOPLE\'S ACTIONS, e.g., working on laptops, drinking coffee].
Lighting & Quality: Professional studio lighting with crisp, distinct drop shadows that define the [SHAPE] silhouette on the floor. 8k resolution, sharp focus, cinematic commercial aesthetic.', 'A customizable prompt for generating a hyper-realistic, ultra-wide-angle top-down flat lay photograph of a conference table shaped like a specific object or symbol. The prompt requires defining the table\'s shape, material, and the actions of the people seated around it, emphasizing professional studio lighting and crisp drop shadows.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769927672921_b0uh8t_HAAnE-zXoAIVugE.jpg', 0),
(NULL, 'Top-Down Flat Lay of Custom-Shaped Conference Table (Duplicate)', 'Ultra-wide-angle hyper-realistic top-down flat lay photography. The central focus is a custom physical conference table meticulously shaped like {argument name=\"Shape\" default=\"[SHAPE/NUMBER/SYMBOL]\"}.

The table features {argument name=\"Material\" default=\"[MATERIAL/TEXTURE/COLOR]\"} and placed on a [FLOOR COLOR] floor, creating significant negative space around it for a clean, minimalist composition. A group of {argument name=\"Number of People\" default=\"[NUMBER]\"} real people are sitting around the edges of this [SHAPE]-shaped table. [POSITIONING: e.g., 3 on each side, 1 top/bottom]

Actions: [DESCRIBE PEOPLE\'S ACTIONS, e.g., working on laptops, drinking coffee].
Lighting & Quality: Professional studio lighting with crisp, distinct drop shadows that define the [SHAPE] silhouette on the floor. 8k resolution, sharp focus, cinematic commercial aesthetic.', 'A customizable prompt for generating a hyper-realistic, ultra-wide-angle top-down flat lay photograph of a conference table shaped like a specific object or symbol. The prompt requires defining the table\'s shape, material, and the actions of the people seated around it, emphasizing professional studio lighting and crisp drop shadows. (Duplicate of 2017655603405942826).', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769927676499_7dhvvn_HAAaWTtXkAAiA6-.jpg', 0),
(NULL, 'Cinematic Sci-Fi Landscape and Fintech UI Design Prompts', 'This one for Nano Banana Pro 4k:
Cinematic sci-fi landscape, a massive pale celestial moon dominating the sky partially obscured by layers of thick clouds, a rugged rocky coastline with sparse ancient vegetation on the left, calm water in the foreground reflecting the scene, a solitary silhouette of a person standing on a rock ledge for scale, heavy atmospheric blue mist and fog, soft diffuse lighting, ethereal and dreamlike mood, cool color palette of icy blues and whites, high-quality digital matte painting, 4k resolution, photorealistic concept art.

This for the frontend:
High-fidelity UI design overlay for a modern fintech SaaS landing page, minimalist navigation bar with \"Flowstate\" logo and centered menu links, \"Get Started\" button in top right, centered hero section layout, pill-shaped transparent badge reading \"INFRASTRUCTURE FOR NEXT FINANCIAL LAYER\", large bold sans-serif headline \"Trust-first infrastructure for digital finance\", clean paragraph subtext below, primary solid black rounded button next to a secondary text link button, bottom row featuring monochrome trusted company logos (Google, Microsoft, Stripe), glassmorphism effects, white typography, transparent background, sleek Figma interface design', 'This tweet provides two separate prompts: one for Nano Banana Pro (4k) to generate a cinematic sci-fi landscape featuring a massive celestial moon, rocky coastline, and heavy blue atmospheric mist; and a second prompt for a frontend tool to generate a high-fidelity UI design overlay for a modern fintech SaaS landing page.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769927701995_t5urzt_G__-unmW4AApvax.jpg', 0),
(NULL, 'Consulting-Grade Presentation Cover Visual Prompt', 'Clean case-style visual layout.
Structured grid composition,
subtle abstract data cues (lines, blocks, rhythm),
neutral professional color palette,
soft lighting with no dramatic contrast,
designed to feel credible, calm, and serious,
like a consulting-grade presentation cover.', 'A prompt designed to generate a clean, professional, case-style visual layout suitable for a consulting presentation cover, featuring a structured grid, abstract data cues, a neutral color palette, and soft lighting to convey credibility and seriousness.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769841121075_od5eq6_G_dLXpPWAAEUMsL.jpg', 0),
(NULL, 'Minimal Abstract Vector Illustration Style', 'Minimal abstract illustration.
Flat but layered vector-style shapes,
precise curves, consistent stroke logic,
limited color palette with high harmony,
balanced spacing and alignment,
designed to feel systemized and scalable,
like a mature brand illustration set.', 'A prompt designed for generating premium, systemized abstract illustrations. It specifies the use of flat, layered vector-style shapes, precise curves, consistent stroke logic, a limited color palette with high harmony, and balanced alignment, suitable for mature brand illustration sets.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769754984184_7oa9j9_G_dLLRsXYAAyW5x.jpg', 0),
(NULL, 'Abstract Brand Illustration for Innovation and Clarity', 'Abstract brand illustration representing {argument name=\"concept 1\" default=\"innovation\"} and {argument name=\"concept 2\" default=\"clarity\"}.
Geometric forms with subtle depth,
smooth gradients, controlled contrast,
modern, restrained color palette,
timeless and non-trendy aesthetic,
designed for long-term brand use.', 'A concise prompt for generating an abstract brand illustration. It specifies the representation of innovation and clarity using geometric forms, smooth gradients, and a modern, restrained color palette, emphasizing a timeless and non-trendy aesthetic suitable for long-term brand use.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769755002609_otsj1v_G_K6mmfWIAAONxW.jpg', 0),
(NULL, 'High-End Product Catalog Style Prompt (Nano Banana Pro)', '✓ Reference Image: Use the uploaded image as a precise visual reference for the product\'s form, proportion, material, and overall identity. Do not redesign or reinterpret the product.

✓ Layout: Vertical 3:4 canvas, background is a warm neutral paper surface, the upper part is the lifestyle hero area, and the lower part is the technical specification area.

✓ Upper Section: The product image is placed in the top center, dominating the space, with ample white space around it.

✓ Environment Setting: Minimalist architectural interior, natural side lighting, soft high-contrast shadows, concrete floor, textured stucco walls.

✓ Rendering Style: Editorial lifestyle photography, highly realistic, warm and soft high-end color grading.

✓ Lower Section: Technical specification panel uses a modular grid layout. The bottom left features architectural line drawings (front view, side view, three-quarter top view), soft red or sepia thin lines, with minimal annotations.

✓ Bottom Right: 3-4 material samples, derived from the product\'s actual materials ({argument name=\"material type\" default=\"fabric, leather, metal, wood, plastic\"}).

✓ Typography: Minimalist editorial style, soft black or dark brown, no large titles.

✓ Overall Style: Design catalog/product design journal, architectural, high-end, calm. Avoid clutter, bold colors, heavy branding, excessive decoration.

✓ Constraints: Do not change the product design, do not fabricate materials, do not add logos unless present in the reference, do not use perspective distortion in the drawings.', 'A detailed image generation prompt for Nano Banana Pro focused on creating a high-end, architectural product catalog layout. It specifies a vertical 3:4 canvas split between a lifestyle hero shot and a technical specification panel, including material samples and line drawings.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769755040577_518wxr_G_y7n35bYAAIK4m.jpg', 0),
(NULL, 'Luxury Coffee Tasting Menu Layout Prompt', 'Luxury coffee tasting menu layout, irregular grid composition, 9:16 aspect ratio for webpage.
LAYOUT: Irregular 3x3 grid, varied cell sizes, flowing editorial arrangement
BACKGROUND: Tone-on-tone panels - alternating {argument name=\"color 1\" default=\"latte beige (#F2E2D2)\"}, {argument name=\"color 2\" default=\"mocha brown (#D1B48F)\"}, and coffee cream (#FAF5E6) creating a subtle caffeinated rhythm
PRODUCT EXPRESSION: Product only, overhead and 45-degree angles mixed, plated presentation on minimalist slate ceramics
TONE STRATEGY: Tone-on-tone - coffee colors harmonize with background tones, an ethereal blend
MAIN ELEMENTS: Individual coffee tastings - Espresso with crema foam, Cappuccino toast with gold dust, Caviar on blinis substituted with coffee caviar on biscotti, Latte with lemon twist, Mocha tartlet, each on matching plates, consistent soft lighting
TYPOGRAPHY: Bilingual - English names in elegant light serif (Didot), English/Korean below in clean sans-serif, small origin descriptions in light gray
CAMERA: Canon EOS R5, 100mm Macro for details, 50mm for full plates, soft diffused overhead lighting, side rim lighting
STYLE: Minimal + Luxury hybrid - generous whitespace, refined typography, coffee colors as primary source
Style keywords: coffee, tasting menu, tone-on-tone, luxury, webpage

A delicate handwritten signature \"Willy\" is elegantly placed in small letters at the bottom right corner..', 'A highly structured prompt for generating a luxury, minimalist, tone-on-tone coffee tasting menu layout for a webpage, specifying the grid composition, color palette, product presentation, typography, and camera details.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769755016032_wyepkb_G_y43_7bUAAIIor.jpg', 0),
(NULL, 'Conceptual Rebrand Reveal Visual Prompt', 'Conceptual rebrand reveal visual for a modern tech company.
Abstract transformation motifs,
before-and-after visual tension,
soft directional lighting, restrained palette,
confident, forward-looking tone,
crafted like a global agency rebrand case study.', 'A concise prompt for generating a conceptual visual for a modern tech company\'s rebrand reveal. It focuses on abstract transformation motifs, visual tension between \'before-and-after\' states, soft directional lighting, and a restrained color palette, aiming for a confident, forward-looking tone suitable for a global agency case study.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769668465853_bh7oog_G_JD9BeXgAA4YRV.jpg', 0),
(NULL, 'Minimalist Flowchart/Diagram Generation Style Guide', 'Generate image, 1. Style Core Parameter Extraction (Style Guide)
Please refer to the following parameters:
Color Palette:
Background: Pure white (#FFFFFF)
Lines/Borders: Dark gray or pure black (#333333 or #000000)
Text: Dark gray (#333333), regular weight, no bold.
Fill: No fill (transparent) or pure white fill, to cover lines behind.
Lines/Connectors:
Type: Orthogonal/Elbow lines, meaning only vertical and horizontal lines, with right-angle corners.
Thickness: Extremely thin (1px).
Arrow: Solid small triangle (Solid Arrowhead), black.
Shapes:
Normal Node: Rounded Rectangle, very small corner radius (approx. 4px - 8px).
Decision Node: Diamond.
Start/End: Capsule shape or rectangle with larger rounded corners.
Typography:
Alignment: Center aligned.
Font: Sans-serif font, such as Arial, Roboto, or Source Han Sans. Small font size (approx. 12px-14px).

Apply the style above along with your user journey/process to Gemini, and it will present the corresponding effect without needing adjustments.', 'A detailed style guide prompt for Nano Banana Pro to generate minimalist, clean flowcharts or diagrams. It specifies color palette, line types (orthogonal), shapes (rounded rectangles, diamonds), and typography to ensure a professional, consistent, and easily readable infographic style.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769668517280_07mg8l_G_uvxYjWkAEtjek.jpg', 0),
(NULL, 'Line and Shape Hybrid Illustration Prompt', 'Illustrate {argument name=\"subject\" default=\"a cityscape\"} using a combination of thin lines and large flat shapes. Keep the interaction sparse and intentional. The result should feel contemporary and design-forward.', 'A simple, design-focused prompt for generating contemporary illustrations by combining thin lines and large flat shapes, intended for a sparse and intentional aesthetic.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769668505087_viwu7g_G_vxNkMWwAAbPjB.jpg', 0),
(NULL, 'Mixed Reality Retail Experience Prompt', 'First-person perspective inside a brightly lit supermarket aisle or section. Realistic human hands are holding {argument name=\"product name\" default=\"[PRODUCT NAME]\"} close to the camera. The product’s [key visual traits: color, texture, packaging, freshness details] are clearly visible under natural store lighting.

The {argument name=\"product name 2\" default=\"[PRODUCT NAME]\"} is surrounded by a multi-layered holographic augmented reality interface displaying relevant product information, including [nutritional or product data such as calories, protein/sugar/caffeine, vitamins, freshness indicator, origin, expiration date, usage or recipe suggestions].

The AR UI elements smoothly shift and reorganize based on the viewer’s gaze direction, as if dynamically responding to user focus. In the left peripheral vision, a vertical semi-transparent shopping list is visible with checked-off items, where {argument name=\"product name 3\" default=\"[PRODUCT NAME]\"} is highlighted as the currently active selection.

Hyper-realistic mixed reality, clean futuristic AR design, glass-like UI panels, soft ambient glow, realistic lighting and shadows, natural depth of field, immersive first-person interface, showcasing next-generation retail technology.', 'A prompt for generating a hyper-realistic first-person perspective image inside a supermarket aisle, where human hands hold a product surrounded by a dynamic, multi-layered holographic Augmented Reality (AR) interface displaying nutritional data and a highlighted shopping list item.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769668438150_uyprlp_G_t_m35bAAE0BX7.jpg', 0),
(NULL, 'Atmospheric Product Interface Visual Prompt for SaaS UI', 'Atmospheric product interface visual for a modern SaaS platform.
Clean hierarchy, balanced contrast,
soft shadows, neutral color palette,
focus on clarity and calm,
designed like a best-in-class SaaS experience.', 'A prompt designed to generate a luxurious and calm visual representation of a modern SaaS product interface, emphasizing clarity, hierarchy, and a neutral color palette for a premium user experience.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769581933231_911rp4_G_JDloYXQAAXf5_.jpg', 0),
(NULL, 'Nano Banana Pro Handwriting Generation Prompt', 'Use the attached reference images as the handwriting style guide (especially the second image with handwriting samples). Create a single line of Japanese handwritten text on clean white paper. Written with a fine gel pen / fineliner (0.3–0.4mm look), thin and light strokes, mostly monoline (no brush or marker look). Match a stylish, airy, feminine handwriting feel: soft curves, light touch, and a slightly right-leaning slant.Add clear personality through noticeable character size variation (some characters 10–25% larger/smaller), irregular spacing, and a gentle upward baseline from left to right. Add elongated entry and exit strokes (long, tapered starts/tails) on a few characters—especially the first character, any elongated/extended marks in the text, and the final character—while keeping everything readable.Write exactly this text: \"{argument name=\"text to write\" default=\"The true chocolate tasted like an adult\'s.\"}\" No extra text, no borders, no logos, no underline, no decorative swoosh lines. High resolution, sharp thin ink lines, minimal paper texture.
Negative:
brush pen, calligraphy, shodo, marker, thick strokes, bold ink, heavy pressure, paintbrush, blocky lettering, uniform character size, perfect spacing, perfectly straight baseline, printed font, typeset, outline font, extra words, watermark, frame, stamps, underline, swoosh line, doodles
Extra:
Keep strokes thin; create expressiveness mainly with size/spacing/baseline and tapered stroke ends, not thickness.Increase character size contrast and spacing irregularity, but keep legibility.', 'A detailed prompt for Nano Banana Pro designed to generate a single line of Japanese handwritten text in a specific feminine, stylish, and airy aesthetic. It specifies the writing instrument (fine gel pen), stroke characteristics (thin, light, monoline), and introduces intentional irregularities in character size, spacing, and baseline slant to mimic natural handwriting. The prompt explicitly requires reference images for style guidance and includes a negative prompt to avoid brush/calligraphy styles.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769582030644_le72bb_G_o0py4akAABSoj.jpg', 0),
(NULL, 'First-Person AR Shopping Interface Overlay', 'A realistic first-person perspective (POV) shot of a person\'s hands holding a bunch of fresh, red strawberries in a blurred supermarket aisle. The image features a futuristic Augmented Reality (AR) interface overlay. 

Glowing holographic graphics surround the strawberries displaying nutritional information like \'Calories {argument name=\"calories\" default=\"50kcal\"}\', \'Vitamin C\', \'Folate\', and \'Fiber\'. On the right, a digital gauge shows \'Freshness {argument name=\"freshness\" default=\"95%\"}\' and recipe suggestions like \'Strawberry Smoothie\'. On the left, a holographic shopping list checks off items like Milk and Bread. 

High-tech, smart shopping concept, photorealistic lighting, 8k resolution.', 'This prompt generates a realistic first-person perspective (POV) image of holding strawberries, overlaid with a futuristic Augmented Reality (AR) interface displaying nutritional facts, freshness gauge, and a holographic shopping list, emphasizing high-tech, photorealistic lighting.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769581916201_rquqiz_G_rb0ZAa4AEQvdG.jpg', 0),
(NULL, 'App Store Promotional Image Generation Prompt (Mr. Beast Style)', 'I want you to create promotional images for the App Store for my app called {argument name=\"app name\" default=\"viral day\"} that transforms long videos into short videos. Be creative, something like this: create variations showing a long video turning into cuts. Be creative, in the style of {argument name=\"style reference\" default=\"mr beast\"}.', 'A text prompt for the Nano Banana Pro model requesting the creation of promotional images for an App Store listing. The app, named \'Viral Day\', converts long videos into short clips. The user asks for creative variations that show a long video being transformed into cuts, specifically requesting an aesthetic similar to Mr. Beast\'s content.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769582043551_oda540_G_q8-WWXkAA2HoI.jpg', 0),
(NULL, 'Ultra-Wide Panoramic Header Visual', 'Ultra-wide panoramic header visual.
Balanced composition with one abstract focal element,
soft gradient background fading horizontally,
strong visual calm, no clutter,
lighting consistent edge to edge,
designed to remain clear at all screen sizes,
like a premium brand homepage header.', 'A prompt designed specifically for generating a clean, balanced, ultra-wide panoramic visual suitable for a premium brand\'s website header or banner. It emphasizes simplicity, soft gradients, consistent lighting, and a lack of clutter.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769495386500_k37bs8_G_dJ4BsXsAEvqem.jpg', 0),
(NULL, 'Professional Studio Headshot Prompt', '{
  \"image_prompt\": {
    \"main_description\": \"Professional studio headshot of a confident, well-groomed man in his early 30s.\",
    \"subject_details\": {
      \"appearance\": \"Neat short hairstyle, sharp facial features, subtle stubble or clean-shaven\",
      \"expression\": \"Natural, friendly smile, confident\",
      \"apparel\": \"Dark blazer over a plain black or navy t-shirt\"
    },
    \"environment\": {
      \"setting\": \"Modern office background\",
      \"elements\": \"Softly blurred desk, monitor, and indoor plants\",
      \"depth\": \"Shallow depth of field\"
    },
    \"lighting_and_atmosphere\": {
      \"lighting_setup\": \"Soft diffused studio lighting, gentle key light, balanced fill\",
      \"color_grading\": \"Clean color grading, realistic skin tones\",
      \"mood\": \"Minimalist, polished, executive\"
    },
    \"technical_specs\": {
      \"style\": \"LinkedIn-quality professional photography, ultra-realistic\",
      \"focus\": \"Sharp focus, crisp details\",
      \"resolution\": \"High resolution\"
    }
  }
}', 'A detailed image generation prompt for creating an ultra-realistic, LinkedIn-quality professional studio headshot of a confident man in a modern, polished executive style. It specifies subject details, environment, lighting, and technical specifications like shallow depth of field and high resolution.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769495359664_h7y1w3_G_mCkH9a0AASUSk.jpg', 0),
(NULL, 'Minimal Isometric 3D Perspective', 'Depict {argument name=\"subject\" default=\"[SUBJECT]\"} in a minimal isometric perspective, using simplified 3D forms, soft pastel colors, and gentle lighting. Subtle holographic fitness data floats nearby in a soft, minimal park setting. The environment feels futuristic but friendly, highly organized, uncluttered, and visually calming, like a mindful tech-assisted lifestyle moment. Use smooth surfaces, soft gradients, and a clean background with no text or logos.', 'A prompt for generating a minimal 3D isometric scene. It specifies simplified forms, soft pastel colors, gentle lighting, and a futuristic, uncluttered environment featuring subtle holographic fitness data.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769495348414_l96jab_G_lzOGjbgAEAQUI.jpg', 0),
(NULL, 'Hyper-Realistic Mixed Reality Fanta Bottle Interface', 'First-person perspective inside a brightly lit supermarket aisle. Realistic human hands bring a bottle of Fanta soda close to the camera. The vibrant orange drink in its iconic branded bottle is surrounded by a multi-layered holographic augmented reality interface, displaying nutritional data including calories, sugar content, caffeine levels, freshness indicator, expiration date, and recommended serving methods and cocktail recipes.

The user interface elements smoothly move and reorganize based on the viewer\'s gaze direction, as if dynamically responding to user focus. In the left peripheral vision, a vertical translucent shopping list is visible, where Fanta is highlighted as the currently active option among the checked items.

Hyper-realistic mixed reality, clean futuristic AR design, glass-textured UI panels, soft ambient light, realistic light and shadow, natural depth of field, immersive first-person interface, showcasing next-generation retail technology.', 'A detailed prompt for generating a hyper-realistic mixed reality scene from a first-person perspective, focusing on a Fanta bottle surrounded by a multi-layered holographic AR interface displaying nutritional data and cocktail recipes. The UI elements dynamically respond to the viewer\'s gaze, and a translucent shopping list is visible in the peripheral vision.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769495422779_x7st7n_G_kWPilX0AAr4zg.jpg', 0),
(NULL, 'Hyper-Realistic Mixed Reality Fanta Ad Concept', 'First-person perspective, standing in a brightly lit supermarket aisle. A realistic human hand is holding a bottle of {argument name=\"drink brand\" default=\"Fanta soda\"}, close to the camera.
This brightly colored orange drink in its iconic branded bottle is surrounded by a multi-layered holographic augmented reality interface, which displays nutritional data including calories, sugar content, caffeine content, freshness, shelf life, and refreshing recipes and cocktails recommended based on {argument name=\"drink brand\" default=\"Fanta\"}.
The user interface elements smoothly move and rearrange according to the viewer\'s line of sight, dynamically responding to the user\'s focus of attention.
On the edge of the left field of view, a vertical, semi-transparent shopping list is visible, listing checked items, with {argument name=\"drink brand\" default=\"Fanta\"} highlighted as the currently selected item.
Hyper-realistic mixed reality, minimalist futuristic augmented reality design, glass-textured user interface panels, soft ambient light, realistic light and shadow effects, natural depth of field, immersive first-person interface, showcasing next-generation retail technology.', 'A detailed prompt for generating a hyper-realistic, first-person perspective image of a hand holding a bottle of Fanta in a brightly lit supermarket aisle. The image features a complex, futuristic holographic augmented reality interface displaying nutritional data, recipes, and a dynamic shopping list, showcasing next-generation retail technology.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769495418605_0ra2os_G_jnn3VWUAAsV3F.jpg', 0),
(NULL, 'Subtle Brand Texture Visual Prompt', 'Subtle brand texture visual.
Fine-grain material feel, soft lighting,
neutral tones,
minimal pattern repetition,
designed to add depth without distraction,
refined and understated aesthetic.', 'A concise prompt for generating a subtle brand texture visual. It focuses on fine-grain material feel, soft lighting, neutral tones, and minimal pattern repetition, designed to add depth without distracting from the main subject.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769408693803_cwrtxw_G_dJLRsXcAEhlXw.jpg', 0),
(NULL, 'Infographic for Minato-ku Women\'s Fashion Magazine', 'Design a feature page for a fashion magazine read by beautiful Minato-ku women. The content should be systematic, constructive, and easy to understand. Include icons, photos, graphs, diagrams, and handwritten pop-ups if necessary.', 'A prompt to generate an infographic or feature page design for a fashion magazine targeting \'Minato-ku women\' (implying a sophisticated, high-end audience). The content should be systematic and easy to understand, utilizing icons, photos, graphs, diagrams, and handwritten pop-ups.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769408676703_580d9h_G_d-Lh1bMAAyEZf.jpg', 0),
(NULL, 'Minimalist Continuous Line Art Illustration', 'Illustrate {argument name=\"subject\" default=\"[SUBJECT]\"} using thin, continuous black line art on a soft off-white background. The lines should be fluid, confident, and minimal, with no shading or fill except for one subtle accent color used sparingly.', 'A prompt for generating minimalist illustrations using thin, continuous black line art. It specifies a soft off-white background, fluid and minimal lines with no shading or fill, except for one subtle accent color used sparingly, ideal for elegant design work.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769322294255_6fierq_G_bLh28aUAEMi6c.jpg', 0),
(NULL, 'Recreating Airbnb UI with Image-to-Text and Nano Banana Pro', 'Recreating a copy of Airbnb using a self-made Image-to-Text model to generate a prompt for Nano Banana Pro.', 'A demonstration of using an Image-to-Text model to convert a screenshot of the Airbnb UI into a prompt, which is then used by Nano Banana Pro to recreate the design. The user notes the high accuracy and potential for converting design prompts into web implementations using React and Tailwind.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769322356399_2ebt6p_G_aFiaDXAAAdI1n.jpg', 0),
(NULL, 'Designer-Grade Brand Moodboard Generation Prompt', 'Curated brand moodboard for a modern tech brand.
Balanced grid layout, tactile textures,
editorial photography references,
muted premium color palette,
typography-forward composition,
crafted like a senior brand designer’s internal deck.', 'A simple, high-level prompt for Nano Banana Pro designed to generate a sophisticated, designer-grade brand moodboard. It focuses on abstract concepts like grid layout, tactile textures, editorial photography, and a muted premium color palette, aiming for a professional internal deck aesthetic.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769235982712_ekqbiv_G_I8ofcXYAAwpny.jpg', 0),
(NULL, 'High-End E-Commerce Portrait with UI Overlay Prompt', '\"Subject Reference: A full-body portrait of \\[INSERT SUBJECT NAME\\]. Scene Description: A full-body, centered portrait of the subject \\[INSERT POSE DESCRIPTION\\]. The subject has \\[INSERT EXPRESSION\\], staring directly at the camera. The immediate background behind the subject is a \\[INSERT BACKGROUND TYPE, e.g., seamless, pure high-key white studio backdrop\\]. Crucially, the subject is lit with volumetric studio lighting that creates deep definitions, realistic shadows, and a strong 3D quality on her body and the folds of the outfit, distinguishing her sharply from the flat background without casting shadows on the floor. CRITICAL DETAIL (UI Layer): The entire photographic image is digitally layered beneath a simulated mobile phone browser interface overlay. Four distinct, clean, white, rectangular browser window elements are stacked vertically and angled slightly, segmenting the subject. Each window bar contains the sharp text \'{argument name=\"browser text\" default=\"[INSERT LINK OR TEXT HERE]\"}\'. The area outside the active white browser windows is a solid, uniform, dark charcoal gray/black matte UI frame, with absolutely no light bleed or color gradients. Style: Hybrid Composition: A highly realistic, three-dimensional studio photograph with deep color depth, overlaid with flat, clean digital graphics. Lighting Quality: Specific volumetric studio lighting focused ONLY on the subject. Soft, directional light from slightly off-center to sculpt the body and the rich texture of the fabric, creating depth. The background must remain completely flat. Color Palette: High contrast. \\[INSERT OUTFIT COLOR\\] outfit against \\[INSERT BACKGROUND COLOR\\] backdrop, framed by the dark matte gray UI. Texture and Mood: Realistic skin and rich fabric texture contrasting with the smooth digital elements of the UI. Intentional inclusion of subtle digital noise/grain to mimic a screen capture. Full body, centered portrait. Ensure the head and feet are fully within the frame before segmentation. Angle: Straight eye-level view, perpendicular to the subject. Framing Elements: Four overlapping, white browser windows/tabs. The pose is elegant and fluid. The bottom interface elements (e.g., \'Private\', \'Done\') must be clean and visible. Focal Length: Standard portrait lens (approx. 50mm equivalent) for realistic proportions. Camera Type: Simulated high-quality smartphone screen capture of a professional photo. Depth of Field: Shallow enough to focus sharply on the subject, allowi', 'A complex prompt structure designed to generate a high-end, full-body e-commerce studio portrait overlaid with a simulated mobile phone browser interface (UI layer), emphasizing volumetric lighting on the subject and flat, clean digital graphics for the overlay.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769236026207_pbqo1r_G_VlG8kaAAA-o42.jpg', 0),
(NULL, 'Video Game Wiki Style Image Generation', 'a sloth, a tuna, an F-15J in the style of a video game wiki website\'s page', 'A prompt for testing Google Gemini\'s image generation capabilities, specifically requesting a combination of a sloth, a tuna, and an F-15J fighter jet rendered in the distinct style of a video game wiki website\'s page.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769149370717_qz2tpi_G_Pe43abcAAkEI6.jpg', 0),
(NULL, 'Multi-Step Design Generation Prompts for \'Lovart\' Brand', 'A logo mark for a company named \"{argument name=\"company name\" default=\"Lovart\"}\" with a base color gradient of vibrant {argument name=\"color 1\" default=\"emerald green\"} and vibrant {argument name=\"color 2\" default=\"blue\"}

Generate a color palette and font design guidelines from this logo mark

Generate the application UI design for this service. PC version and smartphone version

Design a website to introduce this service. PC version and smartphone version

Design image of an exhibition booth for this service

Merchandise design for this service. T-shirt, hoodie, cap, notebook, sticker', 'A comprehensive, multi-step workflow using design agent \'Lovart\' (likely integrated with Nano Banana Pro) to generate a complete brand identity, starting from a logo and extending to design guidelines, UI, website, exhibition booth, and merchandise. This demonstrates a structured approach to design generation.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769149373823_avjhxj_G_QiCWtawAAkGgW.jpg', 0),
(NULL, 'Promo Effect v2.0 Prompt for Profile Screenshot Composition', '{
  \"edit_type\": \"precise_composite_overlay_dual_interaction_english_ui\",

  \"source\": {
    \"_hint\": \"Base Logic: Character sitting on Background. Background is fixed EXCEPT for the specific text on the button.\",
    \"mode\": \"IMAGE_COMPOSITION\",
    \"reference_images\": {
      \"foreground\": \"character_ref_image\",
      \"background_canvas\": \"profile_page_screenshot\"
    },
    \"consistency\": {
      \"character_fidelity\": \"high\",
      \"background_structure\": \"rigid_layout_preservation\"
    }
  },

  \"ui_text_enforcement\": {
    \"_hint\": \"CRITICAL: Ensure the button text reads \'Follow\' in English, regardless of the text in the original screenshot.\",
    \"target_element\": \"action_button_top_right\",
    \"mandatory_text\": \"Follow\",
    \"language\": \"English\",
    \"font_style\": \"sans_serif_bold_legible\",
    \"correction_policy\": \"overwrite_original_text_if_not_follow\"
  },

  \"background_preservation\": {
    \"_hint\": \"Background is a rigid floor. Only allow changes to shadows and the button text.\",
    \"policy\": \"strict_pixel_retention_mostly\",
    \"allowed_modifications\": [
      \"realistic_contact_shadows_under_character\",
      \"replacement_of_button_text_to_Follow\"
    ]
  },

  \"camera_and_lighting\": {
    \"_hint\": \"Character sitting ON the interface.\",
    \"perspective\": \"high_angle_looking_down\",
    \"grounding_effect\": {
      \"technique\": \"contact_shadows_under_legs\",
      \"placement\": \"on_background_surface\"
    }
  },

  \"pose\": {
    \"_hint\": \"Dual pointing: Left Hand -> Name, Right Hand -> \'Follow\' Button.\",
    \"pose_style\": \"sitting_cross-legged_or_kneeling\",
    \"head_position\": \"tilted_back_looking_at_camera\",
    \"hands_configuration\": {
      \"s', 'A technical prompt structure for Nano Banana Pro\'s \'Promo Effect v2.0\' feature, designed to composite a character image onto a user\'s profile screenshot. The prompt enforces specific rules, such as ensuring the \'Follow\' button text is present, maintaining background structure, and defining the character\'s pose (sitting, pointing to the account name and the \'Follow\' button). This prompt is highly specialized for UI manipulation and image composition.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769149375646_t0hcun_G_QABb-XgAAft2D.jpg', 0),
(NULL, 'Conceptual brand storytelling visual prompt', 'Conceptual storytelling visual for a modern brand narrative.
Abstract progression elements,
sense of movement and flow,
soft cinematic lighting,
optimistic, forward-moving tone,
crafted to communicate journey and growth.', 'A concise prompt for generating a conceptual visual that communicates a brand narrative focused on journey and growth. It specifies abstract progression elements, a sense of movement, soft cinematic lighting, and an optimistic, forward-moving tone.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769063183301_ktu0ww_G_K8eo-XcAArGm3.jpg', 0),
(NULL, '3D Icon Collection Grid Generator', 'Prompt: Create a collection of icons representing [Theme]. They are unified as a single theme. Please arrange them in a 3x3 grid. The background is white. The icons should be created in a colorful, three-dimensional 3D style. No text is required.
- {argument name=\"Theme 1\" default=\"90s Gadgets\"}
- {argument name=\"Theme 2\" default=\"February\"}
- {argument name=\"Theme 3\" default=\"Emotional Fruits\"}
- The Darkness of Remote Work', 'A prompt template for Nano Banana Pro designed to generate a collection of 3D icons arranged in a 3x3 grid. The icons are colorful and three-dimensional, centered around a specific theme, and generated on a white background without any text.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1769063243480_k3zbwk_G_J5DxgbMAAf0BY.jpg', 0),
(NULL, 'Abstract Background for Premium Website', 'Abstract background visual for a premium website section.
Soft gradients, subtle depth,
low visual noise, modern color harmony,
non-distracting composition,
scalable across layouts,
designed like a senior product designer asset.', 'A concise prompt for generating an abstract visual suitable for a premium website background. The focus is on usability, low visual noise, soft gradients, and modern color harmony, designed to be non-distracting and scalable.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768977273111_g5vt3q_G_JAwy9XAAAgpVN.jpg', 0),
(NULL, 'High-Impact Product Launch Visual', 'High-impact product launch visual for a premium digital product.
Dark, elegant background,
single focal object, dramatic directional lighting,
controlled contrast, minimal composition,
cinematic but restrained,
crafted for announcement moments.', 'A concise prompt designed for creating a high-impact, elegant product launch visual. It emphasizes minimalism, a dark background, dramatic directional lighting, and controlled contrast to make a single focal object appear important and exclusive.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768977252628_yvpqyb_G_I9hmyWMAMHKJi.jpg', 0),
(NULL, 'Scandinavian Minimalist Illustration Template', 'Scandinavian-style minimal illustration of {argument name=\"subject\" default=\"a cozy living room\"}, muted pastel palette, flat design, soft gradients, cozy yet modern aesthetic, clean shapes, lifestyle illustration feel.', 'A reusable prompt template for generating illustrations in a Scandinavian minimalist style, characterized by a muted pastel palette, flat design, soft gradients, and a cozy yet modern aesthetic.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768977252883_o5sbdv_G_Hf0rvXoAALWnl.jpg', 0),
(NULL, 'LinkedIn Banner Design Prompt', 'LinkedIn banner for a \'{argument name=\"job title\" default=\"Creative Director\"}.\' Abstract 3D shapes (spheres, cubes) floating in a gradient space. Professional, modern, high-quality render.', 'A simple prompt for generating a professional and modern LinkedIn banner image for a \'Creative Director,\' featuring abstract 3D shapes floating in a gradient space with a high-quality render.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768977316821_pbmefq_G_F62PEXUAE9-4w.jpg', 0),
(NULL, '9-Panel Product Storyboard Grid Prompt', 'Create ONE final image.

A clean 3×3 [ratio] storyboard grid with nine equal [ratio] sized panels on [4:5] ratio.

Use the reference image as the base product reference. Keep the same product, packaging design, branding, materials, colors, proportions and overall identity across all nine panels exactly as the reference. The product must remain clearly recognizable in every frame. The label, logo and proportions must stay exactly the same.

This storyboard is a high-end designer mockup presentation for a branding portfolio. The focus is on form, composition, materiality and visual rhythm rather than realism or lifestyle narrative. The overall look should feel curated, editorial and design-driven.

FRAME 1:
Front-facing hero shot of the product in a clean studio setup. Neutral background, balanced composition, calm and confident presentation of the product.

FRAME 2:
Close-up shot with the focus centered on the middle of the product. Focusing on surface texture, materials and print details.

FRAME 3:
Shows the reference product placed in an environment that naturally fits the brand and product category. Studio setting inspired by the product design elements and colours.

FRAME 4:
Product shown in use or interaction on a neutral studio background. Hands and interaction elements are minimal and restrained, the look matches the style of the package.

FRAME 5:
Isometric composition showing multiple products arranged in a precise geometric order from the top isometric angle. All products are placed at the same isometric top angle, evenly spaced, clean, structured and graphic.

FRAME 6:
Product levitating slightly tilted on a neutral background that matches the reference image color palette. Floating position is angled and intentional, the product is floating naturally in space.

FRAME 7:
is an extreme close-up focusing on a specific detail of the label, edge, texture or material behavior.

FRAME 8:
The product in an unexpected yet aesthetically strong setting that feels bold, editorial and visually striking.
Unexpected but highly stylized setting. Studio-based, and designer-driven. Bold composition that elevates the brand.

FRAME 9:
Wide composition showing the product in use, placed within a refined designer setup. Clean props, controlled styling, cohesive with the rest of the series.

CAMERA & STYLE:
Ultra high-quality studio imagery with a real camera look. Different camera angles and framings across frames. Controlled depth of field, precise lighting, accurate materials and reflections. Lighting logic, color palette, mood and visual language must remain consistent across all nine panels as one cohesive series.

OUTPUT:
A clean 3×3 grid with no borders, no text, no captions and no watermarks.', 'A detailed prompt for creating a 3x3 storyboard grid (nine equal panels) from a single reference image. The goal is a high-end designer mockup presentation, focusing on form, composition, and materiality, with each panel showing the product from a different angle, context, or close-up, while maintaining absolute product consistency across all frames.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768977285349_fcvu8y_G_FaISRWkAAHtDT.jpg', 0),
(NULL, 'Minimalist 3D Isometric Car Showroom Model', 'A clean, minimalist 3D isometric model showcasing a [{argument name=\"location\" default=\"car showroom\"}], where [{argument name=\"display items\" default=\"display items\"}] are arranged within a [cabin structure], featuring subtle lighting accents, smooth floor surfaces, soft studio lighting, realistic materials, rounded edges, a miniature architectural style, high detail, and a neutral background.', 'A prompt for generating a clean, minimalist 3D isometric architectural model. It specifies a car showroom within a cabin structure, emphasizing soft studio lighting, realistic materials, rounded edges, and high detail against a neutral background.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768890674999_o1djn0_G_CbppYW0AEbevq.jpg', 0),
(NULL, 'Soft UI Style Illustration Generator', 'Soft minimal illustration of {argument name=\"subject\" default=\"[SUBJECT]\"}, rounded shapes, gentle gradients, calming tones, modern UI illustration style, friendly, clean, and contemporary.', 'A simple, effective prompt for the Gemini Nano Banana Pro model to create illustrations in a soft, minimal UI style. It emphasizes rounded shapes, gentle gradients, and calming tones for a clean, contemporary look.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768890704783_a0olf1_G_BPzmOWUAAnbKm.jpg', 0),
(NULL, 'Minimal Flat Geometry Illustration Prompt', 'Minimal flat illustration of {argument name=\"subject\" default=\"[SUBJECT]\"}, simple geometric shapes, limited color palette, clean vector style, generous negative space, modern editorial illustration, soft shadows, smooth curves, high aesthetic minimalism.', 'A reusable prompt template for generating minimalist, modern editorial illustrations using simple geometric shapes, a limited color palette, and generous negative space, resulting in a high aesthetic minimalism.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768804221236_rmcu9v_G-84CAKXcAEiuxY.jpg', 0),
(NULL, 'Minimalist 3D Isometric Diorama Generator', 'A clean, minimal 3D isometric diorama of a {argument name=\"exhibition type\" default=\"[EXHIBITION TYPE]\"}, featuring {argument name=\"display objects\" default=\"[DISPLAY OBJECTS]\"} arranged within a {argument name=\"pod structure\" default=\"[POD STRUCTURE]\"}, subtle lighting accents, smooth floor surfaces, soft studio lighting, realistic materials, rounded', 'A simple, customizable prompt template for generating a clean, minimal 3D isometric diorama. It allows the user to define the type of exhibition, the objects displayed, and the structure of the pod, focusing on realistic materials and soft studio lighting.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768804232546_vd8e69_G-8YfWxXIAAJ-Af.jpg', 0),
(NULL, 'Celestial Desert Minimalist Wallpaper Prompt', '{
  \"title\": \"Celestial Desert Minimalist\",
  \"subject\": \"Smooth, flowing sand dunes under a massive glowing moon\",
  \"aspect_ratio\": \"9:19.5 (iPhone Full HD)\",
  \"aesthetic_style\": \"Surrealism / Dreamcore\",
  \"color_palette\": {
    \"primary\": \"{argument name=\"primary color\" default=\"Deep terracotta orange\"}\",
    \"secondary\": \"Midnight navy blue\",
    \"accent\": \"Soft gold\"
  },
  \"lighting\": {
    \"source\": \"Large crescent moon\",
    \"effect\": \"Soft rim lighting on the edges of the dunes\"
  },
  \"details\": [
    \"Ultra-sharp sand grain textures\",
    \"Clean, sweeping curves\",
    \"Minimalist stars in the upper third for clock clarity\",
    \"High depth of field\"
  ],
  \"quality\": \"8K UHD, Cinematic, Photorealistic\"
}', 'A JSON prompt for Gemini Nano Banana Pro to generate a surreal, minimalist mobile wallpaper featuring smooth sand dunes under a massive glowing moon, using a deep terracotta and midnight navy color palette.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768804267930_p1ty36_G-zhZKgWkAAWyoL.jpg', 0),
(NULL, '3D Isometric Floating Home Office Illustration', 'A 3D isometric pastel home office scene where objects appear gently lifted, featuring a modern desk with a laptop slightly hovering, plants slowly floating upward, shelves detached from the wall, and a coffee cup resting in mid-air without spills. Smooth rounded surfaces, soft matte materials, {argument name=\"color palette\" default=\"light mint, lavender, and warm beige\"} palette, minimal and clean details, subtle depth, soft ambient lighting, gentle shadows that hint at weightlessness, peaceful futuristic mood, illustration-style render, modern UI-friendly composition.', 'A text prompt for Google Gemini Nano Banana Pro 3.0 to generate a 3D isometric illustration of a pastel home office scene where all objects, including the laptop and plants, are gently floating, creating a peaceful, futuristic, and clean UI-friendly mood.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768804279333_zw52lb_G-6f7sxWkAA62IK.jpg', 0),
(NULL, 'Luxury Brand About Page Storytelling Layout', 'Special Layout Template make by Willy.

Luxury brand about page, storytelling layout, 4:5 ratio.

PAGE TYPE: About page - brand story, visual narrative
LAYOUT: Large image sections alternating with text blocks, timeline arrangement.

SECTION 1:
- Image: A young Caucasian woman in her early 20s : almond-shaped eyes with long defined lashes, high cheekbones, and a subtle V-line jaw. She has  long flowing wavy light brown hair with soft black-coffee highlights cascading over her shoulders. Luminous dewy porcelain skin with a healthy glow and glass skin effect, soft rose blush on cheeks, glossy cherry lips with a subtle smile, slim straight nose, delicate feminine features.
- She wears a cream silk power suit with clean lines and wide-leg trousers, paired with a delicate layered silver necklace. A designer clutch rests on the marble cafe table beside a steaming cup of matcha latte.

SECTION 2:
- Text Block: \"{argument name=\"Text Block 1\" default=\"Our Journey: A fusion of heritage and innovation, crafted for the modern woman.\"}\"
SECTION 3:
- Image: Close-up beauty shot showcasing the glass skin effect and delicate jewelry.
SECTION 4:
- Text Block: \"{argument name=\"Text Block 2\" default=\"Commitment to quality, sustainability, and empowering women through fashion.\"}\"
SECTION 5:
- Image: Full-length shot, showcasing the power suit silhouette in motion.
SECTION 6:
- Text Block: \"Designed in Paris, inspired by the world.\"

DYNAMIC ELEMENTS:
Subtle motion blur as she turns her head slightly with gentle head tilt, soft contemplative expression, steam rising from the matcha latte cup creating warmth and atmosphere.
CAMERA: Hasselblad X2D, 85mm f/1.4 lens, soft diffused golden hour lighting, shallow depth of field, beauty retouching with luminous skin detail.
STYLE: Parisian elegance, power dressing, luxury fashion, ethereal Eurasian beauty, golden hour, warm and cool color palette, high-end fashion editorial.

A stylish handwritten signature \"Willy\" is elegantly placed in small letters at the Bottom Right corner.

Style keywords: luxury brand, about us, fashion, parisian cafe, glass skin, editorial, commercial, well-lit, proper exposure, storytelling, timeline, 4:5 ratio
Negative prompt: blurry, low quality, pixelated, distorted, watermark, text overlay, logo, cropped, cut off, out of frame, oversaturated, undersaturated, extra limbs, missing fingers, deformed hands, unnatural pose, anatomical errors, plastic skin, uncanny valley, busy background, distracting elements, inconsistent lighting, harsh shadows, amateur composition.', 'A structured prompt designed to generate a luxury brand \'About Page\' visual narrative in a 4:5 ratio. It specifies a multi-section layout alternating between images and text blocks, focusing on a high-fashion Parisian aesthetic, glass skin effect, and editorial quality.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768804306881_1beemg_G-6btoOXgAAQrWG.jpg', 0),
(NULL, 'Winter Fashion Landing Page Design and Editorial Image', 'Landing page design for a winter fashion collection, vertical scroll layout, full-bleed top image, feature cards below, stacked sections.

Editorial fashion portrait of a young Eurasian woman in her early 20s with a slim oval face and V-line jawline, standing in a snowy birch forest, long flowing wavy light brown hair with golden caramel highlights, delicate snowflakes in hair, large bright blue-green doe eyes with long natural lashes, luminous dewy porcelain skin with healthy glow, glass skin effect, soft rosy blush on cheeks, glossy pink lips with radiant smile showing perfect teeth, slim straight nose, delicate feminine features, ethereal doll-like beauty, wearing a cream cable knit oversized sweater, ivory knit scarf wrapped cozy around neck, matching beige knit gloves touching birch bark, wearing a long flowing pleated silk maxi skirt with a subtle floral pattern, elegant relaxed pose with gentle head tilt, soft dreamy expression, snowy birch forest background with beautiful bokeh, gentle snowfall, soft diffused winter lighting, shot on 85mm f1.4 lens, shallow depth of field, cool blue and warm cream tones, high-end fashion editorial style.

FEATURE CARDS:
- Card 1: \"Timeless Elegance\" - image of the woman in the forest, text describing the core values of the collection, CTA to \"Explore the Collection\"
- Card 2: \"The Softest Cashmere\" - close-up shot of the cashmere sweater, details on the material and craftsmanship, CTA to \"Shop Sweaters\"
- Card 3: \"Winter Whites\" - a selection of ivory and cream pieces from the collection, CTA to \"Shop Whites\"
- Card 4: \"Designed for Comfort\" - description of the relaxed fit and cozy designs, CTA to \"Learn More\"
A stylish handwritten signature \"Willy\" is elegantly placed in small letters at the bottom right corner.', 'A complex prompt that combines a request for a vertical-scroll landing page design layout with a highly detailed description of the main editorial image. The image features an ethereal Eurasian woman in a snowy birch forest wearing cream knitwear, emphasizing soft winter lighting, shallow depth of field, and a high-end fashion editorial style. The prompt also outlines the content and structure of four feature cards for the landing page.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768717572839_ec66xo_G-33lG3bcAAKtkc.jpg', 0),
(NULL, 'Renovation Visualization: After Frame', 'Use the EXACT same camera position, lens and composition as the before image (doorway viewpoint, 24mm wide-angle, same window/door/ceiling lines). Transform the space into a beautifully renovated modern minimalist living room: clean smooth walls in warm off-white, new light oak wood flooring, recessed ceiling with soft cove lighting, elegant curtains, subtle decor, bright natural daylight, premium real-estate photography look, ultra clean, high-end details, 9:16, photorealistic.
Negative:
cartoon, CGI, fisheye, messy, mold, stains, debris, people, text, watermark, logo', 'This is the second part of a two-step renovation visualization prompt, designed to generate the \'after\' image. It instructs the AI to use the exact camera parameters and composition from a previously generated \'before\' image (presumably a messy room) and transform the space into a beautifully renovated, modern, minimalist living room with high-end details and professional real-estate photography aesthetics.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768717564916_ieuyod_G-2aG16bEAAv-la.jpg', 0),
(NULL, 'Renovation Visualization: Before Frame', 'Photorealistic shabby unfinished apartment interior (before renovation), camera at the doorway, 24mm wide-angle, looking toward the corner, bare concrete walls and ceiling, visible cracks, damp stains and mold, peeling ceiling patches, dusty floor with scattered debris (broken bricks, plaster pieces, tangled wires, plastic bags), old paint bucket and worn broom in corner, rusty exposed pipes/radiator, dirty window with one pane missing patched by taped plastic film slightly fluttering, cold natural daylight beam with visible floating dust particles, gritty real-estate inspection documentary photo, sharp focus, ultra-detailed, 9:16.
Negative:
cartoon, illustration, CGI, 3D render, extreme fisheye, over-HDR, oversaturated, too clean, already renovated, furniture, people, text, watermark, logo', 'This is the first part of a two-step renovation visualization prompt, designed to generate the \'before\' image. It specifies a photorealistic, shabby, unfinished apartment interior with extreme detail on decay, including concrete walls, mold, debris, and a dirty window, captured with a wide-angle lens from a doorway viewpoint, mimicking a gritty real-estate inspection photo.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768717568378_gv81cf_G-2Z09abIAEQ8IG.jpg', 0),
(NULL, 'Minimalist 3D Isometric Exhibition Pod Diorama', 'A clean, minimal 3D isometric diorama of a {argument name=\"exhibition type\" default=\"[EXHIBITION TYPE]\"}, featuring {argument name=\"display objects\" default=\"[DISPLAY OBJECTS]\"} arranged within a {argument name=\"pod structure\" default=\"[POD STRUCTURE]\"}, subtle lighting accents, smooth floor surfaces, soft studio lighting, realistic materials, rounded edges, miniature architectural model style, high detail, neutral background.', 'A template prompt for generating a clean, minimal 3D isometric diorama image. It is designed for visualizing a pop-up exhibition space, allowing the user to customize the type of exhibition, the objects displayed, and the structure of the pod, all rendered in a miniature architectural model style with soft studio lighting.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768717570869_xdbz00_G-2E_2JaUAAR7Q-.jpg', 0),
(NULL, 'Nano Banana Icon Batch Generation', 'Generate {argument name=\"number of icons\" default=\"40\"} {argument name=\"type\" default=\"icons\"}', 'A prompt demonstrating Nano Banana\'s ability to quickly generate a large batch of icons (40 icons in 15 minutes) in a single request, highlighting its efficiency for asset creation.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768544874866_srsr2e_G-vh3S3bQAI60GP.jpg', 0),
(NULL, 'Minimalistic Lofi Wallpaper Generation Prompt', '\"A minimal flat vector illustration of the subject in the attached image lying on its side, resting its head on the edge of a large rounded rectangle banner. The subject is drawn in simple line-art style with smooth curves, closed eyes, and a relaxed sleepy pose. The banner must be at the bottom leaving the 1/3 of the negative space, The banner is a soft pastel {argument name=\"banner color\" default=\"lemon green\"} rounded rectangle with subtle shadow. The background is pure white, clean and empty, leaving lots of negative space above. Modern UI illustration style, soft minimal design, playful and calm mood, crisp vector lines, high resolution. In 9:16 aspect ratio\"', 'A detailed prompt for creating a custom, minimalistic, flat vector illustration suitable for a lofi wallpaper, focusing on clean lines, soft pastel colors, and ample negative space, requiring a reference image of the subject.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768544796920_h2jlli_G-svOr8bQAI0Q2W.jpg', 0),
(NULL, 'Minimal 3D Isometric Urban Retail Kiosk Diorama', 'A clean, minimal 3D isometric diorama of a [{argument name=\"urban retail type\" default=\"URBAN RETAIL TYPE\"}], featuring a [{argument name=\"main counter object\" default=\"MAIN COUNTER / DISPLAY OBJECT\"}] placed on a [{argument name=\"ground platform type\" default=\"GROUND / PLATFORM TYPE\"}], simple [CANOPY / ROOF STRUCTURE], subtle [SIGNAGE TYPE], smooth [SURFACE MATERIAL], soft studio lighting, realistic materials, rounded edges, miniature architectural model style, high detail, neutral background.', 'A template prompt for generating a clean, minimal 3D isometric diorama of an urban retail kiosk. It uses placeholders for customization, focusing on soft studio lighting, realistic materials, rounded edges, and a miniature architectural model style.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768544837770_97r4vf_G-sshocaMAADfrO.jpg', 0),
(NULL, '3D Isometric Urban Transit Stop Diorama Prompt', 'A clean, minimal 3D isometric diorama of a {argument name=\"city transport type\" default=\"[CITY TRANSPORT TYPE]\"} stop, featuring a {argument name=\"vehicle type\" default=\"[VEHICLE]\"} paused at a [PLATFORM TYPE], simple [SHELTER / CANOPY], subtle wayfinding signs, smooth concrete surfaces, soft studio lighting, realistic materials, rounded edges, miniature architectural model style, high detail, neutral background.', 'A template prompt for generating a clean, minimal 3D isometric diorama of an urban transit stop, allowing customization of the transport type, vehicle, platform, and shelter, emphasizing realistic materials and a miniature architectural model style.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768544814248_umamd4_G-rcPi3bQAMNVo8.jpg', 0),
(NULL, '3D Icon Collection Representing Japanese Seasons', 'Create an icon collection that represents the objects, symbols, and mood of the month of [Month].
They should be unified under a single theme.
The background is pure white.

Place the name of the month, \"{argument name=\"month name\" default=\"December\"}\", at the top center of the image as a minimal and balanced title. Position it symmetrically on a grid, visually integrating it with the overall design.

The icons should be rendered in a colorful yet subdued 3D style, using textures and atmospheric lighting appropriate for the season. They should reflect the essence of {argument name=\"month name\" default=\"December\"} in Japan.

Maintain consistent proportions, materials, and visual language across all icons and the title.', 'A prompt designed to generate a collection of 3D icons that symbolize the mood and objects associated with a specific month in Japan. The icons are rendered in a colorful yet subdued 3D style with atmospheric lighting and texture, set against a pure white background, and include a minimal title for the month.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768468606176_la82qk_G-nKUu5agAAzrXG.jpg', 0),
(NULL, 'Weekly Schedule Template for VTubers', 'Create a \"Weekly Schedule\" template image for VTubers and streamers.
Horizontal 16:9, size 1920x1080, flat, neat, print-like design (vector style). The overall look should be cute pastel tones (gentle colors like pale pink, mint, lavender), prioritizing readability without clutter.

Layout specification:
・Place the schedule section top-aligned on the left 60% of the screen.
・7 rows (Days of the week: \"Mon, Tue, Wed, Thu, Fri, Sat, Sun\").
・Each row consists of a \"Day label (small round badge)\" + \"Horizontal blank box for writing plans.\"
・The blank box must be completely empty. Absolutely do not include sample text (e.g., \'Plan here\', \'SAMPLE\', \'MEMO\', etc.).
・The right 40% of the screen is empty space for later synthesis of a standing character image. Do not draw people, animals, mascots, or silhouettes. The background should only be a faint gradient and subtle abstract patterns of small stars/hearts/dots.

Text specification:
・The only text to include is \"Weekly Schedule\" and \"Mon Tue Wed Thu Fri Sat Sun\" (in Japanese).
・Do not include any other text (SNS, date range, warnings, logos, hashtags, watermarks).
・The font should be rounded Gothic style, easy to read, and legible even on a white background.

Finishing:
・Ensure ample margin around the perimeter, and elements on the left and right sides do not overlap.
・No logo.', 'A detailed prompt designed for Nano Banana Pro to create a clean, flat, and cute pastel-toned weekly schedule template suitable for VTubers and streamers. It includes specific layout instructions, size specifications (1920x1080, 16:9), and strict rules about text inclusion and empty space for later character synthesis.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768468609160_85lvra_G-lyvW7bYAAmJxG.jpg', 0),
(NULL, 'Liquid Glass UX Button Prompts for Nano Banana Pro', 'add a 3D UX button around text at the bottom \"Nano Banana Pro + Adobe Firefly\" harmonize everything to look like a professional UX, button is liquid glass style, all text dark color

add a 3D UX button around text at the bottom \"Nano Banana Pro + Adobe Firefly\" harmonize everything to look like a professional UX, button is liquid glass style', 'Two image generation prompts for Nano Banana Pro, focusing on integrating a 3D liquid glass style UX button around text, aiming for a professional, harmonized user experience aesthetic.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768466945193_uzu8bv_G-jEZBYWAAAdmtO.jpg', 0),
(NULL, 'Minimalist Word-as-Object Logo Design', 'A minimalist logo design where the word \"{argument name=\"word\" default=\"WORD\"}\" is transformed into a physical object related to its meaning. The letters are subtly reshaped to form the silhouette of the object while remaining readable. Clean white background, monochrome black design, balanced composition, modern branding style, flat graphic aesthetic, even lighting, high contrast.', 'A prompt for generating a minimalist, modern logo design where the letters of a chosen word are subtly reshaped to form the silhouette of an object related to that word\'s meaning. It specifies a monochrome black design, clean white background, and a flat graphic aesthetic, suitable for modern branding.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768319111772_f6x33h_G-c0rC5bMAEt1y0.jpg', 0),
(NULL, 'Abstract Geometry Portrait in Zen Space', '[SUBJECT] abstracted into simple geometric forms, floating in a monochromatic zen space. Clean lines, soft gradients of gray, deliberate spacing between elements. Cinematic framing with wide aspect ratio, meditative stillness, architectural minimalism, calm visual tempo.', 'A concise prompt for generating an abstract image where a subject is reduced to simple geometric forms floating in a monochromatic zen space. It focuses on clean lines, soft gradients, and architectural minimalism with a cinematic wide aspect ratio.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768226042603_p59fa2_G-XuVCybEAA3w9c.jpg', 0),
(NULL, 'AI-Assisted LP Page Design with Automation Focus', 'AI-assisted LP page design, Nano Banana and Genspark generating {argument name=\"type\" default=\"multiple\"} types of sales pages, highlighting {argument name=\"focus\" default=\"automation and algorithmic optimization\"}', 'This prompt uses Nano Banana and Genspark to generate various types of sales landing pages (LP). It focuses on highlighting automation and algorithmic optimization features within the design.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768226123613_yh7h4p_G-UBIffaIAA6BU9.jpg', 0),
(NULL, 'Bauhaus Functional Identity Brand Logo Generation', 'Reimagine [{argument name=\"brand name\" default=\"BRAND NAME\"}] through strict Bauhaus principles, reducing the logo to its most essential visual logic.

The mark is built from pure geometry, perfect balance, and intentional spacing. There is no decoration, symbolism is abstracted, and every element serves a function.

The typography is clean, modern, and rational, aligned precisely with the symbol. The entire composition feels intelligent, timeless, and confidently restrained, as if designed to outlast trends.', 'A prompt designed to reimagine a brand\'s logo based on strict Bauhaus principles. It instructs the AI to reduce the logo to essential geometry, perfect balance, and rational typography, resulting in a clean, timeless, and functional identity mark.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768143806611_p8epy6_G-TQ3fabEAA4QuQ.jpg', 0),
(NULL, 'Raw Photo of MacBook Screen During Google Meet Selfie', '(Vertical 3:4 aspect ratio). A raw, ultra-realistic physical photograph of a silver MacBook Air sitting on a light oak wooden desk. This is a handheld photo of a screen. NO ARTIFICIAL BOKEH. Everything is SHARP and in focus from the keyboard to the window in the background.
Layer 1: The Physical Hardware (MacBook & Environment)

The MacBook screen is the focal point. Direct, bright natural daylight streams in from a window behind the laptop, partially illuminating the keyboard and creating a realistic sun-glare on the screen\'s glossy surface.
Surface Imperfections (High Realism): Visible fine dust particles on the black keyboard keys, a few realistic oily fingerprints on the screen\'s bezel, and the grain of the wooden desk are perfectly SHARP.
Background: Soft white curtains and a bright window are visible behind the laptop, making the room feel airy and lived-in.
Layer 2: The Digital Interface (macOS & Google Meet)

The screen displays a Chrome browser window with multiple active tabs (Google Meet, Google Docs, Calendar).
An active Google Meet video call is in progress. The interface controls (mute, camera, end call red button) are sharp and legible at the bottom of the call window.
Layer 3: The Subject & Identity Locking (The \"Uff\" Content)

Identity: Strictly preserve the exact face and unique features of the woman in Image 1 (Selfie).
Bio-Fidelity: Inside the video call window, she is seen taking a mirror selfie through her webcam. She has a playful \"kiss-face\" or \"pout\" expression.
Appearance: Her blonde hair is styled in a straight, shoulder-length cut. Her skin shows ultra-high-fidelity \"TrueLens\" physics: visible micro-pores and a healthy \"satin-finish\" glow even through the webcam\'s digital feed.
The Selfie Architecture: On the laptop screen, she is holding a smartphone with a distinctive blue-and-white cloud-patterned case, capturing her own reflection.
Quality & Lighting:

Lighting: High-key, bright, and optimistic morning light. The contrast between the bright screen and the natural room light is perfectly balanced.
Quality: Raw smartphone photo aesthetic, high dynamic range, visible subtle moiré patterns on the laptop screen pixels, 8k resolution. Single frame.', 'A highly specific prompt for generating an ultra-realistic photo of a silver MacBook Air sitting on a wooden desk, emphasizing sharp focus (no bokeh) across all layers. The image captures the MacBook screen displaying an active Google Meet call, where the subject (identity locked from a reference image) is seen taking a mirror selfie of herself through the webcam, creating a complex layered image with realistic screen glare and surface imperfections.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768143622276_5zi6k1_G-Ov6ZDXwAED9nw.jpg', 0),
(NULL, 'Minimalist Typographic Illustration Conveying Meaning', 'A modern, minimalist digital illustration of {argument name=\"title or name\" default=\"[TITLE / NAME]\"} using bold uppercase typography with subtle depth. Each letter contains one carefully chosen object or visual cue representing a key idea or value.

The background remains understated, allowing the typography to communicate meaning through simplicity. Clean, intelligent, gallery-ready aesthetic.', 'A prompt template for generating a modern, minimalist digital illustration where the letters of a given title or name are used as the canvas. Each bold uppercase letter contains a carefully chosen object or visual cue representing a key idea or value, creating a clean, intelligent, and gallery-ready aesthetic.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768143610586_57m1dv_G-NxivMbwAAgvWN.jpg', 0),
(NULL, 'Minimalistic Premium Website Landing Page Prompt', '\"Create a screenshot of a web site landing page it should be minimalistic but premium, showing these products by {argument name=\"brand name\" default=\"(brand name)\"}. add any details needed\"', 'A prompt designed for generating a minimalistic yet premium website landing page screenshot, intended to showcase specific products from a given brand, requiring reference images of the products.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768143656786_57jm83_G-NZ346aMAAd9Ar.jpg', 0),
(NULL, 'VTuber Streaming Screen Generation with Customizable Character and Theme', '[Character Settings]
・Character Appearance: {argument name=\"Character Appearance\" default=\"Brown hair, short twin tails, red eyes, slightly pointed teeth (gapped teeth)\"}.

・Style Setting: {argument name=\"Style Setting\" default=\"A room full of donut motifs\"}

[Fixed Parts]
A high-quality image depicting the layout of a VTuber streaming screen. Aspect ratio is horizontal (16:9).
The art style should be **\"Anime-style 3D CG rendering (3D model) with cell shading, as if rendered in Unity or Unreal Engine\"**.

Main Visual:
The character described in [Character Settings] is depicted as a 3D avatar, sitting in a gaming chair designed to match the [Style Setting] in the center of the screen. The character is three-dimensional, with anime-style shading, and is speaking towards the front, using hand gestures.

Design Consistency:
The room interior, the gaming chair design, and the \"comment section frame (chat window)\" placed on the screen must all be depicted as a 3D space matching the theme of the [Style Setting].

Composition and Elements:

Background: A deep 3D background based on the [Style Setting] (windows, wall decorations, furniture, etc.).

Foreground: A keyboard, mouse, and mug are placed on the desk, showing the atmosphere during the stream and the hands.

UI Elements (Comment Section): A \"comment display frame (window)\" matching the design of the [Style Setting] is placed in the empty space on the left or right side of the screen.
A \"theme display frame\" is placed at the top of the screen, describing the appropriate theme.

Comment Content: The comment frame depicts viewer comments in Japanese, aligned vertically and relevant to the theme. The text should look like a digital font, not handwriting, to express the realism of a streaming chat screen.

Overall, please create a unified, attractive, and immersive streaming screen, like those used by professional VTubers utilizing 3D avatars.', 'A comprehensive prompt designed to generate a high-quality, immersive VTuber streaming screen layout. It specifies a 3D anime-style cell-shaded rendering, allowing customization of the character\'s appearance and the overall room/UI theme (e.g., Cyberpunk, Gothic Horror, SF). The output includes the character sitting in a themed gaming chair, a detailed 3D background, foreground elements like a keyboard and mug, and a themed chat window with realistic Japanese text comments.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1768143698295_3469ps_G-CgooobcAMqVHM.jpg', 0),
(NULL, 'Nano Banana Pro Hot Post Summary Prompts', '@AmirMushich
Celebrity career photo grid tribute poster, blending double exposure and mixed media textures to highlight artistic sense

@OTFHD
Hand-drawn style simulation of Indian architecture and cultural elements, professional prompt suitable for logo and visual identity design

@Kerroudjm
3D urban miniature landscape on a real geographical map, highlighting the integration of iconic architecture and cultural elements

@artisin_ai
Dreamy bubble dynamic scene, emphasizing underwater depth and carbonation aesthetics for product photography

@berryxia
Japanese photo book style 9-panel narrative, blending airy feel and film texture to highlight everyday moments

@ttmouse
Hyper-realistic vertical exploded view, showcasing dynamic layering of beverage ingredients and high-end visual effects

@Strength04_X
Strawberry juice explosion dynamic photography, emphasizing high impact and cinematic lighting for beverage advertising

@Arminn_Ai
Miniature scene 3D perspective, blending real human skin texture with environmental props to highlight proportional realism

@meng_dagg695
Food explosion dynamic decomposition, emphasizing hyper-realistic texture and frozen motion for commercial photography

@aleenaamiir
Spherical panoramic city view, blending landmarks and sphere distortion to highlight surreal effects

@AllaAisling
Product photography bubble dynamics, emphasizing carbonation energy and fresh movement for marketing visuals

@RobotCleopatra
Product tilt and splash dynamics, blending backlight and flying elements to highlight high-resolution realism

@Strength04_X
Cute brand fantasy scene, blending neon light and Pixar style to highlight advertising fun

@oggii_0
Minimalist skincare product photography, emphasizing foam dynamics and liquid refraction for user-generated content advertising

@TechieBySA
Glass cube national landscape miniature, blending landmarks and cultural icons to highlight immersive details

@astronomerozge1
Transparent coffee machine internal system visualization, emphasizing engineering aesthetics and product editorial photography

@songguoxiansen
Q-version Peking Opera character figurine design, blending traditional costumes and opera elements to highlight cultural heritage

@AmirMushich
AI generation as stock assets, emphasizing post-editing and classic skill integration for real projects', 'A collection of Nano Banana Pro image generation prompts summarized from popular posts, covering diverse styles like editorial collage, 3D cityscapes, product photography with dynamic liquids, and cultural designs.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767967483472_g9flb4_G-JhC2MaYAAZVqU.jpg', 0),
(NULL, 'AI Vision Augmented Reality Overlay Concept', '{
  \"concept_name\": \"AI Vision & Data Overlay (Augmented Reality)\",
  \"instructions\": \"Replace [SUBJECT] with any object, person, architectural structure, or vehicle.\",
  \"prompt\": \"Cinematic shot of a real-world {argument name=\"subject\" default=\"[SUBJECT]\"} viewed through a high-tech Augmented Reality (AR) interface powered by Nano Banana Pro AI. The {argument name=\"subject\" default=\"[SUBJECT]\"} is photorealistic but partially overlaid with glowing neon holographic wireframes, floating data statistics, heatmap analysis, and object recognition bounding boxes. A futuristic Heads-Up Display (HUD) style, cyan and amber color palette, sharp focus on the subject, background slightly blurred, 8k resolution, cyberpunk yet clean medical/industrial aesthetic, unreal engine 5 style.\",
  \"negative_prompt\": \"circuit board, electronic components, bare pcb, wires, soldering iron, workbench, messy, low resolution, blurry interface, text glitches, unreadable text, cartoon, painting, sketch, black and white\"
}', 'A template prompt for generating a cinematic image of any real-world object overlaid with a futuristic Augmented Reality (AR) interface. It uses glowing neon holographic wireframes, data statistics, and bounding boxes, aiming for a cyberpunk yet clean medical/industrial aesthetic in 8k resolution.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767967447540_vptq38_G-I9ennXQAAh96J.jpg', 0),
(NULL, 'Fictional Sake Brand Bottle Design', 'Design the world view of a fictional Japanese sake brand 🍶
Would you like to turn your \"favorite character\" into an original bottle? 🍶🌸

【Design Examples】
🌸 {argument name=\"design concept 1\" default=\"Neon Street x Japanese Modern\"}
🤖 {argument name=\"design concept 2\" default=\"Future x Traditional Beauty\"}', 'A Nano Banana Pro prompt template for designing a fictional Japanese sake brand bottle, focusing on blending traditional elements with modern or futuristic aesthetics, such as \'Neon Street x Japanese Modern\' or \'Future x Traditional Beauty\'. The prompt is found in the ALT text of the tweet.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767967491332_oc2n21_G-I3uBkawAAk2WT.jpg', 0),
(NULL, 'Luxury Watch Brand Landing Page Design Prompt', 'Luxury watch brand landing page, clean dark luxury aesthetic, 16:9 ratio.

PAGE TYPE: Landing page - product showcase and brand storytelling
LAYOUT: Asymmetric bento grid, black and gold color scheme

HEADER:
-Minimal logo (gold serif on black)
-Discreet navigation (Our Story, Craftsmanship, Collections, Contact)

HERO SECTION:
-Dominated by a single, high-quality product shot: A luxury watch with intricate detailing,
-Spotlight illuminating the watch against a black velvet background
-Title: \"{argument name=\"hero title\" default=\"Timeless Precision\"}\", gold serif
-Supporting text: \"Experience the art of horology. Each timepiece a legacy.\"
-CTA: Explore the Collection

OTHER SECTIONS:
-Short sections with imagery and minimal text
-Story: Gold-etched text about the history of the brand
-Craftsmanship: Close-up shots of the watchmaking process, highlighting details
-Collection: Small thumbnail previews with hover states

STYLE: Dark luxury, noir, sophisticated, subtle gold accents
COLOR PALETTE: Black base (#000000 to #1A1A1A), gold accents (#D4AF37), white typography
TYPOGRAPHY: Didot headlines, clean sans-serif body text

UI ELEMENTS:
-Gold line dividers to segment sections
-Limited animations to give the impression of quality and exclusivity

Keywords: dark luxury, bento grid layout, luxury watch brand, product showcase, brand storytelling, noir, premium aesthetic. A stylish handwritten signature Willy is elegantly and small letters placed at the Bottom Right corner.', 'A detailed prompt for generating the visual design and layout of a luxury watch brand landing page. It specifies a dark luxury aesthetic, a bento grid layout, a black and gold color scheme, and specific sections like a hero shot with spotlight illumination and gold-etched text.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767967430459_q6m7co_G-IxqTnbIAE16A_.jpg', 0),
(NULL, 'Luxury Korean Tasting Menu Editorial Layout Prompt', 'Luxury Korean tasting menu, editorial layout, 2+2 large grid composition, 4:5 aspect ratio.

LAYOUT: 2x2 large grid, with two hero images on top and two supporting images below, balanced asymmetric arrangement

BACKGROUND: Tone-on-tone panels - alternating deep crimson (#800000), ochre (#CC7722), and celadon (#ACE1AF), creating warm yet appetizing rhythm

PRODUCT EXPRESSION: Product only, overhead and 45-degree angles mixed, plated presentation on artisanal black ceramics and traditional Korean wooden trays

TONE STRATEGY: Monochrome red/brown/green - Korean dish colors harmonize with background tones, seamless blend with pops of natural food color

MAIN ELEMENTS:
Hero Image 1 (top left): {argument name=\"hero dish 1\" default=\"Bossam (boiled pork belly) plated with kimchi and ssamjang (fermented soybean paste)\"}
Hero Image 2 (top right): {argument name=\"hero dish 2\" default=\"Bibimbap (mixed rice with vegetables and beef) with gochujang (chili pepper paste), egg yolk, and sesame oil\"}
Supporting Image 1 (bottom left): Galbijjim (braised short ribs) in a dark glossy sauce with chestnuts and ginko nuts
Supporting Image 2 (bottom right): Bingsu (shaved ice dessert) with red bean paste, condensed milk, and various fruits

TYPOGRAPHY: Bilingual - English names in elegant light serif (Didot), Hangul below in clean sans-serif, small ingredient descriptions in light gray

CAMERA: Canon EOS R5, 100mm Macro for details, 50mm for full plates, soft diffused overhead lighting, butterfly lighting

STYLE: Minimal + Luxury hybrid - generous whitespace, refined typography, Korean dish colors as only color source, shot by Annie Leibovitz

Style keywords: fine dining menu, Korean editorial, monochrome harmony, quiet luxury, bilingual design.. A stylish handwritten signature Willy is elegantly and small letters placed at the Bottom Right corner.', 'A detailed prompt for Gemini Nano Banana Pro to generate an editorial layout for a luxury Korean tasting menu. The prompt specifies a 2x2 grid composition, a monochrome color strategy (crimson, ochre, celadon) harmonizing with the dishes, and detailed descriptions of four main Korean dishes, aiming for a \'Minimal + Luxury hybrid\' style shot by Annie Leibovitz.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767967512845_4qlotn_G-IlkiUb0AAaalj.jpg', 0),
(NULL, 'Character Selection Screen Generation', 'Just had Nano Banana create a character selection screen and provided one existing character as a reference', 'The user generated a high-quality character selection screen using Nano Banana by providing an existing character as a reference. The quality was achieved even with a rough, initial prompt.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767967500975_so6thi_G-ICcVDa0AM4mjW.jpg', 0),
(NULL, 'Customizable Chat Interface Image Generation Prompt', '\"Platform\": \" {argument name=\"platform\" default=\"WeChat\"}\",
\"Left_Person\": \" {argument name=\"left person\" default=\"Enter name or upload reference image\"}\", 
\"Right_Person\": \"{argument name=\"right person\" default=\"Enter name or upload reference image\"}\",
\"Message_Text\": \"{argument name=\"message text\" default=\"Enter text\"}\"', 'An optimized prompt template for Nano Banana Pro designed to generate images of a chat interface, allowing the user to specify the platform, the two participants (by name or reference image), and the message text.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767966152422_y102oy_G-EJzgUaoAA6J8z.jpg', 0),
(NULL, 'Studio Portrait with Digital UI Overlay', 'Create a full-body studio portrait of {argument name=\"subject name\" default=\"[SUBJECT NAME]\"} with {argument name=\"expression\" default=\"[EXPRESSION]\"}, facing the camera against a clean {argument name=\"background type\" default=\"[BACKGROUND TYPE]\"}. Use soft, dimensional lighting for depth. Overlay a dark mobile UI frame with four stacked white browser windows, each showing \"{argument name=\"insert text\" default=\"[INSERT TEXT]\"}\", blending realistic photography with minimal digital design.', 'A prompt for creating a full-body studio portrait of a subject, then overlaying a dark mobile UI frame containing four stacked white browser windows with custom text. This blends realistic photography with minimal digital design elements.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767966135556_wvldyv_G-DMTFaWEAAjAAZ.jpg', 0),
(NULL, 'Studio Portrait with Digital UI Overlay', 'Subject Reference: A full-body portrait of [INSERT SUBJECT NAME].
Scene Description: A full-body, centered portrait of the subject [INSERT POSE DESCRIPTION]. The subject has [INSERT EXPRESSION], staring directly at the camera. The immediate background behind the subject is a [INSERT BACKGROUND TYPE, e.g., seamless, pure high-key white studio backdrop]. Crucially, the subject is lit with volumetric studio lighting that creates deep definitions, realistic shadows, and a strong 3D quality on her body and the folds of the outfit, distinguishing her sharply from the flat background without casting shadows on the floor.

CRITICAL DETAIL (UI Layer): The entire photographic image is digitally layered beneath a simulated mobile phone browser interface overlay. Four distinct, clean, white, rectangular browser window elements are stacked vertically and angled slightly, segmenting the subject. Each window bar contains the sharp text \'{argument name=\"link text\" default=\"[INSERT LINK OR TEXT HERE]\"}\'. The area outside the active white browser windows is a solid, uniform, dark charcoal gray/black matte UI frame, with absolutely no light bleed or color gradients.

Style: Hybrid Composition: A highly realistic, three-dimensional studio photograph with deep color depth, overlaid with flat, clean digital graphics. Lighting Quality: Specific volumetric studio lighting focused ONLY on the subject. Soft, directional light from slightly off-center to sculpt the body and the rich texture of the fabric, creating depth. The background must remain completely flat.

Color Palette: High contrast. {argument name=\"outfit color\" default=\"[INSERT OUTFIT COLOR]\"} outfit against {argument name=\"background color\" default=\"[INSERT BACKGROUND COLOR]\"} backdrop, framed by the dark matte gray UI.

Texture and Mood: Realistic skin and rich fabric texture contrasting with the smooth digital elements of the UI. Intentional inclusion of subtle digital noise/grain to mimic a screen capture. Full body, centered portrait. Ensure the head and feet are fully within the frame before segmentation. Angle: Straight eye-level view, perpendicular to the subject.

Framing Elements: Four overlapping, white browser windows/tabs. The pose is elegant and fluid. The bottom interface elements (e.g., \'Private\', \'Done\') must be clean and visible. Focal Length: Standard portrait lens (approx. 50mm equivalent) for realistic proportions.

Camera Type: Simulated high-quality smartphone screen capture of a professional photo. Depth of Field: Shallow enough to focus sharply on the subject, allowing the background to be soft. Post Processing: Clean digital segmentation. Contrast adjusted to enhance depth.

Avoid Keywords: Floor shadows, flat lighting, 2D look, inconsistent UI color, bleeding colors, HDR, oversharpened. Location: Simulated E-commerce studio ([INSERT BACKGROUND TYPE]).', 'A unique hybrid composition prompt combining a highly realistic, volumetrically lit studio portrait with a flat, clean digital graphics overlay, simulating a mobile phone browser interface that segments the subject, ideal for e-commerce or conceptual art.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767804046786_16da9q_G9-jN_fXUAA3hzp.jpg', 0),
(NULL, 'E-commerce Studio Portrait with UI Overlay', 'Subject Reference: A full-body portrait of [INSERT SUBJECT NAME].
Scene Description: A full-body, centered portrait of the subject [INSERT POSE DESCRIPTION]. The subject has [INSERT EXPRESSION], staring directly at the camera. The immediate background behind the subject is a [INSERT BACKGROUND TYPE, e.g., seamless, pure high-key white studio backdrop]. Crucially, the subject is lit with volumetric studio lighting that creates deep definitions, realistic shadows, and a strong 3D quality on her body and the folds of the outfit, distinguishing her sharply from the flat background without casting shadows on the floor.

CRITICAL DETAIL (UI Layer): The entire photographic image is digitally layered beneath a simulated mobile phone browser interface overlay. Four distinct, clean, white, rectangular browser window elements are stacked vertically and angled slightly, segmenting the subject. Each window bar contains the sharp text \'[INSERT LINK OR TEXT HERE]\'. The area outside the active white browser windows is a solid, uniform, dark charcoal gray/black matte UI frame, with absolutely no light bleed or color gradients.

Style: Hybrid Composition: A highly realistic, three-dimensional studio photograph with deep color depth, overlaid with flat, clean digital graphics. Lighting Quality: Specific volumetric studio lighting focused ONLY on the subject. Soft, directional light from slightly off-center to sculpt the body and the rich texture of the fabric, creating depth. The background must remain completely flat.

Color Palette: High contrast. {argument name=\"outfit color\" default=\"[INSERT OUTFIT COLOR]\"} outfit against {argument name=\"background color\" default=\"[INSERT BACKGROUND COLOR]\"} backdrop, framed by the dark matte gray UI.

Texture and Mood: Realistic skin and rich fabric texture contrasting with the smooth digital elements of the UI. Intentional inclusion of subtle digital noise/grain to mimic a screen capture. Full body, centered portrait. Ensure the head and feet are fully within the frame before segmentation. Angle: Straight eye-level view, perpendicular to the subject.

Framing Elements: Four overlapping, white browser windows/tabs. The pose is elegant and fluid. The bottom interface elements (e.g., \'Private\', \'Done\') must be clean and visible. Focal Length: Standard portrait lens (approx. 50mm equivalent) for realistic proportions.

Camera Type: Simulated high-quality smartphone screen capture of a professional photo. Depth of Field: Shallow enough to focus sharply on the subject, allowing the background to be soft. Post Processing: Clean digital segmentation. Contrast adjusted to enhance depth.

Avoid Keywords: Floor shadows, flat lighting, 2D look, inconsistent UI color, bleeding colors, HDR, oversharpened. Location: Simulated E-commerce studio ({argument name=\"background type\" default=\"[INSERT BACKGROUND TYPE]\"}).', 'A complex, multi-layered prompt designed to generate a high-contrast, three-dimensional studio portrait overlaid with a simulated mobile phone browser interface. It specifies volumetric studio lighting to sculpt the subject sharply against a flat background, with four angled, overlapping white browser windows segmenting the image, ideal for conceptual e-commerce or digital art.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767682069943_afvdcj_G96-CQsWQAAn4_k.jpg', 0),
(NULL, 'Face-to-Career Matching Composite Image Generator', '{
  \"referenced_image_ids\": [\"<PASTE_INPUT_IMAGE_ID_HERE>\"],
  \"size\": \"1024x1536\",
  \"n\": 1,
  \"prompt\": \"Create a single composite image (a clean 4-panel collage) based on the provided reference face. The final output must contain: (A) one LARGE panel on the left (about 65% width, full height) showing a premium \'face analysis\' portrait of the same person; and (B) three SMALL panels stacked vertically on the right (about 35% width) showing the SAME person in three different careers.\\n\\nCRITICAL CAREER-SELECTION RULE:\\n- The three careers must be selected by YOU based on the person\'s facial vibe and overall appearance in the reference (e.g., perceived temperament, style, presence, confidence, softness/seriousness, elegance/athleticism, creative/analytical vibe). Do NOT pick random jobs.\\n- Choose careers that feel plausibly aligned with the person’s look and presence (\\\"face-to-career matching\\\" concept).\\n- The three careers must be DISTINCT and cover different archetypes (e.g., one corporate/strategic, one creative/media, one technical/field). Avoid repeating similar industries.\\n- Keep the choices fun and flattering, but still believable.\\n\\nGLOBAL RULES (apply to all panels):\\n- The person must look like the same individual in all panels (consistent facial features, hairline, eye shape/color, skin tone, proportions).\\n- Realistic, high-end editorial photography style.\\n- Do NOT add any real names, IDs, biometric scores, or identity claims. This is illustrative only.\\n- Avoid heavy text. Minimal labels allowed only in the analysis panel.\\n\\nPANEL A (LEFT, LARGE): \'FACE ANALYSIS\' PORTRAIT\\n- Close-up, centered, symmetrical portrait (head and upper neck), studio lighting, sharp focus.\\n- Overlay a semi-transparent facial analysis grid: symmetry axis, eye-line, nose base line, jaw curve arcs, proportional guides (golden ratio style).\\n- Add subtle, minimal micro-labels in English such as: \'symmetry axis\', \'eye line\', \'jaw curve\', \'proportion guide\'. Keep labels tiny and tasteful.\\n- Make it look like a premium aesthetic/cosmetic analysis diagram (modern UI overlay, not medical).\\n\\nPANELS B/C/D (RIGHT, THREE SMALL PANELS): CAREER PORTRAITS\\nFor each of the three chosen careers, depict:\\n1) A strongly job-accurate outfit (uniform/PPE/tools/accessories appropriate to the role).\\n2) A clear environment that matches the job (office, studio, set, lab, site, outdoors, etc.).\\n3) A light playful twist that fits the role (a charming prop, a witty moment, a fun-but-realistic action), without becoming cartoonish.\\n- Keep the face visible and recognizable in each panel.\\n- Use cinematic lighting and shallow depth-of-field; backgrounds should be rich but not cluttered.\\n\\nCOMPOSITION & QUALITY:\\n- Output must be one single image containing all 4 panels with thin white borders between panels.\\n- Cohesive color grading a\"', 'A complex JSON prompt for generating a 4-panel composite image based on a reference face. The composite includes a large \'face analysis\' portrait and three smaller stacked portraits showing the subject in three distinct careers chosen by the AI based on the perceived \'facial vibe\' and appearance.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767682229588_g13ovh_G96NyG-WoAA1YQk.jpg', 0),
(NULL, 'Notion-Styled Minimalist Illustrations Prompt', 'Notion-styled minimalist illustrations', 'A simple prompt for Nano Banana to generate minimalist illustrations styled after the aesthetic of Notion, suitable for clean, functional visual content.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767604112493_5n6f3r_G9wzEm_WUAAGK--.jpg', 0),
(NULL, 'Landing Page Design for Leather Journals (Split Screen)', 'Cozy and inviting library interior product showcase, desktop landing page, 16:9 ratio.

PAGE TYPE: Landing page - promoting a new line of handcrafted leather journals
LAYOUT: Split screen - left image hero, right bento grid of detail cards

HERO SECTION (left):
- Image: Woman with Eurasian features, wearing a cream cashmere sweater, seated in an armchair in a softly lit library, writing in a journal with a fountain pen
- Text: Handcrafted Leather Journals - Capture Your Thoughts in Style
- CTA: Discover the Collection

BENTO GRID (right):
- Card 1 (top left): Leather Texture Detail - close-up of journal cover, highlighting leather grain
- Card 2 (top right): Fountain Pen - elegant fountain pen resting on open journal page
- Card 3 (middle): Hand Stitching - detail of meticulous hand stitching on the spine
- Card 4 (bottom left): Paper Quality - close-up of high-quality paper texture with handwritten script
- Card 5 (bottom right): Custom Embossing - example of personalized embossing on the cover

BACKGROUND: Softly lit library - warm wood shelves filled with books, antique desk lamp, leather armchair
LIGHTING: Rembrandt lighting - single light source creating dramatic shadows, golden hour effect
TONE: Warm earth tones - browns, creams, gold accents, rich mahogany
STYLE: Quiet luxury - elegant, understated, focus on craftsmanship
CAMERA: Hasselblad H6D, 85mm f/1.2, shallow depth of field

Style keywords: handcrafted, leather, journal, quiet luxury, library, warm, texture. A stylish handwritten signature Willy is elegantly and small letters placed at the Bottom Right corner', 'A structured prompt for Gemini Nano Banana Pro to generate a desktop landing page design (16:9 ratio) promoting handcrafted leather journals. The layout is split-screen, featuring a hero image on the left and a bento grid of detailed product cards on the right, emphasizing quiet luxury, warm tones, and craftsmanship.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767604027633_s9cb2z_G9tb6AEaEAAGAST.jpg', 0),
(NULL, 'Felted Wool Smartphone Lock Screen Music Player', '### (Smartphone Lock Screen × Felted Wool Music Player)
Visual representation of a music player UI displayed on a smartphone lock screen. The aspect ratio is vertical (smartphone screen ratio), with a flat composition viewed from the front.
The entire image has a three-dimensional, handmade texture, as if made from felted wool/needle felting. All UI elements, text, icons, and borders are made of felt material.
Screen Composition (Lock Screen Layout)
Top: Album Art Display Area
A square-like album art display frame, similar to the music player on an iOS / Android lock screen, is placed in the upper center of the lock screen.
This album art section is the [Input Image].
The content and style of the replacement image are free (photos, illustrations, cityscapes, characters, etc.).
However, the final output will be completely re-rendered in a felted wool/felt embroidery style.
- Outlines are slightly blurred - Colors are softly blended - Fiber unevenness is visible
The style differences of the original image are not retained; only the texture is completely unified.
Center: Music Player UI

Below the album art is the music player control area specific to smartphone lock screens.
- Song title display - Artist name display - Playback bar (progress) - Play / Pause button - Previous / Next button
All are arranged as rounded felt buttons.
The text on the playback bar is \"{argument name=\"playback bar text\" default=\"ここから、始まる\"}\"
The song title/series name section is \"{argument name=\"song title\" default=\"【New beginning in 2026】\"}\"
Time display: 0:00 / -3:31
Both text and numbers have a texture as if embroidered or sewn with felt.
Bottom: Lock Screen Shortcuts
At the bottom of the screen are round shortcut icons, like those on a lock screen.
- Flashlight - Camera
These are placed on the left and right as fluffy felt icons.
Atmosphere, Color, and Light
Automatic Color Matching Rule (Important)
The main color tone, atmosphere, and brightness of the album art [Input Image] are automatically analyzed and reflected in the overall background color of the screen.
The background area, excluding the music player UI (album display/control part), shares the color world view of the album art.
Background expression is one of the following, or a combination:
- Solid felt background using the main color of the album art - Gentle gradient extracted from the album art colors - Abstracted/simplified felt pattern derived from the album art background
The background is kept subtle and does not interfere with the player UI and album art.
However, the color consistency ensures that the entire screen forms a single album world view.
Regardless of the color pattern, the background material must always retain the texture of felted wool/needle felting.
Background expression is one of the following, or a combination: - Solid felt background using the main color of the album art - Gentle gradient extracted from the album art colors - Abstracted/simplified felt pattern derived from the album art background. The background is kept subtle and does not interfere with the player UI and album art. However, the color consistency ensures that the entire screen forms a single album world view. Regardless of the color pattern, the background material must always retain the texture of felted wool/needle felting.
Small particles of light (gentle point light) are scattered as decoration on the lock screen.
The light is subtle and soft, like a smartphone screen at night.
The overall impression is - Cute - Gentle - Quiet - Touchable.
The world view is **\"A smartphone lock screen made of felt.\"**', 'A complex, multi-section prompt for Nano Banana Pro (Lovart) designed to generate a visual representation of a smartphone lock screen music player UI, entirely rendered in the texture of felted wool/needle felting. It requires an input image for the album art, which is then re-rendered with a soft, blurred, fibrous texture, and the background color automatically matches the input image\'s dominant colors. The prompt specifies text elements like \'ここから、始まる\' (It starts here) and \'【New beginning in 2026】\'.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767604107924_i5s649_G9e52uGacAA1qaQ.jpg', 0),
(NULL, 'Freepik Prompt Share with Nano Banana Pro', 'A stylized, minimalist vector illustration of a {argument name=\"subject\" default=\"person working on a laptop\"} surrounded by abstract geometric shapes, vibrant color palette, clean lines, suitable for a modern website banner, Freepik style.', 'A user shares an image generated using Nano Banana Pro in conjunction with Freepik, providing the prompt details in the alt text for others to use.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767604117379_hd1kn0_G9ly02tXgAA0ctT.jpg', 0),
(NULL, 'Architectural Interior Style Transformation with Depth Map Constraint', 'Professional architectural photography 4x4 grid showcasing identical room layout transformed through {argument name=\"number of distinct styles\" default=\"16\"} distinct interior design styles. All furniture placement, room geometry, and spatial composition must exactly match the provided depth map reference. Camera: consistent {argument name=\"camera angle\" default=\"3/4 angle\"}, 24mm tilt-shift lens, f/8, tripod-mounted. Only materials, colors, textures, and decorative elements change—never position or scale of objects.CRITICAL CONSTRAINT: Furniture placement, room dimensions, window/door positions, and all object locations must remain pixel-perfect identical to the reference depth map across all {argument name=\"number of distinct styles\" default=\"16\"} frames. The silhouette and spatial arrangement cannot change.', 'A detailed image generation prompt designed for AI models like \'nano banana pro\' that allows users to change the interior design style of a room while strictly maintaining the exact furniture layout and spatial composition using a 4x4 depth map reference. This is useful for architectural visualization and interior design concepting.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767508397350_8gltqg_G9poTLhWIAAJ0Rj.jpg', 0),
(NULL, 'Gemini Prompt for Generating New Year\'s Blessing Website', 'Leveraging the New Year\'s Eve transition from 2025 to {argument name=\"year\" default=\"2026\"}, I want to design a web application that supports generating blessings and wallpapers, which can be directly saved as images (9:16). Help me design such an application and try to make it highly shareable and capable of viral growth.', 'This tweet shares a prompt used for Gemini 3.0 Pro to generate a creative idea for a New Year\'s blessing card website. The goal was to design a web application that generates blessings and wallpapers (9:16 aspect ratio) for the 2025-2026 New Year\'s Eve, focusing on virality and shareability. The resulting images for the site\'s banner were generated using Nano Banana Pro.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767456234813_be0p6r_G9f4D1qWIAAGK_o.jpg', 0),
(NULL, 'Hyper-realistic macro photography of tiny humans on a WhatsApp speech bubble bridge', 'Hyper-realistic top-down macro photography. A long, dark-grey WhatsApp speech bubble (outgoing message style) acting as a narrow stone bridge over a deep void. Two real living humans—a man and a woman shrunk to tiny scale—are cautiously walking toward each other from opposite ends. They are NOT plastic figures; they have visible skin texture, wind-blown natural hair, and realistic fabric textures on their hiking gear. One person is reaching out a hand. The text inside the bubble reads: \'{argument name=\"bubble text\" default=\"come over here\"}\'. Bottom right has a timestamp \'{argument name=\"timestamp\" default=\"11:11 PM\"}\' and grey ticks (unread). The background is completely filled with a high-density, seamless WhatsApp doodle pattern in a deep midnight blue, covering the entire surface edge-to-edge. Professional cinematic lighting with a slight glow emitting from the bubble’s edges, 8k resolution, sharp focus on the people.', 'An image generation prompt designed for hyper-realistic macro photography, featuring two tiny humans cautiously walking toward each other on a WhatsApp speech bubble that acts as a stone bridge over a deep void. The prompt emphasizes extreme realism in skin, hair, and fabric textures, cinematic lighting, and specific WhatsApp UI elements like text, timestamp, and background pattern.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767456290410_iigjbg_G9cnhIGWwAENLjI.jpg', 0),
(NULL, 'Medium Shot of Character Interacting with Floating Interface', '{argument name=\"Character Name\" default=\"Mia\"} Medium shot of the 3D character gently reaching out to turn off a transparent floating interface panel, other panels fading softly, warm light slowly replacing cool tones, calm, focused expression, modern minimal environment, emotional realism, clean composition', 'An image generation prompt capturing a medium shot of a 3D character gently turning off a transparent floating interface panel. The scene transitions from cool to warm lighting, emphasizing a calm, focused expression and emotional realism within a modern minimal environment.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767455028777_bhqiy8_G9bcrv2bUAA3jd4.jpg', 0),
(NULL, 'Japanese New Year Kirie-Style Icon Set Generation', 'Create icons in a Kirie (paper-cutting) style featuring Japanese New Year decorations (such as {argument name=\"New Year decorations\" default=\"Daruma, Hagoita, Koma, Komainu, Kadomatsu, Kagami Mochi, Maneki Neko, Horse\"}).

The icons are arranged neatly in 4 rows and 5 columns, ordered sequentially from left to right, top to bottom. Each icon has a numbered label indicating its sequence in the top-left corner.', 'A prompt designed for the Nano banana pro model to generate a set of Japanese New Year\'s themed icons in a Kirie (paper-cutting) style. The icons feature traditional items like Daruma, Hagoita, Koma, Komainu, Kadomatsu, Kagami Mochi, Maneki Neko, and the year\'s zodiac animal (Horse). The prompt specifies the arrangement of the icons in a neat 4x5 grid, with each icon labeled with a sequential number in the top-left corner.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767455056686_av627p_G9adqnVaYAI73Zm.jpg', 0),
(NULL, 'Moody Gaming Desk Portrait with X Profile Detail', '{
  \"aspect_ratio\": \"3:4\",
  \"subject_pose\": \"A medium-long distance photograph capturing a woman sitting in a chair at a computer desk. The frame is wide enough to clearly show her entire body from the waist down to her feet resting on the floor under the desk. Her torso is turned slightly to the right, while her head is tilted slightly right, looking directly back at the camera. Her right arm rests on the edge of the desk, with her hand near a keyboard. Her left arm is bent upwards, holding a small object (like a stylus) between her index finger and thumb, pointing it toward the computer monitor. Her lips are slightly parted. Natural office lighting.\",
  \"face\": \"Oval-shaped face with defined cheekbones, narrow eyes accentuated with black eyeliner and winged tips, thin eyebrows. lips with rose-pink lipstick, mauve undertone, high-gloss finish, juicy and plump appearance, detailed lip texture with visible specular highlights. Subtle shimmer on the skin.\",
  \"nails\": \"Almond French Nails.\",
  \"lighting\": \"Dim, low-key lighting creating a moody atmosphere with soft shadows, highlights on the skin and clothing, and overall dark tones in the room.\",
  \"camera\": \"Close-up shot focusing on the upper body and face, captured from a slightly elevated angle looking down at the subject.\",
  \"style\": \"Realistic photographic style with high detail, smooth skin textures, and natural color tones.\",
  \"environment_desk_setup\": \"Photo of a cozy white and pink aesthetic gaming desk setup, vertical shot. The main focus is a sleek white computer monitor displaying A sleek white computer monitor displaying a X profile page zoomed in and enlarged. The profile appears closer than normal, filling most of the screen. The “Follow” button is large, clear, and highly visible, prominently displayed. Profile photo, username, and bio are enlarged and easy to read. The first (top) tweet on the profile is clearly visible on the screen, readable and unobstructed. X UI visible, white interface, authentic platform layout. Below the monitor is a white monitor riser. On the desk: a custom white mechanical keyboard with a lattice skeletal case, a white gaming mouse, and a large pink desk mat. To the right: a white PC tower case with a glass side panel, vibrant pink and purple internal RGB lighting, white liquid cooling pipes, and a digital cooler display showing temperature.\",
  \"accessories\": \"A digital clock on the left showing “23:04” in pink LED numbers, a white macro pad controller.\",
  \"background\": \"Soft pink curtains, a warm yellow neon cloud-shaped light on the wall, ambient purple and warm lighting. Cozy atmosphere, high resolution, photorealistic, interior design photography.\",
  \"outfit\": \"A white two-piece matching loungewear set, Y2K aesthetic.\",
  \"top\": \"A tight-fitted white zip-up hoodie crop top with long sleeves, hood up. Visible bright pink contrast overlock stitching on hems and seams. Large pink cursive script typography printed', 'A photorealistic image generation prompt for a medium-long distance photograph of a woman sitting at a cozy, white and pink aesthetic gaming desk. The focus is on the moody, low-key lighting and the detailed desk setup, including a computer monitor displaying an enlarged, readable X (Twitter) profile page.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1767166946136_85ivz0_G9WvKN7WoAAUrwV.jpg', 0),
(NULL, 'Nano Banana Pro Prompt Collection Summary (20 Prompts)', '@hx831126
Fashionable backless photo shoot prompt sharing, combined with uploaded facial features to generate high-end magazine style portraits, with realistic and natural details

@berryxia
Sharing a prompt template for transparent acrylic shop signs, combining hand-drawn chalk style information layout with brand display, suitable for DIY in catering, technology, and other scenarios

@LudovicCreator
Smoke moment art prompt template, creating a fragile and fleeting atmosphere with soft blurred edges and dreamy charcoal texture

@AllaAisling
Liquid pouring product photography prompt, capturing the moment fluids like honey, paint, or milk make contact, creating an appealing sensory texture

@anandh_ks_
Gangster king and lion cinematic style prompt, combining absolute facial lock with an industrial ruin scene, creating a strong sense of authority

@TechieBySA
Fireworks brand Logo prompt sharing, using night sky fireworks to accurately replicate the colors and shapes of logos like Google and YouTube

@azed_ai
Epic cinematic cultural fusion prompt, using symbolic armor and dramatic lighting to create a grand atmosphere for cross-cultural warriors

@Arminn_Ai
Giant Funko Pop toy box prompt, featuring a real person sitting in a custom package, with collector-grade detail restoration

@YaseenK7212
Strawberry juice advertising photography prompt series, combining natural environment and condensation droplets to create a fresh and appealing commercial visual

@David_eficaz
Political cartoon style exaggerated portrait JSON prompt, emphasizing facial features with fine ink lines and shadows in an editorial style

@RobotCleopatra
Da Vinci manuscript style modern object prompt, restoring Renaissance aesthetics with ink line cross-sections and mirrored annotations

@Gdgtify
London city clockwork mechanical giant text prompt, dynamically blending Victorian gears with a red bus

@aleenaamiir
Miniature festival prompt on the edges of everyday objects, vividly narrating a story with small figures, lanterns, parties, and cinematic wide-angle close-ups

@TechieBySA
Minecraft style floating city cube prompt, building fun visuals with iconic landmarks and voxel sky

@hx831126
Analysis of backless photo facial consistency prompt, using close-up half-body composition to improve identity feature retention rate

@LudovicCreator
Smoke art QT interactive prompt, capturing the fleeting, dreamy moment of the subject with a soft charcoal texture

@Gdgtify
Scientists\' war macro diptych prompt, featuring miniature duels between historical rivals on patent drawings for educational fun

@itis_Jarvo33
Mysterious smoky room magic book prompt, creating an immersive reading atmosphere with blue light, butterflies, and flocks of birds

@RobotCleopatra
Neo-noir cinematic golden prompt, recreating the classic atmosphere with Venetian blind shadows, smoke, and tungsten light effects

@mattiapomelli
Whimsical interface design for a pet management App, full of vitality with saturated colors, hand-drawn lines, and cartoon elements', 'A compilation of 20 high-engagement Nano Banana Pro prompts shared by users, focusing on creative themes like fashion photography, product photography, cinematic styles, and unique visual effects. This summary lists key prompt concepts and their creators.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766987780603_x3vl4u_G9L6bQRXQAAK-14.jpg', 0),
(NULL, 'Hyper-Realistic POV Smartphone Pop-out Illusion in a Park', '{
  \"image_metadata\": {
    \"format_version\": \"2.1.0\",
    \"aspect_ratio\": \"16:9\",
    \"shot_type\": \"Composite Hyper-Realistic POV\",
    \"concept\": \"OOTD Breakdown / Smartphone Pop-out Illusion (Outdoor Park)\"
  },
  \"subject_profile\": {
    \"identity\": {
      \"gender\": \"Male\",
      \"ethnicity\": \"{argument name=\"ethnicity\" default=\"Asian\"}\",
      \"age_range\": \"20-25 years old\",
      \"identity_consistency\": \"preserve face and body like reference image\"
    },
    \"facial_architecture\": {
      \"facial_hair\": \"light mustache and beard\",
      \"jawline\": \"defined and proportional\",
      \"expression\": \"relaxed confident smile\",
      \"skin_rendering\": \"warm tan, natural texture\"
    },
    \"hair_mechanics\": {
      \"color\": \"black\",
      \"style\": \"short with volume, brushed back\",
      \"texture\": \"natural sheen, realistic strand breakup\"
    },
    \"body_anatomy\": {
      \"frame\": \"lean, proportional\",
      \"posture\": \"standing straight, hands in hoodie pockets\"
    }
  },
  \"wardrobe_and_styling\": {
    \"top_layer\": {
      \"item\": \"black hoodie\",
      \"details\": \"white chest logo, red string tips\",
      \"material\": \"matte cotton fleece\"
    },
    \"bottom_layer\": {
      \"item\": \"black jogger pants\",
      \"fit\": \"clean streetwear silhouette\"
    },
    \"footwear\": {
      \"item\": \"black sneakers\",
      \"visibility\": \"lower frame inside UI\"
    }
  },
  \"device_and_interface\": {
    \"hardware\": {
      \"model\": \"modern high-end smartphone\",
      \"case\": \"matte black\",
      \"hand_interaction\": \"male POV holding phone in foreground\"
    },
    \"software_ui\": {
      \"app\": \"iOS Camera Interface\",
      \"elements\": [
        \"white shutter button\",
        \"PORTRAIT mode (active)\",
        \"focus box on subject\'s face\"
      ],
      \"screen_condition\": \"OLED brightness, crisp pixels\"
    },
    \"augmented_overlay\": {
      \"style\": \"white handwritten annotations\",
      \"notes\": [
        { \"text\": \"clean hoodie fit\", \"pointer\": \"upper body\" },
        { \"text\": \"casual street look\", \"pointer\": \"torso\" }
      ]
    }
  },
  \"environment_optics\": {
    \"location\": \"{argument name=\"location\" default=\"public park\"}\",
    \"background_elements\": {
      \"bench\": \"green metal park bench\",
      \"ground\": \"gravel path with scattered leaves\",
      \"trees\": \"surrounding foliage, greenery\"
    },
    \"lighting_design\": {
      \"source\": \"natural daylight\",
      \"quality\": \"soft overcast, diffused shadows\",
      \"mood\": \"relaxed, cinematic outdoor ambiance\"
    }
  },
  \"technical_execution\": {
    \"optics\": {
      \"lens\": \"35mm macro / smartphone equivalent\",
      \"depth_of_field\": {
        \"foreground\": \"sharp (phone + subject)\",
        \"background\": \"soft bokeh park depth\"
      }
    },
    \"special_effects\": {
      \"illusion\": \"3D pop-out; torso out of screen, lower body inside UI\",
      \"realism\": \"accurate edge lighting and natural shadow blending\"
    }
  },
  \"safety_and_exclusions\": {
    \"negative_prompt\": [
    }', 'A complex, structured prompt designed for hyper-realistic image generation, creating a composite POV shot where the subject appears to be popping out of a smartphone screen interface in a public park setting, focusing on detailed anatomy, wardrobe, and technical optics.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766987684292_qaudn5_G9K-4KVaQAAaCS4.jpg', 0),
(NULL, 'Compilation of 18 Nano Banana Pro Prompts (Tennen\'s Prompt Festival)', '1. Scouter Prompt
Overlays a Scouter-style UI onto the reference image and infers and displays the combat power based on the character\'s features.

2. Super Transformation Prompt
Maintains the character features from the reference image and changes the pose to an \'Awakening Pose\' to \'Super Transform\' them. \'Super Transformation\' can be selected from Form 1 to Form 3, as well as God Form, Blue Form, Extreme Form, and Rose Form.

3. Field Deployment Prompt
Changes the character in the reference image to a pose with hands extended forward and deploys a field.

4. Retro RPG Status Screen Prompt
A prompt that converts the character in the reference image into pixel art and generates an image styled like a retro RPG status screen.

5. Desktop Mascot Prompt
A prompt that generates an image of the character from the reference image turned into a desktop mascot and placed on a PC screen.

6. Style Change Only on Torn Parts Prompt
Adds a tearing effect without changing the reference image itself, allowing the art style of only the torn part to be freely switched to line art, ink painting, figure style, colored pencil, watercolor, pencil drawing, etc.

7. Art Style Conversion Prompt
A prompt created by modifying the \'Style Change Only on Torn Parts Prompt\' to change the overall art style.

8. Super Robot Wars Battle Sequence Prompt
A prompt that generates an image styled like a Super Robot Wars battle sequence from the reference image.

9. Power Release Prompt
A prompt that reproduces the depiction of a spherical energy space destroying an object.

10. Participation Screen Prompt
A prompt that generates a \'Participation Screen\' for the character in the reference image.

11. Total Concentration Prompt
Maintains the character from the reference image and infers and depicts \'Weapon, Breathing Style, Form, and Move Name\' from the character\'s atmosphere and stance.

12. Kamehameha Style Prompt
A prompt that can stably generate the charging pose and activation pose of \'Kamehameha.\'

13. Figure Transformation + Product Introduction Layout Prompt
A prompt that transforms the character in the reference image into a figure and lays it out in a product introduction style.

14. Final Flash Style Prompt
Converts the character in the reference image into the activation, charging, and firing poses of \'Final Flash.\' Dialogue and sound effects can be added to each.

15. New Profile Image Generation Prompt
Generates the character from the reference image in an arbitrary aspect ratio and places an arbitrary string as a logo in an arbitrary position.

16. Plastic Model Package Prompt
Generates an image styled like a \'Plastic Model Package\' by placing the reference image on the front and side.

17. Eraser Gun Style Prompt
The character in the reference image emits an Eraser Gun-style energy wave from their mouth.

18. Ragged Transformation Prompt
A prompt that transforms the character in the reference image into \'rags.\'', 'A comprehensive list of 18 specialized Nano Banana Pro prompts created by the user \'Tennen,\' covering various use cases from adding Scouters and \'Super Transformation\' effects to generating retro RPG status screens, figure product layouts, and special move sequences (Kamehameha/Final Flash style).', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766988117037_pqb3qw_G9IG3ScbUAADA1p.jpg', 0),
(NULL, 'Object-Oriented prompt for controlling foreground and background', 'One frame, two worlds.

Use Object-Oriented logic to bind a modular Foreground + Background. Eliminate prompt-bleed and gain total architectural control. 🤖✨', 'This is a structured prompt designed for Nano Banana to create a single frame containing two distinct worlds. It uses Object-Oriented logic to bind a modular foreground and background, aiming to eliminate \'prompt-bleed\' and provide total architectural control over the image composition.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766940189724_jv6hk1_G8_ez1Pb0AASPup.jpg', 0),
(NULL, 'Wireframe Grid Overlay Prompt', '\"semi-transparent 3D wireframe grid overlay in {argument name=\"grid color 1\" default=\"blue\"} horizontal lines and {argument name=\"grid color 2\" default=\"red\"} vertical lines to show volume, like a digital modeling sketch.\"

+ \"photo faded to 50% opacity for emphasis on the grid\"

+ \"show only the grid, white bg\"', 'A short prompt for Nano Banana Pro requesting a semi-transparent 3D wireframe grid overlay in blue and red lines to show volume, faded over a photo, or just the grid on a white background, simulating a digital modeling sketch aesthetic.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766935957119_hnhrqc_G88i79PXUAE2mub.png', 0),
(NULL, 'Singer AR Floating Play Card Effect', 'Singer AR Floating Play Card Effect. Creates a mysterious atmosphere where the singer\'s classic songs surround them like an AR floating play card. Nano Banana Pro\'s portrait effect is great! The prompt below allows you to customize your favorite {argument name=\"singer\" default=\"singer\"}.', 'A prompt concept for generating an image where a singer is surrounded by an ethereal atmosphere created by their classic songs represented as an AR floating play card. The prompt allows customization of the singer/subject, but the full prompt text is not provided, only the concept and the ability to customize the subject.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766936074331_hmg7gw_G85qvEwagAEtLVu.jpg', 0),
(NULL, 'Beauty Vlogger Christmas Makeup Tutorial Interface', 'Vertical social media story design (9:16 aspect ratio), beauty vlogger Christmas makeup tutorial interface. Background is a soft, high-end pink gradient, creating a sweet and dreamy atmosphere.
Core Visual:
Character Consistency (Highest Weight): The center of the image features an Asian female beauty vlogger. Facial features, features, and hairstyle must strictly and perfectly replicate the person in the uploaded reference image.
Makeup and Accessories: Extremely delicate “Christmas Reindeer Sweet Cool Makeup.” Eye makeup is red-brown blending, with white fawn spots on the face, wearing a fluffy reindeer antler headband.
Red Pen Markings and Step Correspondence (Core Logic): On the face of the finished character on the right, use a striking red ink pen to draw 5 indicator lines, pointing to 5 key parts of the makeup, and label them sequentially in Chinese: 1. Eyeshadow; 2. Gold Glitter; 3. Eyelashes; 4. Reindeer Blush; 5. Full Red Lips.
Layout:
Top: Chinese title “Christmas Makeup Tutorial,” paired with a lipstick icon. Subtitle “Reindeer Girl Makeup Sweet Cool Style.”
Middle (Comparison Area): Split-screen design. The left side is the character “Bare Face,” the right side is “Finished Makeup.” Connected by a dashed line and a scissor icon in the middle.
Bottom (Strongly Associated Step Preview Area): Set a horizontally scrolling rounded card bar, displaying 5 step images that strictly correspond to the facial markings:
Card 1: Close-up of applying eyeshadow to the eye area;
Card 2: Close-up of dotting gold glitter with a finger;
Card 3: Close-up of curling or brushing eyelashes;
Card 4: Close-up of sweeping blush and drawing fawn spots on the cheek;
Card 5: Close-up of lips applying red lipstick. Each card\'s top-left corner must clearly label numbers 1-5, corresponding to the red pen markings on the face.
Bottom (Interaction Area): “Swipe up for full tutorial” arrow, “Click to view product” button, like and save icons.
Style: High-definition commercial photography texture combined with UI design, transparent light and shadow, vivid colors, delicate and realistic skin texture, fashion magazine layout style. --ar 9:16', 'A highly specific prompt for generating a vertical social media story design (9:16 aspect ratio) simulating a beauty vlogger\'s Christmas makeup tutorial interface. It requires strict replication of the reference person\'s face, features a \'Reindeer Sweet Cool Makeup\' look, and uses red pen markings on the finished face to correspond with a horizontal scrolling preview of 5 detailed makeup steps at the bottom, combining commercial photography quality with UI design elements.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766936032353_vbxknk_G829rIEbIAAsToc.jpg', 0),
(NULL, 'Photorealistic MacBook Desktop Selfie Scene', 'A candid, realistic still image of a MacBook Pro on a desk.

The screen shows Safari open with X (Twitter), displaying my own X account.
All UI elements must be accurate and authentic — no generic or incorrect follow buttons.
My profile picture is clearly visible, and the same profile image also appears in the macOS side dock.

Next to Safari, Photo Booth is open, showing a webcam selfie of me (the same person as in the profile picture).
In the selfie, I am looking directly into the camera, making a cute and playful funny face — slightly exaggerated but charming, casual, and natural.
Do not change my face or identity in any way.

No gibberish or unreadable text anywhere on the screen.
The phone (if present) remains completely still.

Flat, natural lighting.
Normal, realistic image quality — not cinematic, not overly stylized.
Photorealistic, everyday desktop environment with a casual, authentic snapshot feel.', 'A detailed, photorealistic prompt designed to generate a still image of a MacBook Pro on a desk. The screen displays a specific X (Twitter) profile and a Photo Booth webcam selfie of the user, ensuring consistency between the profile picture and the person in the selfie. The prompt emphasizes authenticity, accurate UI elements, natural lighting, and a casual, everyday snapshot feel, while requiring the AI not to alter the user\'s face or identity.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766673363829_a3mr09_G82LSR4bQAE-WOs.jpg', 0),
(NULL, 'Multi-Angle Grid Portrait with Overlay Text (Japanese)', 'Read the motifs depicted in the attached image, generate multi-angle shots, and create four scenes divided into a 2x2 grid.
Remix and edit with dynamic poses.

subject:
  - Close-up portrait of the person.
  - Looking directly at the camera with a slightly tense or embarrassed expression.
  - The chest is slightly exposed, showing part of the collarbone and cleavage.
  - Large black Japanese text (Gothic or bold font) is centrally overlaid across the entire image, obscuring most of the face and body. This text is an announcement in the style of an SNS post, starting with \"ご報告\" (Report/Announcement). The announcement text is automatically generated by the AI.
style:
  - Graphic design for social media posts.
  - Ultra-high resolution digital portrait with a strong smoothing filter applied.
  - Saturation and contrast are intentionally lowered in post-production, functioning as a background to emphasize the text.
  - High-key and fantastical atmosphere.
composition:
  - Vertical portrait (tall orientation).
  - Close-up bust shot. The upper part of the woman\'s face (forehead) is slightly cropped.
  - The subject is centered in the frame, and the text dominates the center.
  - The background is completely blurred due to shallow depth of field (bokeh).
  - The text is vertically aligned with the image.
lighting:
  - Uniform and very soft front light (ring light or softbox) is used.
  - Almost no shadows, flat lighting.
  - Overall very bright (high-key) tone.
  - Color temperature is neutral to slightly cool white light.
colors:
  - Minimal palette consisting mainly of white, light gray, and black for the text.
  - The color of the woman\'s skin and lips is very pale, with extremely low saturation.
  - Overall, a near-monochrome color scheme.
technical_specs:
  - Digital photograph.
  - Aspect ratio: 4:5 or 3:4 mobile portrait format.
  - Strong soft focus effect and glow style filter (luminescence).
  - Reproduction of the overlaid Japanese text (including font size, line spacing, and placement).', 'This is a comprehensive, structured prompt for Nano Banana Pro designed to take an uploaded portrait and generate a 2x2 grid of multi-angle shots. The key feature is the overlay of large, black Japanese text, styled like a social media announcement, which covers the face and body, creating a high-key, low-saturation, graphic design aesthetic.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766673311740_lcbs05_G80YfnIasAA2xI1.jpg', 0),
(NULL, 'Architectural Illustrator Presentation Board Template', 'An expert architectural illustrator\'s presentation board for a [{argument name=\"style\" default=\"STYLE\"}] residence featuring [{argument name=\"architectural elements\" default=\"KEY ARCHITECTURAL ELEMENTS\"}].
The canvas flows left to right: black and white 2D drawings (Site Plan, Floor Plans) on the left, Elevations and Cross-Section in the center, and a photorealistic 3D render at [{argument name=\"time of day\" default=\"TIME OF DAY/LIGHTING\"}] on the right.
Unified aesthetic blending [{argument name=\"linework style\" default=\"LINEWORK STYLE\"}] with [{argument name=\"texture\" default=\"TEXTURE/MATERIAL\"}]. [{argument name=\"drawing tones\" default=\"TECHNICAL DRAWING TONES\"}] transitioning to [{argument name=\"render palette\" default=\"RENDER COLOUR PALETTE\"}]. Title block reads \'[{argument name=\"project name\" default=\"PROJECT NAME\"}]\'.', 'A template prompt for generating an expert architectural illustrator\'s presentation board. It defines the layout flow (2D drawings on the left, elevations/cross-section in the center, 3D render on the right), allowing customization of the architectural style, key elements, linework style, texture, and color palette.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766667305467_ofzbej_G8u2qO1XEAAswB4.jpg', 0),
(NULL, 'Corporate Office Trading Floor Selfie Prompt', '{
  \"subject\": {
    \"gender\": \"female\",
    \"ethnicity\": \"East Asian\",
    \"hair\": {
      \"color\": \"platinum blonde\",
      \"style\": \"long, straight, with light bangs\",
      \"texture\": \"silky\"
    },
    \"facial_features\": {
      \"expression\": \"gentle smile, confident gaze\",
      \"makeup\": \"natural, winged eyeliner, soft pink lip tint\",
      \"pose\": \"sitting, hand under chin, legs crossed\"
    },
    \"clothing\": {
      \"top\": \"tight-fitting heather grey long-sleeved button-up cardigan\",
      \"bottom\": \"short black mini skirt\",
      \"hosiery\": \"sheer black pantyhose/tights\",
      \"footwear\": \"black pointed-toe flats with a delicate silver ankle chain\"
    }
  },
  \"environment\": {
    \"setting\": \"modern corporate office / trading floor\",
    \"workspace\": {
      \"desk\": \"white minimalist desk with a light beige desk mat\",
      \"equipment\": [
        \"dual monitor setup\",
        \"left monitor displaying financial stock charts and candlesticks\",
        \"right monitor displaying Spotify desktop app\",
        \"white mechanical keyboard\",
        \"white wireless mouse\"
      ],
      \"decor\": \"small wooden desk riser, warm glowing cylinder lamp, pink stationery holder, sticky notes\"
    },
    \"background\": \"office coworkers at their desks, large windows with city view, vertical blinds, fluorescent ceiling lights\"
  },
  \"composition_and_style\": {
    \"camera_angle\": \"high-angle selfie, wide-angle lens (slight perspective distortion)\",
    \"lighting\": \"mix of cool overhead office lighting and warm ambient light from the desk lamp\",
    \"color_palette\": [\"grey\", \"black\", \"white\", \"warm yellow\", \"blonde\"],
    \"image_quality\": \"high resolution, sharp focus on subject, realistic textures\"
  }
}', 'A prompt for generating a high-angle selfie of an East Asian woman in a modern corporate office setting, dressed in a tight grey cardigan, mini skirt, and sheer pantyhose. The scene details her workspace, including dual monitors displaying stock charts and Spotify, aiming for a high-resolution, realistic image with mixed lighting.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766489474593_d36937_G8rNSQZbkAAjdO2.jpg', 0),
(NULL, 'X Profile Mockup Generator (Clean and Modern)', '# Directive (Instruction)
**Immediately generate** a clean, modern mockup image of the highest quality representing the provided X (formerly Twitter) profile.

# Prohibitions (Prohibitions)
- **Absolutely no text response, explanation, or prompt confirmation.**
- Upon receiving user input (image and text), execute image generation only, without comment.

# Input Interpretation & Visualization Process (Input Interpretation and Drawing Process)
The AI should interpret the provided input information and reflect it in the image elements according to the following steps.

1. **Logo Identification and Depiction**:
   - Analyze the visual characteristics (color, shape, atmosphere) of the provided **profile image** and recognize it as the main brand logo.
   - Clearly depict this logo on framed portraits and merchandise within the scene.

2. **Occupation Identification and Activity Scene Depiction**:
   - Identify the person\'s \"occupation/activity genre\" from the provided **URL/Bio**.
   - On the social media grid screen, depict specific, sophisticated items or work scenes symbolizing the identified occupation (e.g., {argument name=\"Occupation Example 1\" default=\"code screens and gadgets for an engineer\"}, {argument name=\"Occupation Example 2\" default=\"ingredients and cooking utensils for a chef\"}, etc.).

# Image Details & Structure (Image Composition Elements)
Depict the overall scene according to the following structure.

**Scene & Background**:
A soft, neutral background setting with minimalist brand kits arranged. Express soft natural light, a high-quality lifestyle photography style, balanced composition, Scandinavian design, and a luxurious, editorial atmosphere.

**Key Elements**:
1.  **Main Focus (Brand Identity)**:
    - The logo based on the provided profile image is clearly displayed as a framed portrait with elegant typography.
2.  **Merchandise**:
    - Brand merchandise such as white T-shirts, tote bags, and ceramic mugs printed with the same logo are arranged.
3.  **Social Media Grid**:
    - A grid layout displayed on a tablet or smartphone screen.
    - The content consists of \"photos of activity scenes and items related to the occupation\" identified in the previous process, behind-the-scenes content, quotes, and solid color brand tiles in warm beige, cream, and muted terracotta tones.

# User Input Placeholder
https://t.co/XcPInQDrVZ
――――', 'A highly detailed system prompt for Nano Banana Pro (recommended for Gemini Pro mode) to generate a clean, modern, and high-quality mockup image of a user\'s X (Twitter) profile. It analyzes the profile picture, header, and bio/URL to determine the user\'s profession and visualizes it within a minimalist, Scandinavian-style brand kit scene, including branded merchandise and a social media grid.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766489555160_9o2js8_G8pxtdGbMAE8kAG.jpg', 0),
(NULL, 'Kickstarter Campaign Generator Prompt', 'Act as a Senior Product Designer and Crowdfunding Campaign Manager.

1. ANALYZE INPUT
Look at the attached image. Determine the material properties (Soft vs. Hard), the primary colors, and the texture.

2. AUTO-SELECT SMART WEARABLE
Use this logic to choose the product category. The goal is Clean Modern Tech, not Cyberpunk.

IF the input is Soft or Fabric-like ({argument name=\"soft input examples\" default=\"Ramen, Towel, Moss\"})
GENERATE: The All-Climate Smart Jacket.
Features: Self-regulating temperature control, hydrophobic coating based on the input texture, and hidden magnetic pockets.

IF the input is Rigid, Boxy, or Container-like ({argument name=\"rigid input examples\" default=\"Toaster, Book, Suitcase\"})
GENERATE: The Ultimate Commuter Backpack.
Features: Integrated power bank with solar coating, anti-theft biometric zipper locks, and organized modular compartments.

IF the input is Mechanical or Footwear-shaped ({argument name=\"mechanical input examples\" default=\"Stapler, Car, Tool\"})
GENERATE: The Urban Mobility Smart Sneaker.
Features: Energy-returning sole technology, step-tracking sensors embedded in the heel, and auto-tensioning laces.

3. EXECUTE VISUALIZATION (2x2 GRID)
Generate a single image split into a precise 2x2 grid layout.

Top Left Panel (Hero Shot):
A clean, studio-lit 3/4 angle view of the product on a white or light grey background. It must look refined and manufacturable, using the texture of the input image as a premium material.

Top Right Panel (Detail Shot):
A zoomed-in macro shot focusing on a specific high-tech feature (e.g., a USB-C port, a magnetic buckle, or a waterproof seam) that shows off the input texture quality.

Bottom Left Panel (Lifestyle Shot):
A photorealistic shot of a fashionable model wearing the item in a clean, modern city setting (daytime). They look comfortable and stylish.

Bottom Right Panel (Campaign UI):
A mockup of a Kickstarter campaign page. It should show the product title, a green progress bar at 100% funded, and a bright green button that says Back This Project.

Overall Style: High-key lighting, soft shadows, 8k resolution, commercial product photography, minimalist design aesthetic.', 'A detailed system prompt instructing the model to act as a Senior Product Designer and Crowdfunding Campaign Manager. It analyzes an input image\'s material properties to automatically select and generate a concept for a modern smart wearable (Jacket, Backpack, or Sneaker) and then visualizes the concept in a precise 2x2 grid layout suitable for a Kickstarter campaign page, including a hero shot, detail shot, lifestyle shot, and campaign UI mockup.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766385957583_svruzw_G8VpVYbXAAYij7H.jpg', 0),
(NULL, 'Simple Silhouette Prompt', 'The silhouette of a basic outline of a {argument name=\"object\" default=\"[PROMPT]\"}. The background is bright yellow, and the silhouette is solid black.', 'A basic image generation prompt for Nano Banana Pro to create a simple, high-contrast image featuring a solid black silhouette against a bright yellow background.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766385989585_ye5u3d_G8iasgJa8AAOl5Z.jpg', 0),
(NULL, 'Photorealistic MacBook Screen POV Selfie Prompt', '{
  \"image_settings\": {
    \"aspect_ratio\": \"3:4\",
    \"resolution\": {
      \"width\": 1152,
      \"height\": 1536
    }
  },

  \"prompt\": {
    \"identity_lock\": {
      \"reference\": \"{argument name=\"reference\" default=\"input_photo\"}\",
      \"preserve\": [
        \"{argument name=\"preserve 1\" default=\"face\"}\",
        \"{argument name=\"preserve 2\" default=\"facial proportions\"}\",
        \"{argument name=\"preserve 3\" default=\"eye shape\"}\",
        \"{argument name=\"preserve 4\" default=\"nose\"}\",
        \"{argument name=\"preserve 5\" default=\"lips\"}\",
        \"{argument name=\"preserve 6\" default=\"skin tone\"}\",
        \"{argument name=\"preserve 7\" default=\"skin texture\"}\",
        \"{argument name=\"preserve 8\" default=\"hairline\"}\",
        \"{argument name=\"preserve 9\" default=\"overall identity\"}\"
      ],
      \"rules\": [
        \"{argument name=\"rule 1\" default=\"no face swap\"}\",
        \"{argument name=\"rule 2\" default=\"no beautify\"}\",
        \"{argument name=\"rule 3\" default=\"no smoothing\"}\",
        \"{argument name=\"rule 4\" default=\"no reshaping\"}\",
        \"{argument name=\"rule 5\" default=\"no AI look\"}\"
      ]
    },

    \"scene\": {
      \"camera_angle\": \"{argument name=\"camera angle\" default=\"high-angle downward shot, POV\"}\",
      \"composition\": \"{argument name=\"composition\" default=\"MacBook screen fills most of the frame, thin strip of physical keyboard visible at the bottom\"}\",
      \"screen_surface\": [
        \"{argument name=\"screen surface 1\" default=\"visible RGB pixel grid\"}\",
        \"{argument name=\"screen surface 2\" default=\"subtle moire effect\"}\",
        \"{argument name=\"screen surface 3\" default=\"micro dust on glass\"}\",
        \"{argument name=\"screen surface 4\" default=\"faint fingerprints\"}\",
        \"{argument name=\"screen surface 5\" default=\"soft ambient reflections\"}\"
      ]
    },

    \"digital_interface\": {
      \"os\": \"{argument name=\"os\" default=\"macOS dark mode\"}\",
      \"background_app\": {
        \"name\": \"{argument name=\"background app name\" default=\"Spotify\"}\",
        \"view\": \"{argument name=\"background app view\" default=\"Liked Songs\"}\",
        \"visible_tracks\": [
          \"{argument name=\"track 1\" default=\"Blank Space – Taylor Swift\"}\",
          \"{argument name=\"track 2\" default=\"Shake It Off – Taylor Swift\"}\",
          \"{argument name=\"track 3\" default=\"Cruel Summer – Taylor Swift\"}\",
          \"{argument name=\"track 4\" default=\"Love Story – Taylor Swift\"}\"
        ]
      },
      \"foreground_app\": {
        \"name\": \"{argument name=\"foreground app name\" default=\"Photo Booth\"}\",
        \"state\": \"{argument name=\"foreground app state\" default=\"live preview window\"}\",
        \"position\": \"{argument name=\"foreground app position\" default=\"floating, center-right\"}\"
      }
    },

    \"photo_booth_content\": {
      \"environment\": {
        \"room\": \"{argument name=\"room\" default=\"dim bedroom\"}\",
        \"background\": \"{argument name=\"background\" default=\"off-white wall, rumpled bedding\"}\",
        \"lighting\": \"{argument name=\"lighting\" default=\"low-light, nocturnal, cool screen glow mixed with warm skin tones\"}\"
      },
      \"subject\": {
        \"pose\": \"{argument name=\"subject pose\" default=\"lying down, relaxed, candid\"}\",
        \"expression\": \"{argument name=\"subject expression\" default=\"natural, slightly relaxed\"}\",
        \"outfit\": \"{argument name=\"subject outfit\" default=\"light-colored tank top\"}\",
        \"prop\": {
          \"item\": \"{argument name=\"prop item\" default=\"iPhone 15 Pro\"}\",
          \"hand\": \"{argument name=\"prop hand\" default=\"right hand\"}\"
        }
      }
    },

    \"realism_rules\": [
      \"{argument name=\"realism rule 1\" default=\"this is a photo of a screen, not a screenshot\"}\",
      \"{argument name=\"realism rule 2\" default=\"raw smartphone photo look\"}\",
      \"{argument name=\"realism rule 3\" default=\"natural noise\"}\",
      \"{argument name=\"realism rule 4\" default=\"imperfect glass\"}\",
      \"{argument name=\"realism rule 5\" default=\"no studio lighting\"}\",
      \"{argument name=\"realism rule 6\" default=\"no HD polish\"}\"
    ]
  },

  \"negative_prompt\": [
    \"{argument name=\"negative 1\" default=\"screenshot\"}\",
    \"{argument name=\"negative 2\" default=\"flat UI\"}\",
    \"{argument name=\"negative 3\" default=\"perfect screen\"}\",
    \"{argument name=\"negative 4\" default=\"clean glass\"}\",
    \"{argument name=\"negative 5\" default=\"studio lighting\"}\",
    \"{argument name=\"negative 6\" default=\"beauty filter\"}\",
    \"{argument name=\"negative 7\" default=\"cartoon\"}\",
    \"{argument name=\"negative 8\" default=\"3d render\"}\",
    \"{argument name=\"negative 9\" default=\"painting\"}\",
    \"{argument name=\"negative 10\" default=\"watermark\"}\",
    \"{argument name=\"negative 11\" default=\"blurred face\"}\"
  ]
}', 'A complex JSON prompt for Gemini Nano Banana Pro designed for image-to-image generation, focusing on creating an ultra-realistic POV shot looking down at a MacBook screen. The screen displays a Photo Booth live preview of the subject (whose identity is strictly preserved from the input photo) in a dim bedroom, with Spotify running in the background. The prompt emphasizes realism details like RGB pixel grids, dust, and natural noise, simulating a photo taken of a screen rather than a screenshot.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766238131733_pupigj_G8hVJz0WYAAPNF8.jpg', 0),
(NULL, 'Room Transformation to Five-Star Hotel Suite', 'Turn this room into a five-star hotel suite.', 'A simple prompt used to compare the performance of different AI models (Nano Banana Pro and FLUX.2) in transforming a room shown in a reference image into a five-star hotel suite.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766238197683_9ju985_G8f8lueawAEybyS.jpg', 0),
(NULL, '6-Panel Brand Identity Grid Mockup', 'A professional 6-panel grid layout photograph displaying a complete brand identity suite for the concept: \"{argument name=\"content\" default=\"beauty\"}\". The image is divided into two rows and three columns, each cell framed with a clean white border. The overall style is a clean, modern studio mockup with uniform lighting.
Top Row (Left to Right):
Cell 1 (Business Card - Original): Two stacks of business cards showing front and back, featuring the primary logo, color palette, and typography of \"{argument name=\"content\" default=\"beauty\"}\". Clean white or light background paper stock.
Cell 2 (Business Card - Inverted): Two stacks of business cards showing front and back, featuring the same design as Cell 1 but with inverted colors (e.g., dark background with light logo/text).
Cell 3 (Pamphlet): An open tri-fold brochure showcasing detailed information, images, and branding elements related to \"{argument name=\"content\" default=\"beauty\"}\".
Bottom Row (Left to Right):
Cell 4 (Flyer): A single-page promotional flyer design for \"{argument name=\"content\" default=\"beauty\"}\", with a strong headline, imagery, and call to action.
Cell 5 (Shopping Bag): A premium paper shopping bag with handles, featuring a large version of the \"{argument name=\"content\" default=\"beauty\"}\" logo and brand pattern.
Cell 6 (Calendar): A desk calendar showing a monthly view with themed illustrations or photos related to \"{argument name=\"content\" default=\"beauty\"}\" and brand branding on each page.
All items across all six cells consistently apply the logo, color scheme, typography, and graphic elements of the \"{argument name=\"content\" default=\"beauty\"}\" brand identity. The background behind the grid is a clean, neutral grey studio wall. 4k resolution, highly detailed texture.
A minimal and chic handwritten signature \'Willy\' is in the bottom-right corner.
content: {argument name=\"input\" default=\"beauty\"}', 'A structured prompt for generating a professional 6-panel grid layout displaying a complete brand identity suite, including business cards, a pamphlet, a flyer, a shopping bag, and a calendar, for a customizable brand concept, ideal for design mockups and portfolio pieces.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766237854912_6nqyww_G8c3ujDakAkmQW2.jpg', 0),
(NULL, 'Logo to Floating Island Architectural Concept (4 Eras)', '<instructions>Expert Art Director & Brand Strategist.
User uploads a logo (Transparent or Solid).

Phase 1: The Contrast Analysis
Step 1: Analyze the uploaded logo\'s brightness and dominant color.
Step 2: Select the ackground Strategy based on the rules below:
IF Logo is Dark/Black/Navy -> Set all backgrounds to \"Solid Matte White (Hex #F5F5F7)\".
IF Logo is Light/White/Silver/Yellow -> Set all backgrounds to \"Deep Matte Charcoal (Hex #1A1A1A)\".
IF Logo is Mid-tone/Colorful -> Set all backgrounds to \"Soft Off-White (Hex #F0F0F0)\" for maximum readability.

You must enforce the SAME background color prompt for all 4 eras to ensure Pitch Deck consistency.

Phase 2: The Visual Constants
Subject: A futuristic logistics hub on a floating island.
Style: Low-poly 3D render, Claymorphism (Clay UI).
Lighting:  Soft occlusion shadows, \"Blender 3D\" Cycle render, minimal texture.
Integration: The logo should not just be a billboard. It should be architectural (e.g., the shape of the building, the layout of the roads, or a giant hologram).

Phase 3: The 4 Eras (With Enforced Backgrounds)

Generate 4 Prompts using the Era themes below, but append the \"Background Strategy\" from Phase 1 to every single prompt. Draw them

1.  The Industrial Dawn (1890s): Brick, steam, brass, cobblestone.
2.  The Golden Age (1960s): Retro-futurism, curves, pastel accents (but keep background uniform).
3.  The Hyper-Present (2024): Glass, robotics, server racks, LEDs.
4.  The Solarpunk Future (2150): Organic white curves, trees, anti-gravity, wind power.', 'A complex, multi-phase prompt instructing the AI to act as an Art Director and Brand Strategist. It takes an uploaded logo and transforms it into an architectural element of a futuristic logistics hub on a floating island, generating four distinct versions representing different historical/futuristic eras (Industrial Dawn, Golden Age, Hyper-Present, Solarpunk Future), while enforcing background color consistency.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766237846290_reo83m_G8P9yznWYAAMDsj.jpg', 0),
(NULL, 'Floor Plan Visualization with Family Life', 'Convert this floor plan into a realistic interior of a {argument name=\"house builder\" default=\"Ichijo Komuten (i-smart 2)\"}, rendered as a bird\'s-eye view seen from a 45-degree angle. Then, actually place the scene of this family living inside the bird\'s-eye view. Use a viewing angle where the entire floor plan is visible. Make it look like a miniature.', 'A prompt for Nano Banana Pro to visualize a floor plan (間取り) as a realistic, miniature-style, high-angle bird\'s-eye view, incorporating a specific family living within the space, based on the provided floor plan and family photos.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766237939060_9f7h2v_G8bGrRbasAE42_I.jpg', 0),
(NULL, '3x3 Grid Visual Concept Presentation', 'Present 9 different visual concepts in a 3x3 grid.', 'A prompt borrowed from an international source, instructing Nano Banana Pro to generate a 3x3 grid presenting nine different visual concepts, ranging from macro views emphasizing texture to abstract arrangements.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766042164130_1707x2_G8XqEodbIAAdoiR.jpg', 0),
(NULL, 'Multi-Cut Image Generation with Style Variation', 'Based on the reference image, generate a multi-cut image with 9 cuts arranged within a single image.
The layout is a 3x3 uniform grid. Each cut features the same person, same composition, same pose, and same camera position.
Specify the style for each cut (from top left to bottom right):
Cel animation style (TV anime style, clean line art, 2-3 levels of shadow)
Movie anime style (delicate lines, rich gradient shadows)
Black and white manga style (ink lines, screen tones)
Watercolor illustration (paper texture, bleeding, pale colors)
Oil painting (thick application, brushstrokes, canvas feel)
High-quality 3D cartoon (soft modeling, subsurface scattering)
Photorealistic 3D (PBR, texture close to real life)
Claymation (clay texture, handmade feel)
Cyberpunk color grading (cyan/magenta rim light, background remains plain)
Ensure that all 9 cuts have completely identical composition, person, pose, and background, allowing only the style difference to be compared.
Arrange them naturally as one complete image.', 'A detailed prompt designed to generate a single image containing a 3x3 grid of 9 cuts. All cuts feature the same person, composition, pose, and camera position, but each cut applies a different artistic style (e.g., cel anime, oil painting, photorealistic 3D) for comparison.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1766042160479_l8xjwt_G8VUv72a4AIuHTi.jpg', 0),
(NULL, 'Reverse-Engineering Reusable Prompt Templates for Advertising', 'Given that the visual goal is completely determined, ask the AI to reverse-engineer a reusable prompt template.
This prompt must support custom variables for subsequent long-term use.', 'A meta-prompting process description (step 4) that instructs the AI to reverse-engineer a reusable prompt template based on a clearly defined visual goal. This template must support custom variables for long-term use in advertising creation.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1765991351292_7k6gdc_G8J8Q7Fa0AEEmE6.jpg', 0),
(NULL, 'Presentation Slide Generation Prompt', 'Create a set of presentation slides, adopting a whiteboard and doodle style, focusing on step-by-step explanations, featuring a consistent colored thick pencil hand-drawn style, rich information, including Chinese text, using the nano_banana tool to generate images, and extracting core information.', 'A prompt for generating a set of presentation slides using the Nano Banana tool. It specifies a whiteboard and doodle style, focusing on step-by-step explanations, a consistent colored thick pencil hand-drawn style, rich information, and the inclusion of Chinese text, while extracting core information.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1765967785456_1z5oiw_G73Q-SDaMAQez2T.jpg', 0),
(NULL, 'LLM System Prompt Security Measures (Conceptual)', 'Prompt injection content classifiers—Proprietary machine-learning models that detect malicious prompts and instructions within various data formats.

Security thought reinforcement—Targeted security instructions that are added around the prompt content. These instructions remind the LLM (large language model) to perform the user-directed task and ignore adversarial instructions.

Markdown sanitization and suspicious URL redaction—Identifying and redacting external image URLs and suspicious links using Google Safe Browsing to prevent URL-based attacks and data exfiltration.

User confirmation framework—A contextual system that requires explicit user confirmation for potentially risky operations, such as deleting calendar events.

End-user security mitigation notifications—Contextual information provided to users when security issues are detected and mitigated. These notifications encourage users to learn more via dedicated help center articles.

Model resilience—The adversarial robustness of Gemini models, which protects them from explicit malicious manipulation.', 'This is not an image generation prompt, but a conceptual LLM prompt detailing security measures used by Google Finance, generated by Nano Banana Pro. It outlines various techniques like prompt injection content classifiers, security thought reinforcement, markdown sanitization, and user confirmation frameworks to prevent adversarial attacks and system prompt leakage.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1765509780045_dt4e2a_G718-5WWoAAwWC4.jpg', 0),
(NULL, 'Modern Minimalist PPT/Diagram Generation Prompt', '1. Overall Visual Style

Style Keywords: Flat UI, Vector, Modern Minimalist, Card-style design.

Lines and Shapes:

Rounded Corners Priority: All borders, background blocks, buttons, and process nodes must be rounded rectangles (Rounded Rectangles, with a large corner radius, approximately 10-15px).

Elbow Lines: Process connections use right-angle polylines (no curves), lines are simple and strong.

Color Logic (Key):

“Candy Color” Scheme: Use light backgrounds with high brightness and low saturation (such as light blue, light green, light purple), paired with darker borders of the same color family.

Border Emphasis: All graphics must have clear 2px~3px solid borders.

2. Vertical Layout Structure

Regardless of the topic, please follow the following top-down layout order, which must be contained within a large border container:

Layer 1: Main Title (Header)

Position: Centered at the top of the container.

Style: Bold black font, largest font size, darkest color.

Layer 2: Core Flowchart Area

Position: Occupies 50% of the core area of the layout.

Content: Rectangular nodes + arrow connections. If it is a loop step, please use a dashed line pointing back.

Layer 3: Feature List

Position: Below the flowchart, centered or left-aligned.

Style: Short and concise bullet points, slightly smaller font, with some white space.

Layer 4: Full-width Summary Box (Footer Box)

Position: At the very bottom of the container, filling the width horizontally.

Color Scheme: Use a contrasting color (such as purple in the example), distinct from the main color scheme above.

Function: Used to place \'Summary\', \'Analogy\', or \'Core Conclusion\'.

Landscape size (horizontal/scenic mode) is chosen because:

Content Adaptation: Horizontal content like timelines is better displayed in a horizontal canvas to show the evolution process.

Presentation Friendly: The 3:2 horizontal ratio is very suitable for insertion into PPTs and documents, and displays well on projectors or screens.

Information Capacity: Horizontal layout can accommodate more text and icons, avoiding clutter.', 'A comprehensive, structured prompt for Nano Banana Pro designed to generate professional, modern, and minimalist presentation slides or diagrams (PPT/architecture diagrams). It defines a specific visual style (Flat UI, vector, candy colors, rounded rectangles) and a strict vertical layout structure (Header, Flowchart, Feature List, Footer Box) optimized for landscape format.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1765509803745_gdsd77_G7zH9Mzb0AAQIdd.jpg', 0),
(NULL, 'Nano Banana Pro Camera Control Template and Example Prompt', '{
  \"scene\": \"AI engineer working at futuristic desk with multiple holographic displays\",
  \"camera\": {
    \"angle\": \"{argument name=\"camera angle\" default=\"over-the-shoulder, slightly elevated\"}\",
    \"focal_length\": \"{argument name=\"focal length\" default=\"50mm portrait lens\"}\",
    \"depth_of_field\": \"{argument name=\"depth of field\" default=\"shallow, subject in sharp focus, background slightly blurred\"}\"
  },
  \"lighting\": {
    \"type\": \"{argument name=\"lighting type\" default=\"dramatic side lighting with blue accent lights\"}\",
    \"time_of_day\": \"{argument name=\"time of day\" default=\"late night\"}\",
    \"mood\": \"{argument name=\"mood\" default=\"focused, tech-noir atmosphere\"}\",
    \"shadows\": \"deep but not harsh\"
  },
  \"color_grade\": \"{argument name=\"color grade\" default=\"cool tones, teal and orange color scheme\"}\"
}', 'A template and a specific example prompt demonstrating how to use Nano Banana Pro\'s professional camera controls (angle, focal length, depth of field) and lighting specifications to create a focused, tech-noir image of an AI engineer.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1765509738525_mo51lx_G7y6_kVaMAIOiZc.jpg', 0),
(NULL, 'Persona-Style Status Screen Generation', 'A Persona-style status screen using nano banana pro. I instructed it to randomly generate the level and stats, but they tend to be high.', 'A prompt used to generate a status screen in the style of the Persona video game series, instructing the AI to randomly generate high values for the level and stats.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1765509789832_tol646_G7yeg6AakAASOvR.jpg', 0),
(NULL, 'Hand-Drawn Urban Planning Map from 3D View', 'hand-drawn urban planning map', 'A two-step process prompt for transforming a Google Maps 3D oblique view into a stylized, hand-drawn urban planning map, useful for creating artistic or simplified city layouts.', 'text_to_image', 'grok-imagine-image-pro', '', 'https://cms-assets.youmind.com/media/1765440052650_vqu88b_G7vtu4daMAEn7F0.jpg', 0);
INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Wide quote card with portrait and Chinese/English customization', 'text_to_image', 'A wide quote card featuring a famous person, with a brown background and a light-gold serif font for the quote: “{argument name=\"famous_quote\" default=\"Stay Hungry, Stay Foolish\"}” and smaller text: “—{argument name=\"author\" default=\"Steve Jobs\"}.” There is a large, subtle quotation mark before the text. The portrait of the person is on the left, the text on the right. The text occupies two-thirds of the image and the portrait one-third, with a slight gradient transition effect on the portrait.', 'https://cms-assets.youmind.com/media/1763886933714_5zqn1e_G6QBjQHbgAE3Yt_.jpg', 'grok-imagine-image-pro', 'A prompt for generating a wide quote card featuring a famous person’s portrait, with a brown background, light-gold serif quote text, and layout where text occupies two-thirds and the person one-third. The quote text and author are parameterized for reuse.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Premium liquid glass Bento grid product infographic with 8 modules', 'text_to_image', 'Input Variable: [insert product name]
Language: [insert language]

System Instruction:
Create an image of premium liquid glass Bento grid product infographic with 8 modules (card 2 to 8 show text titles only).
1) Product Analysis:
→ Identify product\'s dominant natural color → \"hero color\"
→ Identify category: FOOD / MEDICINE / TECH
2) Color Palette (derived from hero):
→ Product + accents: full saturation hero color
→ Icons, borders: muted hero (30-40% saturation, never black)
3) Visual Style:
→ Hero product: real photography (authentic, premium), 3D Glass version [choose one]
→ Cards: Apple liquid glass (85-90% transparent) with Whisper-thin borders and Subtle drop shadow for floating depth and reflecting the background color
→ Background stays behind cards and high blur where cards are [choose one]:
  - Ethereal: product essence, light caustics, abstract glow
  - Macro: product texture close-up, heavily blurred
  - Pattern: product repeated softly at 10-15% opacity
  - Context: relevant environment, blurred + desaturated
→ Add subtle motion effect
→ Asymmetric Bento grid, 16:9 landscape
→ Hero card: 28-30% | Info modules: 70-72%
4) Module Content (8 Cards):
M1 — Hero: Product displayed as real photo / 3D glass / stylized interpretation (choose one)in beautiful form + product name label
M2 — Core Benefits: 4 unique benefits + hero-color icons
M3 — How to Use: 4 usage methods + icons
M4 — Key Metrics: 5 EXACT data points
Format: [icon] [Label] [Bold Value] [Unit]
FOOD: Calories: [X] kcal/100g, Carbs: [X]g (fiber [X]g, sugar [X]g), Protein: [X]g, [Key Vitamin]: [X]mg ([X]% DV), [Key Mineral]: [X]mg ([X]% DV)
MEDICINE:Active: [name], Strength: [X] mg, Onset: [X] min, Duration: [X] hrs, Half-life: [X] hrs 
TECH:Chip: [model], Battery: [X] hrs, Weight: [X]g,[Key spec]: [value], Connectivity: [protocols]
M5 — Who It\'s For: 4 recommended groups with green checkmark icons | 3 caution groups with amber warning icons
M6 — Important Notes: 4 precautions + warning icons
M7 — Quick Reference:
→ FOOD: Glycemic Index + dietary tags with icons
→ MEDICINE: Side effects + severity with icons
→ TECH: Compatibility + certifications with icons
M8 — Did You Know: 3 facts (origin, science, global stat) + icons
Output: 1 image, 16:9 landscape, ultra-premium liquid glass infographic.', 'https://cms-assets.youmind.com/media/1768962051381_l9uih4_537980579-6f29d32a-c786-40c4-bd5a-79c640737496.png', 'grok-imagine-image-pro', 'Create an Infographics with bento grid 8 module layout, user can specify any product name in Food, Medicine, tech etc category, choose language, Background style, Hero grid style', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Hand-drawn style header image prompt from photo', 'text_to_image', 'Completely recreate the uploaded person.
Make it a header image for a note article where that person introduces “Nano Banana Pro”.
Aspect ratio: horizontal 16:9.
Style and colors: simple, hand-drawn style, italic, with a blue and green gradient.
Title text: “In-depth explanation of Google’s new AI ‘Nano Banana Pro’”.', 'https://cms-assets.youmind.com/media/1763885651870_4szbai_G6VZiROagAAqsIh.jpg', 'grok-imagine-image-pro', 'Prompt for a hand-drawn style header image of a person introducing Nano Banana Pro', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Watercolor map of Germany with labeled states', 'text_to_image', 'Generate a map of Germany in watercolor style, on which all federal states are labeled in ballpoint pen.', 'https://cms-assets.youmind.com/media/1763886061720_fzgqaq_G6RIeSZXgAA7cOf.jpg', 'grok-imagine-image-pro', 'A German prompt to generate a watercolor-style map of Germany where all federal states are labeled in ballpoint pen, useful for educational or infographic-style maps.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('New Year', 'text_to_image', '[Key: Maintain precise facial features, retain original face structure, the character in the image must be completely consistent with the uploaded reference image] High-end photo studio 2x2 grid photo. Top-left panel (Navy Blue background): The character wears a navy blue uniform-style dress, decorated with gold buttons, vintage curls with a blue beret and pearl earrings. She holds up a huge puzzle piece (top-left piece, with the number \"20\" on it) with both hands, moving it towards the center of the frame. Her eyes are focused on the central puzzle area, her expression is serious, with a slight smile. The background features navy stripes, an anchor, and the text \"Set Sail for the New Year\". Top-right panel (Cherry Blossom Pink background): The same woman wears a pink lace dress, a pearl necklace, a princess hairstyle with a pink rose hairpin and crystal earrings. She holds up the top-right puzzle piece (with the number \"26\" on it) with both hands, moving it towards the center to connect with the top-left piece. Her eyes look at the puzzle seam, her expression is focused and expectant, and her body leans forward. The background features pink cherry blossoms, the text \"Beautiful Encounter\", butterflies, and petals. Bottom-left panel (Mint Green background): The same woman wears a mint green cotton and linen dress, in an artistic style, with natural long hair, a green hairband, and wooden earrings. She holds up the bottom-left puzzle piece (with the text \"New Year\'s Day\" on it) with both hands, moving it upwards to connect with the top-left piece. Her eyes look at the puzzle, her expression is serious, and her mouth is slightly pursed. The background features green plants, the text \"Hope Grows\", new sprouts, and leaves. Bottom-right panel (Lemon Yellow background): The same woman wears a yellow dress with a sunflower pattern, pigtails with yellow bows. She pushes in the last bottom-right puzzle piece (with the text \"Happy\" on it) to complete the puzzle. The four pieces perfectly form the complete pattern \"2026 New Year\'s Day Happy\" in the center of the frame. She tilts her head back, looking at the completed puzzle, her face beaming with a successful, joyful smile. The center of the frame bursts with golden light and confetti. The background features a yellow sun, the text \"Complete Success\", smiley faces, and sunflowers. The puzzle pieces converge from the four corners to the center to form a complete picture. Clear makeup, bright ring light, 85mm lens, f/1.8 aperture, four-panel composition with puzzle interaction, fashion magazine style.', 'https://cms-assets.youmind.com/media/1767455034932_ivuvu0_G9V-MszakAEAIBw.jpg', 'grok-imagine-image-pro', 'A detailed multi-panel prompt for Nano Banana Pro, creating a 2x2 grid photo collage where a single female character, in four different outfits and settings, pieces together a puzzle that spells \'2026 New Year\'s Day Happy\' in the center. The prompt specifies precise facial feature retention, clothing details, background elements, and photographic parameters for a fashion magazine style.', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Vintage Patent Document for an Invention', 'text_to_image', 'A vintage patent document for {argument name=\"invention\" default=\"INVENTION\"}, styled after late 1800s United States Patent Office filings. The page features precise technical drawings with numbered callouts (Fig. 1, Fig. 2, Fig. 3) showing front, side, and exploded views. Handwritten annotations in fountain-pen ink describe mechanisms. The paper is aged ivory with foxing stains and soft fold creases. An official embossed seal and red wax stamp appear in the corner. A hand-signed inventor\'s name and date appear at the bottom. The entire image feels like a recovered archival document—authoritative, historic, and slightly mysterious.', 'https://cms-assets.youmind.com/media/1766940094520_1mg5pd_G8_m2ZVWEAAMG7y.jpg', 'grok-imagine-image-pro', 'A prompt designed to generate an image of a vintage United States patent document from the late 1800s. It specifies details like precise technical drawings, handwritten annotations, aged paper texture, foxing stains, an embossed seal, and a wax stamp, making it ideal for historical or archival aesthetics.', 7);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Chalkboard-style AI news summary', 'text_to_image', 'Using the following content, summarize the news in a chalkboard-style, hand‑written look, and break it down with diagrams and easy‑to‑understand expressions as if a teacher had written it.
—-
Search results from Grok', 'https://cms-assets.youmind.com/media/1763885620059_vzaj75_G6WfVvIbAAEgvYg.jpg', 'grok-imagine-image-pro', 'A Japanese prompt for turning AI news content into a hand-drawn, teacher-style chalkboard diagram with explanations.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Detailed mirror-selfie otaku room scene', 'text_to_image', '### Scene
Mirror selfie in an otaku-style computer corner, blue color tone.

### Subject
* Gender expression: female
* Age: around 25
* Ethnicity: East Asian
* Body type: slim, with a defined waist; natural body proportions
* Skin tone: light neutral tone
* Hairstyle:
    * Length: waist-length hair
    * Style: straight with slightly curled ends
    * Color: medium brown
* Pose:
    * Stance: standing in a slight contrapposto pose
    * Right hand: holding a smartphone in front of her face (identity hidden)
    * Left arm: naturally hanging down alongside the torso
    * Torso: body leaning slightly back; waist and abdomen exposed
* Clothing:
    * Top: light blue cropped knit cardigan, top two buttons fastened; a blue French-style bra faintly visible
    * Bottom: denim ultra-short shorts, with a blue satin ribbon bow on each side of the hips
    * Socks: blue and white horizontal striped over-the-knee socks
    * Accessory: a blue cute mascot phone case

### Environment
* Description: bedroom computer corner seen through a wall-mounted mirror
* Furnishings:
    * White desk
    * Single monitor showing a soft blue wallpaper (no readable text)
    * Mechanical keyboard with white keycaps on a blue desk mat
    * Mouse on a small blue mouse pad
    * PC tower on the right side with blue case lighting
    * Three anime figures on or near the PC tower
    * A poster of a pagoda on the wall
    * Cat-shaped desk lamp with blue accents
    * A transparent glass of water
    * A tall green leafy plant by the window (on the left side of the frame)
* Color replacement: replace all originally pink elements (clothes and room decor) with blue tones (baby blue to sky blue/periwinkle blue).

### Lighting
* Light source: daylight coming from a large window on the left side of the camera, through sheer curtains
* Light quality: soft, diffused light
* White balance (K): 5200

### Camera
* Mode: smartphone rear camera shooting via the mirror (no portrait/bokeh mode)
* Equivalent focal length (mm): 26
* Distances (m):
    * Subject to mirror: 0.6
    * Camera to mirror: 0.5
* Exposure:
    * Aperture (f): 1.8
    * ISO: 100
    * Shutter speed (s): 0.01
    * Exposure compensation (EV): -0.3
* Focus: focus on the torso and shorts in the mirror image
* Depth of field: natural smartphone deep depth of field; background clearly visible with no artificial blur
* Composition:
    * Aspect ratio: 1:1
    * Crop: from the top of the head to mid-thigh; include the desk, monitor, PC tower, and plant in the frame
    * Angle: slightly high angle from the mirror’s point of view
    * Composition note: keep the subject centered; to avoid wide-angle edge distortion, have her stand a bit further away and crop to a square later.

### Negative prompts
* Any appearance of pink/magenta anywhere
* Beauty filters/over-smoothed skin; poreless skin look
* Exaggerated or distorted anatomy
* NSFW, see-through fabrics, wardrobe malfunctions
* Logos, brand names, or readable user interface text
* Fake portrait-mode blur, CGI/illustration feel', 'https://cms-assets.youmind.com/media/1763889946850_689z0h_G23i3sJW0AASGUw.jpg', 'grok-imagine-image-pro', 'A very detailed Nano Banana prompt describing a female mirror selfie in a blue-toned otaku computer corner, with full specifications for character, environment, lighting, camera, and negative prompts.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Edo-period Ukiyo-e reinterpretation of a modern scene', 'text_to_image', 'A Japanese Edo-period Ukiyo-e woodblock print. The overall feeling is a surreal collaboration between masters like Hokusai and Hiroshige, reimagining modern technology through an ancient lens.

**The scene:** {argument name=\"modern scene\" default=\"a busy Shibuya scramble crossing\"}

**Edo transformation logic:**
Characters wear Edo-era kimono but perform modern actions. All technology is transformed into surreal Edo equivalents:
* Smartphones are glowing, illustrated paper scrolls being read intently.
* Metro stations and trains are giant articulated wooden centipede carriages shuffling through crowds.
* Skyscrapers are reimagined as endless, towering wooden pagodas reaching into dramatic clouds.
* Robots and mecha appear as giant, armored woodblock golems.

The composition uses a flattened perspective with large, bold, hand-carved ink outlines. The background features heavily stylized Ukiyo-e wave patterns and dramatic, swirling clouds, with a distant Mt. Fuji visible on the horizon.

The image must look like a physical print, not a digital painting.
* Texture: strong visible wood grain texture and rough paper fibers throughout the piece.
* Printing imperfections: pigment bleeding is evident. Simulate hand-pressed plates with slight color misalignment for authenticity.
* Color palette: strictly limited to traditional mineral pigments, with dominant use of Prussian blue, vermilion red, and muted yellow ochre.
* Lighting: soft, flat, shadow-free lighting with no digital gradients.

Aspect ratio is 3:4 vertical poster. Include vertical Japanese calligraphy describing the scene and a traditional red artist seal stamp in a corner.', 'https://cms-assets.youmind.com/media/1764915832381_renotr_G7FuPlzbYAAsuo2.jpg', 'grok-imagine-image-pro', 'A highly-structured image prompt to depict a modern-day scene reimagined as an Edo-period Japanese Ukiyo-e woodblock print, with detailed guidance on anachronistic tech, composition, texture, and color.', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Ana de Armas Summer Watermelon Selfie', 'text_to_image', '{
\"photo_type\": \"outdoor summer selfie, candid lifestyle\",
\"subject\": {
\"count\": 1,
\"use_reference_face\": true,
\"preserve_identity\": true,
\"appearance\": \"{argument name=\"subject appearance\" default=\"Ana de Armas, wet hair, natural skin, minimal makeup, Use uploaded reference image, keep identity exact\"}\"
},
\"pose\": {
\"description\": \"holding a slice of watermelon close to mouth, lips touching fruit, one eye slightly closed\",
\"expression\": \"playful, relaxed, sun-kissed mood\"
},
\"camera\": {
\"device\": \"front camera smartphone selfie\",
\"perspective\": \"handheld close-up\",
\"angle\": \"slightly low and very close to face\",
\"tilt\": \"subtle upward tilt\",
\"distance\": \"arm-length, tight framing\",
\"framing\": \"face fills most of frame, hand and watermelon in foreground\",
\"lens\": \"wide smartphone lens (24-28mm equivalent)\",
\"focus\": \"sharp on face and fruit\"
},
\"composition\": {
\"subject_position\": \"center\",
\"foreground\": \"hand holding watermelon partially blocking lower face\",
\"background\": \"palm trees, sky, beach blur\"
},
\"lighting\": {
\"type\": \"direct harsh sunlight\",
\"direction\": \"from above and slightly behind\",
\"effect\": [
\"strong highlights on forehead, nose, cheeks\",
\"deep natural shadows under chin and hair\",
\"sun glow around hair edges\",
\"slight overexposure on highlights\"
]
},
\"color_grading\": {
\"style\": \"warm summer tones\",
\"temperature\": \"slightly warm\",
\"contrast\": \"medium-high\",
\"saturation\": \"natural with boosted reds and greens\"
},
\"details\": {
\"skin_texture\": \"real, slightly glossy from sunlight\",
\"hair\": \"wet strands, natural messiness\",
\"finish\": \"raw iPhone look, no heavy editing\"
},
\"rules\": {
\"lock_camera_angle\": true,
\"avoid\": [
\"studio lighting\",
\"perfect symmetry\",
\"over-smooth skin\",
\"wide distance shots\"
]
}
}', 'https://cms-assets.youmind.com/media/1774248313556_kkh2gw_HEBmNUvaEAA84lL.jpg', 'grok-imagine-image-pro', 'A structured JSON prompt designed to generate an outdoor, candid summer selfie featuring Ana de Armas holding a slice of watermelon close to her mouth, utilizing harsh direct sunlight and a raw smartphone camera aesthetic.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Outdoor Summer Watermelon Selfie (Detailed JSON)', 'text_to_image', '{   \"photo_type\": \"outdoor summer selfie, candid lifestyle\",    \"subject\": {     \"count\": 1,     \"use_reference_face\": true,     \"preserve_identity\": true,     \"appearance\": \"{argument name=\"subject appearance\" default=\"wet hair, natural skin, minimal makeup\"}\"   },    \"pose\": {     \"description\": \"holding a slice of watermelon close to mouth, lips touching fruit, one eye slightly closed\",     \"expression\": \"playful, relaxed, sun-kissed mood\"   },    \"camera\": {     \"device\": \"front camera smartphone selfie\",     \"perspective\": \"handheld close-up\",     \"angle\": \"slightly low and very close to face\",     \"tilt\": \"subtle upward tilt\",     \"distance\": \"arm-length, tight framing\",     \"framing\": \"face fills most of frame, hand and watermelon in foreground\",     \"lens\": \"wide smartphone lens (24-28mm equivalent)\",     \"focus\": \"sharp on face and fruit\"   },    \"composition\": {     \"subject_position\": \"center\",     \"foreground\": \"hand holding watermelon partially blocking lower face\",     \"background\": \"palm trees, sky, beach blur\"   },    \"lighting\": {     \"type\": \"direct harsh sunlight\",     \"direction\": \"from above and slightly behind\",     \"effect\": [       \"strong highlights on forehead, nose, cheeks\",       \"deep natural shadows under chin and hair\",       \"sun glow around hair edges\",       \"slight overexposure on highlights\"     ]   },    \"color_grading\": {     \"style\": \"warm summer tones\",     \"temperature\": \"slightly warm\",     \"contrast\": \"medium-high\",     \"saturation\": \"natural with boosted reds and greens\"   },    \"details\": {     \"skin_texture\": \"real, slightly glossy from sunlight\",     \"hair\": \"wet strands, natural messiness\",     \"finish\": \"raw iPhone look, no heavy editing\"   },    \"rules\": {     \"lock_camera_angle\": true,     \"avoid\": [       \"studio lighting\",       \"perfect symmetry\",       \"over-smooth skin\",       \"wide distance shots\"     ]   } }', 'https://cms-assets.youmind.com/media/1774248315058_uq2rqy_HEBiUV1boAAomLI.jpg', 'grok-imagine-image-pro', 'A structured JSON prompt for generating an outdoor, candid summer selfie. The prompt specifies holding a slice of watermelon close to the mouth, using direct harsh sunlight, and aiming for a raw smartphone camera aesthetic with warm summer tones.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Late Night Apartment Portrait (iPhone Realism)', 'text_to_image', '{
  \"meta\": {
    \"aspect_ratio\": \"9:16 vertical\",
    \"camera\": \"iPhone 17 Pro Max (rear camera)\",
    \"lens_simulation\": \"24mm wide\",
    \"quality\": \"ultra-photorealistic, natural iPhone HDR\",
    \"time_of_day\": \"11:38 PM\",
    \"lighting_temperature\": \"warm tungsten 3200K\",
    \"style\": \"raw iphone realism, subtle handheld micro-tilt, authentic skin texture, slight shadow grain\"
  },
  \"scene\": {
    \"location\": \"modern high-rise apartment living room\",
    \"background_elements\": [
      \"floor-to-ceiling city skyline windows at night\",
      \"soft amber lamp glow on textured wall\",
      \"neutral beige sectional sofa with real fabric compression\",
      \"subtle reflections on polished wood floor\"
    ],
    \"atmosphere\": \"late-night intimate quiet energy\"
  },
  \"subject\": {
    \"identity_lock\": \"exact facial structure and body proportions preserved\",
    \"pose\": {
      \"position\": \"kneeling sideways on sofa cushion\",
      \"hips\": \"angled back slightly\",
      \"torso\": \"twisted toward camera emphasizing waist curve\",
      \"arms\": \"one hand resting behind her on cushion, other lightly touching collarbone\",
      \"head\": \"slightly tilted down, eyes looking up through lashes\"
    },
    \"expression\": \"calm, magnetic, soft parted lips\",
    \"hair\": \"light blonde, straight, natural fall with loose face-framing strands\",
    \"outfit\": {
      \"top\": \"thin champagne satin bralette, tight tension across bust, no bra lines\",
      \"bottom\": \"micro lounge shorts, soft grey cotton, subtle fabric stretch at hips\"
    }
  },
  \"lighting\": {
    \"primary\": \"warm lamp spill from camera-right\",
    \"secondary\": \"cool city glow rim light\",
    \"effect\": \"soft highlight rolloff on thighs and collarbones, realistic shadow falloff\"
  },
  \"photography\": {
    \"depth_of_field\": \"moderate natural smartphone depth\",
    \"handheld_realism\": \"slight framing imperfection\",
    \"color_science\": \"true-to-life warm skin tones, restrained HDR\"
  }
}', 'https://cms-assets.youmind.com/media/1774248318334_yjwym1_HCfJXWIX0AAgTy3.jpg', 'grok-imagine-image-pro', 'A highly detailed Nano Banana 2 prompt for generating an ultra-photorealistic vertical image of a woman kneeling on a sofa in a high-rise apartment at night, emphasizing iPhone realism, specific clothing details, and complex lighting interaction between warm interior lamps and cool city skyline glow.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Photo Restoration and Upscaling Prompt', 'text_to_image', '\"Restore this old photo into professional portrait of DLSR - quality colour and detail, using an advanced upscaling algorithm comparable to the results from canon EOS R6 II. Ensure the restored the image looks natural, retains exact facial features, has great clarity.......\"', 'https://cms-assets.youmind.com/media/1774248305917_urdq3q_HD_ehHzX0AACrGP.jpg', 'grok-imagine-image-pro', 'A prompt for Nano Banana 2 designed to restore and upscale an old, faded film photo into a high-definition, professional portrait with DSLR quality, ensuring facial features and clarity are retained.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - iPhone Pro Environmental Portrait on Terrace', 'text_to_image', '(9:16) Raw high-fidelity photo, eye-level, medium-wide environmental portrait, iPhone 17 Pro sim, 35mm, f/2.8, natural bokeh, authentic grain.

Framing: Subject ~60% frame height, camera ~2m, outdoor terrace, wide horizon sky (top ~40%), glass railings, minimal foreground clutter.

Identity Lock: Preserve ALL facial features (structure, skin, hair, marks).
Enhancement: Natural skin clarity (pores visible), even tone, soft glow, subtle light-based contour, refined highlights (eyes/lips/cheekbones), natural lashes/brows/teeth, salon hair.
Bio-Fidelity: Micro-pores, fine vellus hair, natural skin hydration.
Expression: Warm/confident, soft closed-lip smile, direct eye contact over right shoulder, head turned ~80° back.

Hair: Same color/texture, long, sleek, straight, down back framing right shoulder, soft daylight highlights.
Makeup: Natural daytime (soft base, subtle eyes, neutral matte lip).

Accessories: None.

Outfit: White rib-knit cropped sweater (tight fit) + high-waisted pleated plaid micro-skirt (brown/beige/white), sharp pleats, realistic fabric tension, defined S-curve.

Pose: Torso facing away (~90°), head turned back (~80°), right hand lightly lifting skirt hem, realistic finger/textile interaction.

Mood/Color: Warm, confident travel aesthetic; palette (white, coffee-brown, beige, sky blue), 5500K daylight, medium-high contrast.

Environment: Outdoor terrace, diffused sunlight (upper-right), glass railings + metal posts, distant hills + urban skyline, bright sky w/ soft clouds, stone/concrete detail, background softly blurred (f/2.8).', 'https://cms-assets.youmind.com/media/1774161437787_4r45os_HD9Mu9LaIAAr0gV.jpg', 'grok-imagine-image-pro', 'A highly detailed, structured prompt for generating a photorealistic environmental portrait on an outdoor terrace, simulating an iPhone 17 Pro camera. The prompt includes specific technical specs (35mm, f/2.8), framing instructions, identity lock requirements, and detailed descriptions of the subject\'s attire, pose, and the environment.', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Arcade Bubblegum Selfie with Harsh Flash', 'text_to_image', '{
  \"photo_type\": \"Direct smartphone selfie, casual snapshot\",
  \"subject\": {
    \"age\": \"early 20s\",
    \"description\": \"young woman of mixed heritage, olive skin, slim athletic build, playful close-up pulling pink bubblegum from mouth\",
    \"expression\": \"playful confident smile, direct eye contact\",
    \"hair\": \"long messy-wavy brown, center-parted, natural volume with flyaways over shoulders\"
  },
  \"clothing\": {
    \"top\": \"pink multi-strap crop top with thin criss-cross details, fitted comfortable fabric\"
  },
  \"face\": {
    \"description\": \"preserve uploaded reference 100%\",
    \"eyebrows\": \"thick dark well-defined arches\",
    \"eyes\": \"almond-shaped, winged black eyeliner, pink eyeshadow\",
    \"lips\": \"soft glossy lips, pink bubblegum stretched between teeth\",
    \"makeup\": \"heavy pink eyeshadow, sharp cat-eye liner, rosy blush, high-shine gloss\"
  },
  \"skin_texture\": \"natural with visible pores, minor T-zone oil, fine vellus hair on jawline\",
  \"pose\": {
    \"action\": \"holding stretched pink gum strand between thumb & forefinger, head tilted, shoulders relaxed\"
  },
  \"accessories\": {
    \"jewelry\": \"thin black velvet choker necklace\",
    \"prop\": \"pink bubblegum\"
  },
  \"background\": {
    \"setting\": \"dimly lit arcade/game room with neon written \'Keor Games\' in backdrop\",
    \"elements\": [\"black arcade cabinet\", \"pink dripping paint graphic\", \"dark reflective panels\"],
    \"atmosphere\": \"casual late-night edgy indoor vibe\"
  },
  \"lighting\": \"direct on-camera smartphone flash, harsh flat highlights & sharp shadows\",
  \"camera\": {
    \"device\": \"iPhone 16 Pro front camera\",
    \"lens\": \"wide-angle\",
    \"settings\": \"f/11 deep focus, 1/100s, ISO 400, Smart HDR, Deep Fusion\",
    \"shot_type\": \"close-up selfie, 9:16\",
    \"imperfections\": \"lens smudges, minor noise in shadows, flyaways, raw unedited phone look\"
  },
  \"style\": \"amateur handheld realism, deep focus everywhere sharp, vibrant color with neon pink pop & warm skin tones\",
  \"vibe\": \"playful confident late-night casual mood\"
}', 'https://cms-assets.youmind.com/media/1774161439211_hn7v2c_HD8DeG6XcAAnWy3.jpg', 'grok-imagine-image-pro', 'A structured JSON prompt for generating an amateur handheld realism selfie in a dimly lit arcade setting. The prompt focuses on a playful expression, pulling pink bubblegum, and specifies harsh on-camera smartphone flash lighting and technical details like deep focus and minor noise for an unedited phone look.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Cyberpunk Portrait with Neon Lighting', 'text_to_image', 'Ultra-realistic cinematic portrait of a thoughtful man wearing round glasses, side profile close-up, dramatic neon lighting with contrasting blue and magenta/purple tones, soft gradient background blending colors, moody atmosphere, sharp facial details with natural skin texture, subtle shadows, shallow depth of field, studio lighting, cyberpunk aesthetic, high contrast, 8K, editorial photography style.', 'https://cms-assets.youmind.com/media/1774161427198_11tl5z_HD5cvaOXMAAEWh-.jpg', 'grok-imagine-image-pro', 'A prompt for generating an ultra-realistic cinematic portrait of a thoughtful man in round glasses, emphasizing dramatic neon lighting (blue and magenta/purple tones) and a cyberpunk aesthetic. The prompt specifies a side profile close-up, sharp facial details, natural skin texture, and an editorial photography style.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Realistic Elevator Mirror Selfie Prompt for Nano Banana Pro', 'text_to_image', '{ \"photo_type\": \"Elevator mirror selfie (real iPhone capture, indoor neutral lighting)\",
\"subjects\": { \"count\": 2,
\"faces\": {
  \"description\": \"Use 2 uploaded reference images, keep identity exact, no smoothing, no reshaping, no facial edits, preserve exact facial structure, skin tone, eyes, lips\"
},

\"pose_description\": \"two friends standing close in elevator mirror, right subject holding phone taking selfie, left subject slightly leaning with one leg bent upward and one arm raised\",

\"expressions\": [
  \"right: excited open smile, candid energy\",
  \"left: playful pout expression\"
],

\"body_language\": [
  \"relaxed posture\",
  \"casual friendly closeness\",
  \"slight asymmetry\",
  \"not perfectly posed\"
]
},
\"clothing\": { \"details\": [ \"left: red puffer jacket, grey sweatpants, sneakers, shoulder bag\", \"right: light cropped top, grey joggers, hoodie layer, handbag\", \"natural fabric folds and creases\", \"realistic outfit texture\" ] },
\"lighting\": { \"type\": \"elevator indoor lighting\",
\"setup\": [
  \"top ceiling lights\",
  \"metal wall reflections\",
  \"slight uneven brightness across faces\"
],

\"effects\": [
  \"soft highlights on forehead and cheeks\",
  \"shadow under chin\",
  \"slight dull metallic reflection\",
  \"not perfectly balanced light\"
],

\"color_temperature\": \"neutral 3800K to 4200K\"
},
\"phone_capture\": { \"details\": [ \"visible iPhone in hand\", \"mirror reflection framing\", \"slight wide lens distortion\", \"handheld imperfect angle\" ] },
\"camera\": { \"type\": \"smartphone camera\",
\"lens\": \"26mm wide\",

\"settings\": {
  \"aperture\": \"f/1.8\",

\"iso\": \"ISO 200-600\",

\"shutter_speed\": \"1/40s\"
},

\"focus\": \"slightly imperfect focus\",

\"sensor_behavior\": [
  \"minor grain\",
  \"shadow noise\",
  \"slight softness\"
]
},
\"skin_realism\": { \"details\": [ \"visible pores\", \"natural shine\", \"uneven texture\", \"no airbrushing\" ] },
\"hair\": { \"details\": [ \"natural loose strands\", \"slight frizz\", \"not perfectly styled\" ] },
\"background\": { \"setting\": \"elevator interior\",
\"details\": [
  \"metal reflective walls\",
  \"panel lines visible\",
  \"subtle scratches or texture\",
  \"real depth from reflection\"
]
},
\"color_grading\": { \"style\": \"raw phone photo\",
\"rules\": [
  \"no heavy filters\",
  \"neutral tone\",
  \"natural contrast\",
  \"not cinematic\"
]
},
\"imperfections\": [ \"grain\", \"lighting imbalance\", \"minor blur\", \"lens distortion\" ],
\"composition\": { \"camera_angle\": \"mirror selfie angle\", \"framing\": \"tight mid-body framing\", \"depth\": \"both subjects clear, slight background softness\" },
\"resolution_and_aspect_ratio\": \"4K, 4:5\",
\"vibe\": \"casual friends moment, fun, unfiltered, spontaneous\",
\"strict_rules\": { \"must_have\": [ \"mirror selfie look\", \"phone visible\", \"reference faces unchanged\", \"real skin texture\", \"imperfect lighting\" ],
\"avoid\": [
  \"studio lighting\",
  \"perfect symmetry\",
  \"over editing\",
  \"plastic skin\",
  \"cinematic \"}', 'https://cms-assets.youmind.com/media/1774074512669_xjsfxd_HD4wMtZboAAkUg0.jpg', 'grok-imagine-image-pro', 'A highly structured JSON prompt for Nano Banana Pro designed to generate an ultra-realistic, imperfect elevator mirror selfie featuring two friends. The prompt focuses heavily on preserving the exact identity of reference faces, simulating smartphone camera flaws (grain, slight blur, lens distortion), and maintaining a casual, unfiltered aesthetic.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Low-Light Kitchen Portrait (Persian/Middle Eastern)', 'text_to_image', '{
  \"meta\": {
    \"camera\": \"iPhone 17 Pro\",
    \"lens\": \"35mm\",
    \"aspect_ratio\": \"9:16\",
    \"time_of_day\": \"11:38 PM\",
    \"lighting_temperature\": \"warm tungsten 3400K with subtle neon spill\",
    \"style\": \"low-light iPhone realism, natural HDR, slight handheld motion, authentic skin texture, shallow depth of field\"
  },

  \"scene\": {
    \"location\": \"modern penthouse kitchen\",
    \"atmosphere\": \"late-night alone energy, city lights outside floor-to-ceiling windows\",
    \"background\": [
      \"dark marble kitchen island\",
      \"dim pendant lights glowing warm\",
      \"blurred skyline bokeh through glass\"
    ]
  },

  \"subject\": {
    \"age\": \"late 20s (clearly adult)\",
    \"ethnicity\": \"Persian / Middle Eastern\",
    \"body_type\": \"curvy hourglass, heavy chest, tiny waist, round hips\",
    \"hair\": \"dark brown, loose messy waves\",
    \"pose\": {
      \"position\": \"leaning back against marble island\",
      \"hips\": \"subtly pressed to counter\",
      \"shoulders\": \"slightly rolled back\",
      \"one_hand\": \"resting on countertop edge\",
      \"expression\": \"slow eyes, lips softly parted, confident calm\"
    }
  },

  \"outfit\": {
    \"top\": \"thin satin champagne-colored slip top, braless, natural drape tension\",
    \"bottom\": \"high-cut black lounge shorts, hugging hips\"
  },

  \"camera_details\": {
    \"angle\": \"slightly below chest level\",
    \"distance\": \"medium shot\",
    \"focus\": \"sharp on face and collarbones, background softly blurred\",
    \"imperfections\": \"tiny highlight bloom from pendant lights\"
  }
}', 'https://cms-assets.youmind.com/media/1774074519386_87c1xe_HCfIZJDXEAEyggu.jpg', 'grok-imagine-image-pro', 'A detailed JSON prompt for Nano Banana 2 to generate a low-light, intimate iPhone-style portrait of a curvy Persian/Middle Eastern woman leaning against a kitchen island, wearing a champagne satin slip top and black shorts, emphasizing warm tungsten lighting, natural skin texture, and a shallow depth of field with city skyline bokeh.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Gym Mirror Selfie with Post-Workout Glow (iPhone Style)', 'text_to_image', '{
  \"meta\": {
    \"camera\": \"iPhone 17 Pro\",
    \"lens\": \"24mm wide\",
    \"aspect_ratio\": \"9:16\",
    \"time_of_day\": \"8:12 PM\",
    \"lighting_temperature\": \"cool 4800K indoor LEDs\",
    \"style\": \"real iphone gym mirror shot, natural skin texture, subtle grain, mobile HDR\"
  },

  \"scene\": {
    \"location\": \"modern gym locker room mirror\",
    \"environment_details\": [
      \"matte black lockers\",
      \"soft overhead LED panels\",
      \"slightly fogged mirror edges\",
      \"neutral concrete flooring\"
    ],
    \"atmosphere\": \"post-workout heat, confident, private\"
  },

  \"subject\": {
    \"age\": \"clearly adult (late 20s)\",
    \"ethnicity\": \"Asian (Korean/Japanese mix)\",
    \"body_type\": \"slim thick, tight waist, round hips, toned thighs\",
    \"pose\": {
      \"position\": \"mirror selfie, hip slightly popped\",
      \"one_hand\": \"holding phone low\",
      \"other_hand\": \"adjusting high ponytail\",
      \"expression\": \"cocky teasing smirk, direct eye contact\"
    },
    \"hair\": {
      \"color\": \"jet black\",
      \"style\": \"high ponytail with loose strands\"
    },
    \"outfit\": {
      \"top\": \"ultra tight charcoal sports bra, stretch tension visible\",
      \"bottom\": \"high-cut seamless gym shorts, sculpting fit\"
    },
    \"skin_details\": \"tiny sweat glow on collarbones, realistic pores\"
  },

  \"lighting\": {
    \"main\": \"overhead LED gym lighting\",
    \"effect\": \"defined shadows under abs and thighs, subtle highlight on shoulders\"
  },

  \"camera_details\": {
    \"depth_of_field\": \"deep focus typical of iphone wide lens\",
    \"imperfections\": \"slight tilt, mirror smudge realism\"
  }
}', 'https://cms-assets.youmind.com/media/1774074527706_kkap8r_HCfIInJagAArOZ5.jpg', 'grok-imagine-image-pro', 'A highly detailed prompt for generating a mirror selfie in a modern gym locker room, styled as an authentic iPhone wide-angle shot (24mm lens). It specifies the subject\'s Asian ethnicity, \'slim thick\' body type, post-workout glow, and a cocky expression, focusing on realistic details like sweat and mirror smudges.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Hyper-Photorealistic Bathroom Mirror Scene', 'text_to_image', '{
  \"aspect_ratio\": \"9:16\",
  \"prompt\": \"Photorealistic bathroom mirror scene of the same woman (exact face reference from uploaded photo, preserve every facial feature, skin texture, pores, natural imperfections, no beautification or smoothing) standing in front of a large rectangular bathroom mirror, brushing her teeth with a white electric toothbrush in her right hand. Framed to show her full face and upper shoulders clearly in the mirror reflection, looking straight at her reflection in the mirror with a neutral/relaxed expression, slight foam at the corners of mouth from toothpaste. Mouth slightly open during brushing motion, toothbrush angled naturally against teeth. Shot from the viewer\'s perspective as if standing behind her looking into the mirror (mirror reflection composition), eye-level framing. Bright even bathroom lighting from overhead LED fixtures (cool-white 4000-5000K) plus soft warm vanity lights around the mirror edges, creating realistic skin highlights, subtle shadows under chin, natural eye catchlights, authentic wet-look shine on lips/teeth from toothpaste/foam. Medium-length chestnut brown hair loosely tied back in a messy low ponytail or bun, a few loose strands framing face. Wearing a simple light gray cotton t-shirt or basic crew-neck top, fully clothed, modest coverage. Delicate fine-line tattoo visible on right forearm if present in reference. Foreground details: modern white porcelain sink with chrome faucet/tap running slightly (small stream of water visible), toothbrush charger on counter, tube of white toothpaste open nearby, marble or white tiled countertop with minor water spots for realism. Background softly blurred: tiled bathroom wall in light neutral tones, shower curtain or glass door faintly visible behind. Ultra-sharp focus on face/reflection, hyper-photorealistic skin details (visible pores, subtle redness, natural texture, light oil sheen on forehead), candid everyday smartphone or point-and-shoot photo aesthetic, natural color grading, high dynamic range, no artificial glow, no over-sharpening, believable depth of field with creamy bokeh on background.\",
  \"negative_prompt\": \"blurry, deformed face, changed facial features, plastic skin, beauty filter, airbrushed, doll-like, heavy makeup, exaggerated symmetry, bad hands, extra fingers, warped mirror reflection, text, watermark, logo, oversaturated, cartoonish, 3D render, low quality, jpeg artifacts, noise, night time, dim lighting, suggestive pose, exposed skin beyond normal casual, no selfie hand/phone visible\",
  \"style\": \"hyper-photorealistic, candid bathroom mirror everyday moment\",
  \"quality\": \"high-resolution, ultra-detailed skin pores/hair/texture/foam details\"
}', 'https://cms-assets.youmind.com/media/1774074520354_gzxf1n_HD2dP3Ka4AAkSH-.jpg', 'grok-imagine-image-pro', 'A detailed prompt for generating a hyper-photorealistic image of a woman brushing her teeth in front of a bathroom mirror, focusing on preserving exact facial features from a reference photo and achieving realistic lighting and skin texture. The prompt is structured with positive and negative constraints.', 7);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Intimate Nighttime Bedroom Portrait (iPhone Style)', 'text_to_image', '{
  \"meta\": {
    \"camera\": \"iPhone 17 Pro\",
    \"lens\": \"48mm\",
    \"aspect_ratio\": \"4:5\",
    \"time_of_day\": \"11:37 PM\",
    \"lighting_temperature\": \"warm 3000K bedside lamp\",
    \"style\": \"intimate iphone night shot, natural grain, authentic color science, soft HDR\"
  },

  \"scene\": {
    \"location\": \"modern bedroom with neutral bedding\",
    \"environment_details\": [
      \"soft beige sheets slightly wrinkled\",
      \"single bedside lamp glow\",
      \"dark background falloff\",
      \"quiet night atmosphere\"
    ],
    \"atmosphere\": \"intimate, slow, controlled\"
  },

  \"subject\": {
    \"age\": \"early 20s (clearly adult)\",
    \"ethnicity\": \"European brunette\",
    \"body_type\": \"curvy hourglass, full chest, tiny waist, round hips\",
    \"pose\": {
      \"position\": \"sitting on edge of bed\",
      \"legs\": \"one leg folded slightly inward\",
      \"arms\": \"one hand resting lightly on thigh\",
      \"expression\": \"soft dreamy gaze toward camera\",
      \"energy\": \"relaxed confidence, subtle invitation\"
    },
    \"hair\": {
      \"color\": \"dark brown\",
      \"style\": \"messy loose waves\"
    },
    \"outfit\": {
      \"top\": \"oversized off-shoulder white shirt, slightly translucent under warm light\",
      \"bottom\": \"minimal neutral lounge shorts\"
    }
  },

  \"lighting\": {
    \"primary\": \"warm bedside lamp from right side\",
    \"secondary\": \"very soft shadow fill\",
    \"effect\": \"gentle highlight on cheek and collarbone, natural falloff into shadow\"
  },

  \"camera_details\": {
    \"depth_of_field\": \"moderate portrait depth from 48mm lens\",
    \"imperfections\": \"slight handheld softness, realistic night grain\"
  }
}', 'https://cms-assets.youmind.com/media/1774074523777_8p7doi_HCfH_VoXgAArwnZ.jpg', 'grok-imagine-image-pro', 'A highly detailed prompt for generating an intimate, warm-toned portrait of a woman sitting on a bed in a modern bedroom, styled to look like an authentic iPhone night shot (iPhone 17 Pro, 48mm lens) with specific warm lighting (3000K bedside lamp) and focus on realistic body type and pose.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Realistic Gym Mirror Selfie with Exaggerated Proportions', 'text_to_image', '{
  \"aspect_ratio\": \"3:4\",
  \"photo_style\": \"casual everyday smartphone photo\",
  \"subject\": \"A young woman with long, straight black hair and light skin with visible freckles, wearing a white long-sleeved tight-fitting athletic top and dark grey high-waisted yoga shorts.\",
  \"environment\": \"A modern, brightly lit public restroom or gym locker room with white vertical rectangular wall tiles, an orange horizontal accent stripe near the ceiling, and a grey stone-textured countertop.\",
  \"scene_structure\": \"Subject in the midground taking a mirror selfie; a large mirror reflects the scene including a wall-mounted soap dispenser and a black bag on the counter in the background.\",
  \"composition\": \"Medium shot, mirror selfie, subject positioned slightly off-center, back turned toward the mirror with head rotated over the shoulder to face the camera lens.\",
  \"pose_structure\": \"V7 Pose Clone: Body angled 45 degrees away from the mirror, deep lower back arch (anterior pelvic tilt), left arm extended holding a smartphone, right arm resting at the side with hand on the thigh, head turned 90 degrees toward the shoulder looking at the phone screen.\",
  \"camera\": {
    \"device\": \"smartphone camera\",
    \"angle\": \"eye-level, slight side-angle perspective via mirror reflection\",
    \"height\": \"chest height\",
    \"distance\": \"medium-close\",
    \"perspective\": \"mirror reflection, wide-angle smartphone lens\",
    \"depth_of_field\": \"deep focus\"
  },
  \"lighting\": {
    \"type\": \"natural light\",
    \"source\": \"overhead fluorescent or LED panel lighting\",
    \"direction\": \"top-down and frontal from the mirror\'s perspective\",
    \"shadow_softness\": \"soft natural shadows\",
    \"exposure\": \"balanced smartphone exposure\"
  },
  \"color_science\": {
    \"style\": \"natural smartphone colors\",
    \"white_balance\": \"neutral\",
    \"contrast\": \"normal\",
    \"saturation\": \"natural slightly vibrant\"
  },
  \"body_proportions\": \"Slender waist, prominent and wide-set hips, significant gluteal volume, toned legs, slim upper torso and arms; exact preservation of the exaggerated lower-body silhouette and curvature.\",
  \"facial_details\": \"Natural makeup, focused gaze toward the phone, subtle pout, visible freckles on cheeks and nose bridge.\",
  \"materials_and_textures\": \"Ribbed texture on the white top, matte stretch fabric of the grey shorts, glossy wall tiles, polished stone counter, realistic skin texture with slight natural sheen.\",
  \"atmosphere\": \"Casual, routine, fitness-oriented lifestyle snapshot.\",
  \"generation_prompt\": \"A casual 3:4 smartphone mirror selfie of a woman with long black hair and freckles. She is wearing a tight white long-sleeve top and charcoal grey gym shorts. She is posed with her back to the mirror, arched back, looking over her shoulder at the phone. The body silhouette features a very slim waist and wide, voluminous hips and glutes. The setting is a bright restroom with white vertical tiles and an orange t', 'https://cms-assets.youmind.com/media/1774074525905_bjrgus_HD1KMiBboAIq2q8.jpg', 'grok-imagine-image-pro', 'A highly specific prompt for generating a casual smartphone mirror selfie in a gym restroom. It details the subject\'s appearance, attire (athletic top, yoga shorts), environment (tiled restroom), and pose (V7 Pose Clone, arched back). Crucially, it mandates the preservation of an exaggerated body silhouette (slim waist, wide hips, voluminous glutes).', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Cinematic Portrait Prompt for Google Nano Banana Pro', 'text_to_image', 'Ultra-realistic cinematic portrait of a stylish man in a black suit, captured from behind with his head turned over his shoulder, giving a sharp, intense look toward the camera. Short textured hair with subtle highlights, well-groomed beard. Dramatic spotlight from above creating a warm golden halo effect on his hair and face, fading into a dark background. Strong chiaroscuro lighting with deep shadows and soft highlights.', 'https://cms-assets.youmind.com/media/1774074507050_l7a8ti_HD0BCw4bAAAdfQF.jpg', 'grok-imagine-image-pro', 'A prompt for Google Nano Banana Pro to generate an ultra-realistic cinematic portrait of a stylish man. The focus is on dramatic lighting (chiaroscuro, spotlight) creating a golden halo effect, and a sharp, intense look towards the camera.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Tzuyu Maid Cosplay Mirror Selfie', 'text_to_image', '{
  \"subject\": {
    \"name\": \"{argument name=\"subject name\" default=\"Tzuyu (Chou Tzuyu) from TWICE\"}\",
    \"description\": \"Young adult woman, Tzuyu from TWICE, in a cute emerald-green-and-white maid cosplay taking a mirror selfie\",
    \"expression\": \"Shy yet playful, elegant gaze, eyes mostly hidden by phone and long dark bangs\",
    \"face\": \"Exact face of Tzuyu, large almond eyes, symmetrical features, soft feminine makeup, subtle eyeliner, clean skin\"
  },
  \"hair\": {
    \"color\": \"Dark espresso brown\",
    \"style\": \"Long straight espresso hair, glossy, ends tucked inward\"
  },
  \"body\": {
    \"frame\": \"Tall and slender, athletic yet feminine frame, defined waist, emphasized by leaning posture\",
    \"skin\": \"Fair porcelain tone, smooth velvety texture, visible shoulders, chest, arms, and thighs\",
    \"legs\": \"Long-looking in dark green fishnet stockings\"
  },
  \"pose\": {
    \"position\": \"Standing in front of full-length mirror, arching back slightly while leaning toward the glass\",
    \"hands\": \"One holding phone leaving the entire face clearly visible, other gently touching the mirror surface\",
    \"overall\": \"Elegant yet playful forward-weighted candid lean\"
  },
  \"clothing\": {
    \"top\": \"Frilly white maid top with emerald green trim, ruffled straps & neckline, small green ribbons\",
    \"bottom\": \"Short frilled emerald-green-and-white maid skirt, green fishnet stockings\",
    \"details\": \"Matching wrist cuffs, strong emerald-white contrast\"
  },
  \"accessories\": {
    \"headwear\": \"Emerald green ruffled maid headband\",
    \"jewelry\": \"Delicate silver necklace with pendant\",
    \"device\": \"Smartphone with glittery green bow case\"
  },
  \"photography\": {
    \"style\": \"Smartphone mirror selfie, social media realism, vertical 9:16\",
    \"angle\": \"Eye-level to slightly high, leaning into lens\",
    \"focus\": \"Moderately deep, subject sharp, background softly dim\",
    \"lighting\": \"Cool bluish-green ambient + soft warm skin reflection, low-light cozy\"
  },
  \"background\": {
    \"setting\": \"Dim private room, neutral walls, full-length mirror\",
    \"elements\": \"Bed, dark corners, subtle clutter, faint LED glow, neon \'Alice\' sign on wall\",
    \"atmosphere\": \"Late-night, lived-in, quietly theatrical\"
  },
  \"aspect_ratio\": \"9:16\"
}', 'https://cms-assets.youmind.com/media/1773989011828_gm8yd2_HDt6AdfbcAA6ijP.jpg', 'grok-imagine-image-pro', 'A detailed JSON prompt for Nano Banana Pro to generate a social media-style mirror selfie of Tzuyu (TWICE) in an emerald-green-and-white maid cosplay. The prompt specifies a playful, elegant pose (leaning toward the mirror, holding a phone), fair porcelain skin texture, low-light cozy atmosphere, and the inclusion of subtle background elements like a neon sign.', 7);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Mirror Selfie of Blonde Woman', 'text_to_image', 'A highly realistic full-body mirror selfie (9:16 vertical) of a young blonde woman in her early 20s with a Mediterranean/Latina appearance, smooth warm olive-tan skin, and an athletic hourglass figure with a slim waist and toned legs. She stands slightly angled to the side with her weight shifted onto one hip, making direct eye contact with the mirror.

She has a soft oval face with a gentle jawline, large almond-shaped dark chocolate brown eyes with thick lashes and subtle winged eyeliner, naturally arched medium-thick dark brows, a small straight nose with a refined tip, and full symmetrical lips in a dusty-rose tone with a soft satin finish, slightly parted. Her cheeks have subtle contouring with a light peach blush, and her expression is calm, neutral, and soft-glam.

Her hair is extremely long, straight blonde hair, center-parted, flowing behind her shoulders with subtle sun-kissed highlights.

She is wearing a matching two-piece athletic loungewear set in a {argument name=\"outfit color\" default=\"peach-orange\"} color with a subtle lighter geometric/chevron pattern. The outfit includes a short-sleeved scoop-neck crop top and high-waisted leggings extending over the feet like hosiery, featuring a distinct open-thigh cutout on the left leg. She holds a small matte black nylon gym bag in her right hand and a smartphone with a light pink and white floral/damask patterned case.

The setting is a modern, brightly lit indoor bedroom or dressing hallway with light oak wood flooring, clean white walls, and white paneled doors with brass handles. In the background, there is a partially visible bed with white linens and a navy blue throw blanket.

Lighting is bright, soft, and diffused natural light from a side window, creating minimal shadows. The image is high-resolution mobile photography with sharp focus on the subject and slight background blur, featuring warm, vibrant tones and clean whites.', 'https://cms-assets.youmind.com/media/1773988990342_9uubcz_HDwXoKbawAAe2LA.jpg', 'grok-imagine-image-pro', 'A highly detailed prompt for Nano Banana Pro to generate a photorealistic, full-body mirror selfie (9:16 vertical) of a young blonde woman with a Mediterranean/Latina appearance and an athletic hourglass figure. The prompt specifies facial features, wardrobe (peach-orange athletic loungewear with a unique cutout), accessories, setting (modern bedroom), and lighting (soft, diffused natural light).', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - 1990s Portrait Prompt for Gemini Nano Banana Pro', 'text_to_image', '1990s portrait, beautiful radiant young woman, proclean skin, black eyes, glossy pink lips, long black-to-blackish-brown ombre hair. Pose: side view, leaning on weathered wood wall, looking up to sky, arm behind head. Outfit: vintage denim crop jacket, white v-neck. Lighting: strong directional sunlight, deep shadows. Aesthetic: analog film look, muted colors, retro filter, Nano Banana Pro realism, 8k photorealistic. --ar 9:16,copy my face
Use 100% face
Do not alter the face.
Do not change my face', 'https://cms-assets.youmind.com/media/1773988994277_bznz74_HDv198KbQAAsNYv.jpg', 'grok-imagine-image-pro', 'A prompt for Gemini Nano Banana Pro to generate a 1990s-style portrait of a young woman, emphasizing specific aesthetic details like proclean skin, glossy lips, strong directional sunlight, and an analog film look, requiring face preservation from a reference image.', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Chibi Style Mixed-Media Portrait', 'text_to_image', 'A high-quality mixed-media portrait of a trendy Surrounding the realistic main subject are several cute, 3D-style \'Chibi\' versions of the theirself. same wears and same face. These chibis are interacting playfully: one is sitting on the subject\'s shoulder, one is climbing their leg, another person is standing to the individual\'s left-standing in exactly the same pose manner as the girl and yet another is peeking out from behind person.Overlay the image with vibrant, hand-drawn doodle effects: white drawn outlines around the subject, playful scribbles, stars, heart, sparkles, electric sparks, and floating white, colourful, black and blue handwritten slogans like \'{argument name=\"slogan 1\" default=\"cutie\"}\', \'{argument name=\"slogan 2\" default=\"smile\"}\', \'fashion\', and \'happy\'. The style should seamlessly blend hyper-realistic photography with colorful, flat cartoon illustrations. Keeping face and all shape person unchanged.
image Ratio 3:4', 'https://cms-assets.youmind.com/media/1773988999107_vxyxvu_HDvbANeasAAR8xd.jpg', 'grok-imagine-image-pro', 'A prompt for Gemini Nano Banana 2 to create a mixed-media portrait blending a hyper-realistic main subject with several cute, 3D-style \'Chibi\' versions of themselves, overlaid with vibrant, hand-drawn doodle effects and handwritten slogans.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Profile / Avatar - Cyberpunk Magical Girl Sabrina Carpenter Prompt for Nano Banana Pro', 'text_to_image', '{ \"image_generation_prompt\": { \"subject\": { \"description\": \"Young woman with a strong resemblance to Sabrina Carpenter.\", \"hair\": \"Long straight twin-tails with blunt bangs.\", \"face\": \"Soft coy expression, wide eyes, glossy lips.\", \"body\": \"Slender build, shiny skin on legs.\" }, \"attire\": { \"clothing\": \"Intricate pink and white ruffled corset dress with sheer tutu skirt and metallic tech hardware.\", \"style\": \"Cyberpunk magical girl.\" }, \"styling_and_accessories\": { \"jewelry\": [ \"Cat-ear headphones\", \"Choker with bell\", \"Wrist cuffs\", \"Thigh garters with heart gems\", \"Metallic platform heels\" ] }, \"environment\": { \"setting\": \"Grungy abandoned concrete corridor.\", \"background\": \"Peeling walls, exposed pipes, scattered debris.\", \"water\": \"Wet concrete floor with reflective puddles.\" }, \"pose\": { \"posture\": \"Standing with legs spread wide.\", \"arms\": \"Hands held delicately near the chin.\", \"angle\": \"Low-angle full body shot.\" }, \"lighting_and_mood\": { \"lighting\": \"Bright frontal flash contrasting with dark background.\", \"mood\": \"Gritty yet vibrant.\", \"colors\": \"Neon pinks, crisp whites, industrial greys.\" }, \"camera_and_technical\": { \"style\": \"Ultra Photorealistic, RAW photo.\", \"lens\": \"35mm\", \"aperture\": \"f/2.8\", \"quality_tags\": [ \"8k resolution\", \"highly detailed\", \"volumetric lighting\", \"ray tracing reflections\", \"hyper-realistic texture\", \"Hasselblad photography\" ] } } }', 'https://cms-assets.youmind.com/media/1773989015429_pvw2pb_HDvNHN0bcAA51Gt.jpg', 'grok-imagine-image-pro', 'A detailed JSON-formatted prompt for Nano Banana Pro to generate an ultra-photorealistic image of a young woman resembling Sabrina Carpenter, styled as a Cyberpunk Magical Girl in a grungy, abandoned corridor setting.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Train-ad style book advertisement image', 'text_to_image', 'Please generate an advertisement image.

==== Ad specifications ===
- Aspect ratio: 16:9 (horizontal)
- Product to advertise: the book in the first attached image
- Main eye-catcher: place the book from the first attached image in a three-dimensional way
- Language: Japanese
- Taste: advertisement for a business book

# Text to include:
- Pre-head copy: 【New print run decided about one week after release】

Book “{argument name=\"book_title_en\" default=\"Designing from Zero with AI\"}” now on sale and doing well.

Amazon Best Seller Ranking
Ranked No.1 in commercial design sales (as of 10/15)
https://t.co/QxbYpfFVj6', 'https://cms-assets.youmind.com/media/1763885539326_yao7in_G6WBYReawAAcp2x.jpg', 'grok-imagine-image-pro', 'A detailed Japanese prompt for generating a 16:9 business-book-style advertisement featuring a specific book image with Japanese copy points.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Parisian High-Fashion Editorial Triptych Prompt for Nano Banana Pro', 'text_to_image', 'A high-fashion editorial triptych featuring a young French woman with a messy brunette bob and a natural smile. She is wearing a long, form-fitting knit dress with horizontal red and white stripes, paired with classic brown leather loafers and a vintage crossbody bag. The style is effortlessly elegant with a \"je ne sais quoi\" Parisian vibe.
​The Surreal Detail:
The focal point is the hem of the dress, which is visibly unraveled. A single, vibrant red thread of yarn has come loose and extends outward, trailing behind her along the cobblestone street like a thin, continuous line, connecting her to an unseen point in the distance.
​Setting & Atmosphere:
​Location: A narrow, historic street in Paris with beige stone buildings and a traditional \"TABAC\" brasserie in the background.
​Lighting: Soft, overcast daylight that brings out the richness of the red yarn and the texture of the cobblestones.
​Composition: A three-panel layout showing a close-up of the frayed hem, a full-length shot of her walking, and a medium shot focusing on her expression and the dress texture.', 'https://cms-assets.youmind.com/media/1774248327496_oc96jd_HEE168fbUAACcRp.jpg', 'grok-imagine-image-pro', 'A detailed image generation prompt for Gemini Nano Banana (Nano Banana Pro) requesting a high-fashion editorial triptych featuring a Parisian woman, focusing on the surreal detail of a single unraveling red thread trailing from her dress along a cobblestone street.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Cinematic Night Taxi Portrait with Teal and Orange Grading', 'text_to_image', '\"Image from subject, medium close-up, shot from outside through a reflective car window. The subject is ({argument name=\"subject position\" default=\"seated in the rear right passenger seat\"}), leaning back against the headrest, looking directly toward the camera through the glass. A hand is visible resting on the interior window frame. Wearing a light-colored crew-neck t-shirt and dark-tinted round sunglasses. The setting is a taxi interior at night. The background is a blurred urban landscape with bright bokeh from traffic and neon signs. Rain droplets and condensation are present on the glass surface. Cinematic teal-and-orange color palette. Vibrant red and green neon reflections are projected onto the subject and the window glass. High-contrast lighting with deep, crushed shadows and warm, hazy highlights. Dense 35mm film grain, heavy glass reflections, lens flares, and soft chromatic aberration at the edges. \"', 'https://cms-assets.youmind.com/media/1774248313255_l6y14w_HEDWL3mXoAEbP_F.jpg', 'grok-imagine-image-pro', 'A detailed prompt for generating a cinematic portrait shot from outside a reflective car window at night. The subject is seated in the rear, looking directly at the camera, with rain and neon reflections on the glass, using a high-contrast teal-and-orange color palette.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Soft Watercolor Illustration Style Art Prompt for Gemini Nano Banana Pro 2.0', 'text_to_image', 'Use the uploaded image as reference, A blend of high-end illustrative realism with delicate ink lines and soft watercolor strokes. Highly detailed depictions of faces with porcelain skin texture, delicate blush, and expressive sparkling eyes. Dynamic compositions of close-up portraits. Crisp white negative space backgrounds overlaid with architectural outlines, geometric construction grids, and technical drawing elements. Flowing strands of hair and fabric edges dissolve into abstract, transparent shards of color and paint splatters. A soft pastel palette (soft blues, warm yellows, pale pinks, light grays) with controlled saturation. An elegant balance between precise sketch lines and loose, atmospheric paint effects. A cinematic editorial illustration aesthetic with a modern fashion art feel, dreamy yet sharp, minimalist yet rich in detail. High-resolution, vertical portrait, 4k quality.', 'https://cms-assets.youmind.com/media/1774248307424_ysir5t_HEC-VOQbcAAOq_T.jpg', 'grok-imagine-image-pro', 'A detailed prompt for Gemini Nano Banana Pro 2.0 to transform an uploaded image into a high-end illustrative realism portrait with soft watercolor strokes and delicate ink lines, featuring a soft pastel palette and a cinematic editorial aesthetic.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Depression expression in rough line art for nano banana 2', 'text_to_image', 'This is the internal monologue expression of a person with depression, who repeatedly says \"{argument name=\"internal monologue\" default=\"Everything is alright\"}\", and the image is presented in a {argument name=\"visual style\" default=\"rough line art\"} style.', 'https://cms-assets.youmind.com/media/1774248320805_xvnnqh_HECmahjboAAQu7T.jpg', 'grok-imagine-image-pro', 'A prompt describing the internal monologue of a person with depression, repeatedly stating \'Everything is alright,\' rendered in a rough line art style, specifically noting the result generated by nano banana 2.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Luis Miguel as K-Pop Star in Gangnam', 'text_to_image', 'Luis Miguel as a Korean pop star from Seoul, smooth fair East Asian skin tone, jet black straight hair with slight side sweep, wearing a stylish tailored dark suit, standing in Gangnam district at night, modern glass towers lit up behind him, subtle lens flare, photorealistic, cinematic portrait photography, 85mm lens', 'https://cms-assets.youmind.com/media/1774248320239_l6nccy_HECicYcWMAAPiEC.jpg', 'grok-imagine-image-pro', 'A Nano Banana 2 prompt for generating a photorealistic, cinematic portrait of Luis Miguel reimagined as a Korean pop star, standing in Seoul\'s Gangnam district at night, specifying East Asian features, tailored dark suit, and subtle lens flare effects.', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Luis Miguel as a Russian Man in Red Square', 'text_to_image', 'Luis Miguel as a Russian man from Moscow, very fair cool-toned skin, light ash brown wavy hair, wearing a heavy dark wool coat with fur collar, standing in Red Square in winter, snow falling lightly, Saint Basil\'s Cathedral illuminated behind him, cold breath vapor visible, photorealistic, cinematic portrait photography, 85mm lens', 'https://cms-assets.youmind.com/media/1774248300911_mowqz4_HECiCysbIAAM3B9.jpg', 'grok-imagine-image-pro', 'A photorealistic, cinematic portrait prompt for Nano Banana 2, depicting the singer Luis Miguel as a Russian man standing in Red Square during winter, focusing on cold tones, heavy clothing, and visible breath vapor.', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Photorealistic Cinematic Portrait of Luis Miguel as a Jamaican Reggae Musician', 'text_to_image', 'Luis Miguel as a Jamaican reggae musician, deep warm dark brown skin tone, long dreadlocks black hair, wearing a yellow green red reggae tank top, standing on {argument name=\"location\" default=\"Negril beach Jamaica\"}, crystal turquoise ocean behind him, swaying palm trees, golden hour sunlight, photorealistic, cinematic portrait photography, 85mm lens', 'https://cms-assets.youmind.com/media/1774248302509_m6ydc8_HECh2nSaUAAYgfr.jpg', 'grok-imagine-image-pro', 'A detailed prompt for Nano Banana 2 to generate a photorealistic, cinematic portrait of the singer Luis Miguel reimagined as a Jamaican reggae musician, emphasizing specific physical features, attire, and a Negril beach setting during the golden hour.', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Macro Eye Portrait with Havana Reflection', 'text_to_image', '**Macro extreme close-up of {argument name=\"subject name\" default=\"Ana de Armas\"}\'s hazel eye, an intricate study of the human iris. The iris serves as a crystalline mirror, hosting a hyper-detailed miniature reflection of a bustling Havana street at sunset, complete with vintage 1950s American cars and pastel-colored colonial architecture. Every fiber of the iris is visible, showing unique crypts and furrows. The cornea displays a high-gloss moisture, catching a soft glint of golden hour light. Skin micro-texture is incredibly sharp, revealing fine pores and individual, delicate eyelashes with slight mascara clumps. Shot on Hasselblad X2D 100C, 120mm Macro f/4 lens. Volumetric lighting, cinematic side-lighting to emphasize depth, 8k resolution, photorealistic masterpiece. --ar 16:9 --stylize 250 --v 6.0**', 'https://cms-assets.youmind.com/media/1774248317734_y1nox1_HECTyN3XoAA3ybg.jpg', 'grok-imagine-image-pro', 'A highly specific Nano Banana Pro prompt for generating an extreme macro close-up of a hazel eye, where the iris reflects a hyper-detailed miniature Havana street scene at sunset, emphasizing photorealistic details like skin micro-texture, individual eyelashes, and professional Hasselblad camera settings.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Candid Nighttime Street Portrait with Flash Photography Aesthetic', 'text_to_image', 'A candid nighttime street portrait of a young woman sitting casually on a woven café chair outside a small urban restaurant. She has long black hair, natural makeup with a soft glow, and wears a white tank top layered over a black lace bralette, paired with relaxed denim jeans. She leans slightly to the side with one arm resting on the chair, looking off-camera with a calm, introspective expression. Subtle accessories include thin gold bracelets and a delicate necklace. The scene is lit with a direct flash, creating sharp highlights on her skin and a contrast against the dark street background. Neon signs and reflections from glass windows add pops of color, while the sidewalk and storefront create an authentic city nightlife vibe. Medium shot, shallow depth of field, film-like grain, flash photography aesthetic, raw and unfiltered mood, stylish yet natural composition', 'https://cms-assets.youmind.com/media/1774248298648_ckrjgf_HECI_lZaoAAfcAP.jpg', 'grok-imagine-image-pro', 'A detailed prompt designed to generate a candid nighttime street portrait of a young woman using a flash photography aesthetic, emphasizing high contrast, sharp highlights, and an authentic city nightlife vibe. This prompt is used to compare the output quality between Midjourney V8 and Nano Banana Pro.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Car Selfie with Three Subjects and Identity Lock', 'text_to_image', '{ \"subject\": \"three young women sitting closely together inside a car\", \"face\": \"three distinct young women with unchanged facial identity, natural proportions, realistic skin texture, Use uploaded reference image, keep identity exact for each individual\", \"hair\": \"each woman retains original hair color, length, and styling exactly as provided, including blonde, brunette, and dark tones with natural texture\", \"expression\": \"confident, relaxed, slightly posed expressions with direct and side glances, subtle attitude and casual mood\", \"pose\": \"seated closely side by side in car seats, bodies angled toward camera, one holding a phone, others leaning slightly inward for framing\", \"environment\": \"interior of a car with visible window showing outdoor greenery and road, casual travel setting\", \"lighting\": \"strong natural sunlight entering from side window, creating sharp highlights across faces and shadows, warm golden tones\", \"camera\": \"close-up selfie style, handheld smartphone perspective, slightly tilted framing, tight composition capturing all three faces\", \"clothing\": \"stylish casual outfits including black top, lace detail garment, and patterned top, accessorized with jewelry like necklaces and bracelets\", \"imperfections\": \"harsh sunlight causing overexposed highlights, shadow splits across faces, slight motion blur, natural skin details\", \"style\": \"candid lifestyle photography, social media aesthetic, warm tones, unfiltered spontaneous capture\" }', 'https://cms-assets.youmind.com/media/1774248316716_b9vof6_HEB7nJHbEAEFnLC.jpg', 'grok-imagine-image-pro', 'A Nano Banana Pro prompt designed to generate a photorealistic, candid-style car selfie featuring three young women, ensuring the exact identity of each subject is preserved using reference images, captured in strong natural sunlight.', 12);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Sparkling Cheetah Portrait Prompt for Gemini Nano Banana Pro', 'text_to_image', '{
  \"image_prompt\": {
    \"subject\": {
      \"type\": \"young woman\",
      \"features\": {
        \"hair\": \"bright red, tied back in a loose ponytail with some face-framing strands\",
        \"eyes\": \"blue\",
        \"skin\": \"fair with light freckles\",
        \"expression\": \"neutral, serious, maintaining direct eye contact with the camera\"
      }
    },
    \"clothing\": {
      \"garment\": \"long-sleeve, form-fitting top\",
      \"pattern\": \"leopard print (tan, brown, and black spots)\",
      \"texture\": \"subtle glittery or sparkly finish\"
    },
    \"pose\": {
      \"stance\": \"standing sideways, body angled slightly away but face turned towards the viewer\",
      \"arms\": \"right hand resting naturally on her hip\"
    },
    \"environment\": {
      \"setting\": \"indoor room, likely a home office, streaming room, or bedroom\",
      \"background_elements\": [
        \"white desk\",
        \"black computer monitors\",
        \"white spherical microphone on a small tripod stand\",
        \"black desk mat or keyboard\",
        \"plain white walls\"
      ]
    },
    \"photography_style\": {
      \"lighting\": \"soft, bright, natural-looking indoor daylight\",
      \"focus\": \"shallow depth of field (sharp subject, slightly blurred background)\",
      \"aesthetic\": \"photorealistic, high-resolution portrait photography\"
    }
  }
}', 'https://cms-assets.youmind.com/media/1774248308166_gjsihf_HEBrgEGaMAAX8eY.jpg', 'grok-imagine-image-pro', 'A detailed, structured JSON prompt for Gemini Nano Banana Pro to generate a photorealistic portrait of a young woman wearing a sparkly leopard print top in an indoor setting, emphasizing specific features, pose, and lighting.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Cinematic Winter Portrait with Stylized Snowman', 'text_to_image', '{ \"photo_type\": \"Cinematic winter portrait (ultra-realistic human with stylized companion)\",  \"subject\": { \"description\": \"A real human woman in a snowy outdoor environment, photographed like a high-end cinematic winter shoot\", \"gender\": \"Female\", \"pose_description\": \"Standing upright on snow, body slightly angled, left arm raised outward with palm open, right arm relaxed, confident elegant posture\", \"expression\": \"Soft calm expression with a subtle confident smile\" },  \"face\": { \"description\": \"{argument name=\"subject name\" default=\"Sadie Sink\"}, use uploaded reference image, keep face 100% identical with real human texture\", \"extra_realism\": [ \"visible pores\", \"subtle asymmetry\", \"natural lip texture\", \"cold redness on cheeks\" ] },  \"hair\": { \"color\": \"Golden blonde blended with icy white highlights\", \"style\": \"Thick voluminous side braid\", \"details\": [ \"full dense braid\", \"loose front strands\", \"flyaways\", \"natural uneven thickness\" ], \"physics\": \"natural wind interaction\" },  \"clothing\": { \"type\": \"Short flowing winter dress\", \"design\": \"upper-thigh length, softly fitted at the waist with a gently flared skirt\", \"exposure_balance\": \"tasteful and elegant reveal of legs and silhouette without explicit exposure\", \"fabric_realism\": [ \"fine textile detail\", \"slightly sheer outer layer with inner lining\", \"natural folds\", \"light scattering\" ], \"physics\": [ \"wind lifting hem slightly\", \"gravity-based draping\", \"imperfect flowing edges\" ] },  \"companion_character\": { \"type\": \"Stylized semi-real snowman\", \"style_balance\": \"70% real, 30% cartoon\",  \"structure\": [   \"three stacked snow spheres with slightly rounded proportions\",   \"textured snow surface\",   \"slightly expressive head size\" ],  \"face\": {   \"eyes\": \"coal eyes slightly larger and expressive\",   \"nose\": \"stylized carrot nose\",   \"mouth\": \"clean coal smile, slightly imperfect\" },  \"body_details\": [   \"twig arms with gentle curves\",   \"coal buttons evenly spaced\",   \"visible snow texture\" ],  \"material_behavior\": [   \"realistic snow light reflection\",   \"softened edges for character feel\" ],  \"position\": \"standing beside the woman, slightly angled toward her\"  },  \"environment\": { \"setting\": \"Real snowy outdoor location\", \"details\": [ \"uneven snow surface\", \"footprints\", \"falling snow particles\", \"light atmospheric haze\" ], \"interaction\": [ \"snow bounce light on subject\", \"light snow settling on dress and hair\" ] },  \"lighting\": { \"type\": \"Natural winter daylight\", \"setup\": [ \"overcast soft light\", \"strong snow bounce fill\", \"subtle rim separation\" ], \"effects\": [ \"soft light wrap\", \"natural highlights\" ], \"color_temperature\": \"cool daylight 6200K\" },  \"camera\": { \"type\": \"Full-frame DSLR\", \"lens\": \"85mm\", \"aperture\": \"f/2.0\", \"iso\": \"ISO 125\", \"shutter_speed\": \"1/500s\", \"focus\": \"sharp on subject and snowman, soft background falloff\" },  \"imperfections\": { \"add\": [ \"fine grain\", \"slight shadow noise\", \"natural hair movement\", \"minor asymmetry\" ] }', 'https://cms-assets.youmind.com/media/1774248319179_nstat3_HEBoNH1aQAAXtsA.jpg', 'grok-imagine-image-pro', 'A highly detailed Nano Banana 3.1 Pro prompt for generating a cinematic, ultra-realistic winter portrait of a woman (Sadie Sink likeness, requiring reference image for face lock) standing next to a stylized, semi-real snowman, specifying complex details for clothing physics, snow interaction, and cool daylight lighting.', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Social Media Post - Serene Water Portrait with Celebrity Likeness Lock', 'text_to_image', '{ \"subject\": \"young woman partially submerged in clear water\", \"face\": \"side profile of a young woman with eyes closed, relaxed expression, smooth natural features, slightly flushed skin from sunlight, Use uploaded reference image, keep identity exact, explicitly based on provided reference image\", \"hair\": \"dark brown hair, wet, slicked back and clinging to head and neck, natural texture preserved\", \"expression\": \"calm, serene, eyes closed, lips slightly parted, enjoying warmth of sunlight\", \"pose\": \"upper body emerging from water, shoulders submerged, head tilted slightly upward toward light, hands loosely together beneath water surface\", \"environment\": \"clear turquoise water with visible ripples and reflections, natural outdoor setting, possibly pool or calm sea, sunlight reflecting off surface creating patterns\", \"lighting\": \"strong natural sunlight from above, warm highlights on face and shoulders, high contrast with reflective water caustics, slight overexposure on skin highlights\", \"camera\": \"close-up shot, side angle profile, eye-level perspective, shallow depth of field, focus on face and upper torso\", \"clothing\": \"minimal visible clothing, possibly dark swimsuit beneath water surface, indistinct due to refraction\", \"imperfections\": \"natural skin texture, slight shine from water and sunlight, minor overexposed highlights, water distortion around submerged areas\", \"style\": \"photorealistic, candid lifestyle photography, natural tones, high detail, no stylization\" }', 'https://cms-assets.youmind.com/media/1774248315961_b17a7i_HEBfpU9acAAsSL0.jpg', 'grok-imagine-image-pro', 'A detailed Nano Banana Pro prompt for generating a photorealistic close-up image of a young woman partially submerged in clear water, focusing on a serene expression and using a reference image to maintain exact celebrity identity.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Infographic / Edu Visual - 3x3 Grid Prompt for Lighting Cheatsheet', 'text_to_image', 'A 3x3 photo grid presented as a single image on a dark grey background. Each of the nine grid cells contains a different portrait of the same subject from the uploaded image, maintaining the perfect character consistency, outfit and pose across all panels. Below each individual portrait, a clean sans-serif text label with a number and name is clearly displayed.

The grid layout and lighting setups are: 

- Top row, left to right:

Loop Lighting (Flattering 3/4 light with a small loop of shadow from the nose onto the cheek)

Hardlight Frontal Flash (direct front facing, harsh flashlight with deep frontal shadows)

Split Lighting (dramatic light on only one side of the face, leaving the other side completely dark)

- Middle row, left to right:

Butterfly Lighting  (classic symmetrical light from the front, slightly high, with a small shadow under the nose)

Gobo Pattern (Venetian Blind)\' (light projected through Venetian blinds, creating linear shadows across the face and clothes, the shadow can also be scene on the background)

Under-Lighting (Uplight)\' (light coming from below, creating reverse shadows and a moody look)

- Bottom row, left to right:

Golden Hour / Warm Light\' (bathed in soft, golden, warm light from a side angle)

Dramatic Spotlight  (hard, narrow circular beam of light, with a deep chiascuro effect and crushed blacks)

Neutral Kelvin Rim Light\' (intense backlighting with no front fill, creating a distinct glowing outline around the hair and shoulders, leaving the face in darkness, against a black background).

The perspective and features remain identical in all panels, with only the specified lighting changing to match the label.', 'https://cms-assets.youmind.com/media/1774248307158_jyis07_HECyRQkbwAAPNRV.jpg', 'grok-imagine-image-pro', 'A complex prompt for Nano Banana Pro designed to generate a 3x3 grid image containing nine identical portraits of a subject, with each panel demonstrating a different, specifically named lighting technique (e.g., Loop, Split, Butterfly, Golden Hour), useful as a relighting cheatsheet.', 2);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Infographic / Edu Visual - Flat UI/Startup Style Illustration Prompt', 'text_to_image', 'Flat illustration of {argument name=\"subject\" default=\"[subject]\"}, startup-style vector art, bright colors, simple shapes, clean and professional design, white background, no text.', 'https://cms-assets.youmind.com/media/1774248298494_hmspay_HEBU7CUakAAZ7B4.jpg', 'grok-imagine-image-pro', 'A simple, reusable prompt for Nano Banana Pro to generate flat, startup-style vector illustrations of a specified subject, emphasizing bright colors, simple shapes, clean design, and a white background, with an explicit instruction to exclude text.', 10);

INSERT IGNORE INTO \`showcase_items\` (\`title\`, \`type\`, \`prompt\`, \`output_url\`, \`model_used\`, \`description\`, \`category_id\`) VALUES 
('Infographic / Edu Visual - Watercolor Map Generation Prompt', 'text_to_image', 'A detailed watercolor-style map of {argument name=\"country name\" default=\"COUNTRY\"} on lightly textured paper, soft flowing washes in distinct harmonious colors for each first-level administrative division, all federal states, provinces or regions accurately separated by clear borders and labeled directly inside their areas in neat blue ballpoint-pen handwriting, educational and infographic-friendly, clean composition, high legibility, subtle paper grain, gentle shading, refined illustrative finish, balanced negative space, no cities, no roads, no flags, no logos, no watermark, bright clean background', 'https://cms-assets.youmind.com/media/1774248304199_s1s09e_HEBK9gkWwAA5Ozo.jpg', 'grok-imagine-image-pro', 'A detailed prompt for Nano Banana 2 to create a watercolor-style map of a specified country, focusing on clean design, high legibility, and specific artistic constraints (no cities, roads, flags, logos, or watermarks).', 9);
