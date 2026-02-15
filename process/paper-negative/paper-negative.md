
# Paper Negatives

In December of 2025, I received a Hasselblad cut film adapter (41017) and four film holders (51012), compatible with the 500-series camera bodies. 

TODO: film back, film holder images. 

In searching for ways of using these items, I stumbled upon some paper negatives I had shot in September of 2025 on a pinhole camera, as part of a class assignment. 

TODO: pinhole negatives, positives. 

caption: Pinhole negatives and contact-printed positives on Ilford MGRC Deluxe Pearl. Negatives were shot unfiltered and developed in Ilford Multigrade Developer 1:18, positives were developed in the same, but mixed to the standard 1:9. 

It occurred to me that I could take much higher-quality images on photopaper using my own (or similar to my own, given that my 500C is waiting in limbo for a high-speed nylon shutter gear) Hasselblad body and lens than with a punctured tin can.

## The Handicap

I should acklowledge that paper negatives are a technical downgrade in every sense from modern analog photographic processes. The paper is absurdly slow compared to modern film (Ilford cites an ISO rating of 3-6 for its Multigrade RC papers), and the achievable resolution of a 6x6cm paper negative is comparable to that of 35mm film (see TODO:link Optical Enlargement for a comparison). Photographers who make paper negatives often do so on large-format cameras [[1]](#source-1), producing negatives 3.5 (for 4x5 film) to 14 (8x10) times larger than my Hasselblad is capable of. 


Still, I found making paper negatives attractive because they represented a distillation of the standard analog photographic process (TODO: link to darkroom printing article). Instead of using two sets of photosensitive media, chemistry, tools, and times, I am able to produce an original image in exact same manner that I produce copies thereof. There is also an advantage, however slight, in the speed and portability of a medium-format system compared ot large-format. The cameras are smaller and lenses, for the most part, are faster, allowing for images to be made outside of the traditional studio or static landscape environments. 


My class in September developed pinhole paper negatives in diluted chemistry to tame the high contrast of the photopaper, especially when exposed to daylight [[2]](#source-2). In standard developer, any exposure long enough to hit the maximum density of the paper (Dmax) tended to leave very little detail in highlights of the positive image, requiring severe underexposure and limiting the already-slim dynamic range of the paper negative. The simplest fix, as determined by the Intro Photography instructor team, was to have students develop in half-strength developer instead. 

TODO: ilford MGRC datasheet frequency response [[2]](#source-2)

Mixing diluted developer seemed to be a step away from the streamlined process that drew me to paper negatives in the first place, so I resolved to find another way to use the same chemistry for both my negatives and final prints. To take advantage of the entire dynamic range of the photopaper (i.e. expose enough to reach Dmax and still maintain usable contrast), I used a set of Ilford Multigrade enlarger filters placed in front of the lens during exposure. 

TODO: enlarger filters

## Testing

Making an intentionally-exposed negative is a necessary, but not sufficient, condition for creating compelling images. I felt that a series of scientific (-ish) tests would give me this technical baseline, so that I might spend more mental effort on my creative process than in the weeds of exposure values. 

### Interior: Exposure and Contrast

My first set of tests was to dial in proper exposure and contrast of the negatives in an evenly-lit interior scene: the Tjaden Hall DIM lab. 


TOOD: test 1
Caption: the first paper negative test. 

I found that, unfiltered, a slight underexposure of the scene (compared to the suggestion of an incident lightmeter at ISO 6) yielded the best results in standard [[3]](#source-3) chemistry. With filters 0-2 applied, an exposure at or slightly (<1 stop) above metered was best. Ilford mentions that no exposure compensation is necessary for filters 00-3 [[4]](#source-4), but this appears to be true only when moving between filters 00-3. Per Ilford's Multigrade RC datasheet [[2]](#source-2), the paper is rated at ISO P500 unfiltered, and ISO P200 with filters 00-3 applied.  Therefore, the paper loses 

$$
        \text{log}_2(500/200) = 1.32 \text{stops}
$$

stops of light with filters 00-3 applied. The difference is higher for filters 4-5, but not relevant to my goal of reducing constrast. Note that the paper's ISO sensitivity is rated on a different scale to photographic film: Ilford rates Multigrade RC at an equivalent film ISO of 3-6 [[2]](#source-2).

I liked the highlight detail of the #0 best when digitally inverted, especially compared to the pictured print calibration chart. This became my 'default' filter in further testing.

TODO: #0 inverted negative, color print chart (iphone)
Caption: #0 negative, digitally inverted, and color print calibration chart (captured on my iPhone 16). 

NOTE: In most of these tests, I processed the negatives digitally. While not necessarily in line with my previously-stated goal of process distillation, I used digital inspection and processing to isolate the effects of my exposure and development on the negatives themselves, as opposed to later darkroom prints. While certainly an important step in the process, making darkroom prints requires additional technical consideration beyond producing a well-exposed negative. I decided to dial this only after I became confident in exposing consistent negatives. 

## Outdoors

For my second set of tests, I attempted to capture the effect of different lighting conditions on the paper negatives.

TODO: Test 2 
Caption: the second paper negative test, encompassing a few more lighting conditions. 


 Outdoors, the higher blue light present in bright sunlight made a 1-stop underexposure (relative to meter readings at ISO 6) render best. To investigate the reciprocity failure so common in film, I found a poorly-lit scene at night on the under-construction White Hall. Exposed as metered, the combination of warmer interior and lamppost lighting and low-intensity reciprocity failure contributed to a Very Thin Negative. While there was some information in the highlights (extracted with significant digital post-processing), the final imaage is clearly distinct in quality from those taken during the day. If, during a masochist streak, I ever decide to shoot paper at nighttime again, I will increase my exposure by a few stops to accommodate the paper's lack of sensitivity to the red end of the visible spectrum and its low intensity reciprocity failure. 

Todo: white hall exposure, negative
Caption: The negative produced by image number 4 above. Note the lack of any information in the highlights discernible to the naked eye. 


Eagle-eyed viewers might notice the row of flat, thin images below. To investigate why they look like this, some math is in order. 

## A Diversion: What Strobe Guide Number Really Means 


I shot the above scene with an on-camera Yongnuo YN560 speedlight rated at a maximum power guide number ($\text(GN)$) of 58m at ISO 100 and 135mm zoom [[5]](#source-5). At 50mm zoom (approximately the full-frame equivalent of the 80mm lens I have attached to the Hasselblad), the GN reduces to 42m. I

TODO: gear flick
Caption: The Hasselblad 500C and flash. For those who would like to replicate this setup, ensure that you purchase a PC-to-PC strobe sync cable, *not* a PC to 2.5mm cable, or any other combination. 

 We can express the guide number in terms of the subject's distance and the lens' f-stop: 
$$
    \text{GN} = \text{Distance} \times \text{f-stop}.
$$
In this section, I take flash power (tracked by the guide number) as the variable of interest in making a proper exposure, and consider f/stop and subject distance to be fixed. I believe that this provides an easier framework to make artistic choices about framing and depth-of field before ensuring that a proper exposure is made, but f/stop and subject distance are certainly valid knobs to turn in search of the right exposure. 

In some cases, flash power can be considered to take the place of shutter speed in the traditional exposure triangle, depending on ambient exposure value and camera sync speeds [[6]](#source-6). Because a flash fires so quickly (usually 1/1000 of a second or faster), the intensity of light captured by the camera's sensor from a flash is relatively independent of shutter speed. To use the common 'bucket of water' analogy for exposure, the light from a flash is less like a faucet with a constant flow of water than it is someone dumping another bucket into yours, instantaneously. To simplify the following section further, we take the ambient exposure value of the scene (e.g. the flow rate of the 'faucet' times the exposure time) to be low enough compared to the flash intensity (a function of power level, tracked by guide number) to be negligible. In reality, ambient exposure is one of many factors to be taken into account when lighting your scene. 

Back to the story.


F-stop, as the ratio of the lens' focal length to its aperture diameter, is unitless, meaning that GN is expressed in units of distance. For example, if shooting a subject 4 meters away at f/8 and ISO 100, you would calculate a guide number of 

$$
\text(GN, desired) = 4 \si(meters) \times 8 = 24 \si(meters)
$$

But wait! My flash has a guide number of 42m! Where do I go from here? 

The (almost) final step in making a proper strobe exposure is to set your flash power according to your desired guide number (in our example case, 24m). To do this, we recognize that light intensity $I$ is inversely proportional to the square of distance $r$ from the subject (otherwise known as the inverse square law).

$$
I \propto \frac{1}{r^2}
$$

So to increase the amount of light on a subject by 1 stop (i.e. a doubling of the incident light intensity), we must decrease our distance to the subject by $ \sqrt{2} \approx 1.4 $. 

Equivalently, guide number scales with the square root of flash power. In other words, if you change flash power by a factor of $P$, the guide number changes by $\sqrt{P}$:

$$
\frac{\text{GN}_2}{\text{GN}_1} = \sqrt{\frac{P_2}{P_1}}
\qquad \Rightarrow \qquad
\frac{P_2}{P_1} = \left(\frac{\text{GN}_2}{\text{GN}_1}\right)^2
$$

So if your flash is rated $\text{GN}_\text{full} = 42\si(m)$ at full power, and you only need $\text{GN}_\text{need} = 24\si(m)$, the required power fraction is:

$$
\frac{P_\text{need}}{P_\text{full}} =
\left(\frac{24}{42}\right)^2
\approx 0.33
$$

That’s about one third power. On a flash that only offers 1/2, 1/4, 1/8, ... the closest setting is 1/4 power (slightly low) or 1/2 power(slightly high). You can nudge the last bit with a small aperture/distance tweak (or ISO, if shooting digitally). 

To this point, we have treated ISO as a fixed 100. But what if you're shooting ISO 400 film? Or ISO 6 photopaper? 

We know that doubling ISO increases sensitivity by 1 stop. Because decreasing distance by $\sqrt(2)$ does the same, we can extract a relationship between guide number (in units of distance) and ISO:

$$
\text{GN}(\text{ISO}) = \text{GN}(\text{ISO }100)\sqrt{\frac{\text{ISO}}{100}}.
$$


## Photopaper Strobe Exposures 

Given my GN at ISO 100 of 42m, a subject distance of 1m, and an f-stop of 4, I had all the information I needed to make a proper exposure (or so I thought). 

From the above equations, I can calculate my desired GN 

$$
\text{GN, desired} = 1~\si(meters) \times 4 = 4\si(meters)
$$

and convert my flash's full-power GN to the nominal ISO (6) of my photopaper

$$
\text{GN, full} = 42 \times \sqrt(\frac{\text{ISO 6}}{\text{ISO 100}}) \approx 10.3.
$$

My desired power fraction $\text{P}$ is then 

$$

\text{P} = (\frac{\text{GN, desired}}{\text{GN, full}})^2 = (\frac{4}{10.3})^2 \approx 1/6.

$$

To account for any number of factors I could've gotten wrong with the above in the moment, I decided to expose at 1/4 power. Given the daylight-balanced 5600K light [[5]](#source-5) from the YN560, and the outdoor results above, I expected overexposure at all but a #00 filter. 

This was not the case. While all negatives displayed some information, they were noticeably thin. 

TODO: negs compared to pos for mork leo flash
Caption: Negatives and digitally-inverted positives for the #00 and unfiltered strobe exposures from Test 2. 

This test wasn't quite conclusive, especially considering the odd patterns on the #1 and #0 images (perhaps accidental fogging of the paper while re-inserting the darkslide?). 

I hoped to settle the matter with my third set of negatives. 

coming soon

























## Sources

<a id="source-1"></a>[1] Ian Gamester, https://www.ilfordphoto.com/paper-negatives/. Tim Layton, https://timlaytonfineart.com/2024/09/07/the-calotype-paper-negative/. Ethan Doyle, https://ethandoyleprojects.com/8x10-paper-negatives. 

<a id="source-2"></a>[2] Ilford Multigrade RC Datasheet, https://www.ilfordphoto.com/wp/wp-content/uploads/2021/01/MULTIGRADE-RC-Papers-J20.pdf

<a id="source-3"></a>[3] Unless otherwise specified, standard chemistry refers to Ilford Multigrade Developer 1:9, Ilford Rapid Fix 1:9, Ilfostop XX:XX, for 120 seconds, 30 seconds, and 120 seconds, respectively. 

<a id="source-4"></a>[4] Ilford Multigrade Contrast Control, https://www.ilfordphoto.com/wp/wp-content/uploads/2017/03/Contrast-control-for-Ilford-Multigrade.pdf

<a id="source-5"></a>[5] Yongnuo YN560 User Manual, https://www.yongnuo.fr/wp-content/uploads/notices/YN-560_en.pdf

<a id="source-6"></a>[6] Flash Sync Speed, https://www.newschoolers.com/news/read/Flash-Sync-Speed-Explained 
