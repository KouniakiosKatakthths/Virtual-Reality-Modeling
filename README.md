# Virtual Reality Modeling
For the VRM laboratory the godot game engine is been used. For uploading large files to github, Git Large File Storage (GLFS) is also used.


## Lab 3
For the lab 3 feedback elements have been implemented. This includes particle systems and audio cues. Also a **volumetric fog** effect has been added.

#### Audio Systems
An audio system for the player that is adding sound on player actions like:
* Walking
* Sprinting
* Crouching
* Pickup item / Drop Item

Sounds have also been added in some interactions for the campfire. Spesificly:

* Rock Moving sound effect
* Oil spreding sound effect
* Lighter igniting sound effect
* Camfire sound effect

Ambient sound has also been added in the scene with two nodes: the **ambient player** that playbacks a summer evening sound and also a **wind player** that plays a gentle wind effect.

The AudioStreamRandomizer has been used to select random audio clips in case there are a lot of them.

#### Particle Systems
For this lab 3 particle systems have been implemented
1. Camfire particle system
2. Falling leafs particle system
3. Dust particle system

The **Falling leafs** is placed on the big tree of the scene, the **Dust particles** are placed on the barrel during the destruction and also during the rock moving.

#### Screenshots
The general enviroment with the volumetric fog and the leaf falling

![General Enviroment](/image1.png "Screenshot of the general enviroment")

The dust particles of the rocks

![Dust Particles](/image2.png "Dust particles of the moving rocks"")

#### Resource List 
* Poly Haven
    * [Boombox](https://polyhaven.com/a/boombox)
    * [Boulder 01](https://polyhaven.com/a/boulder_01)
    * [Camera 01](https://polyhaven.com/a/Camera_01)
    * [Chess Set](https://polyhaven.com/a/chess_set)
    * [Jacaranda Tree](https://polyhaven.com/a/jacaranda_tree)
    * [Searsia Lucida](https://polyhaven.com/a/searsia_lucida) (*Multiple Models*)
    * [Street Lamp 01](https://polyhaven.com/a/street_lamp_01)
    * [Tree Small 02](https://polyhaven.com/a/tree_small_02)
    * [Utility Box 02](https://polyhaven.com/a/utility_box_02)
    * [Wooden Picnic Table](https://polyhaven.com/a/wooden_picnic_table)
    * [Wooden Barrels 01](https://polyhaven.com/a/wooden_barrels_01)
    * [Dry Branches Medium 01](https://polyhaven.com/a/dry_branches_medium_01)
    * [Dead Tree Trunk](https://polyhaven.com/a/dead_tree_trunk)
    * [Dead Tree Trunk 02](https://polyhaven.com/a/dead_tree_trunk_02)
* Sketchfab
    * [Old Bottle](https://sketchfab.com/3d-models/old-bottle-ee25aa51679042609dd3295fdeb99a65)
* CGTrader
    * [Zippo style gasoline lighter](https://www.cgtrader.com/items/4460252/download-page)
* StickPNG
    * [Smoke Particle](https://www.stickpng.com/img/nature/smoke/grey-smoke-cloud)
* Sounds Used
    * [Footsteps](https://pixabay.com/sound-effects/footsteps-dirt-gravel-6823/)
    * [Running](https://pixabay.com/sound-effects/running-on-gravel-301880/)
    * [Pickup / Drop Item](https://pixabay.com/sound-effects/pickup-item-64282/)
    * [Lighter sound](https://pixabay.com/sound-effects/zippo-lighter-open-light-close-102817/)
    * [Oil sound](https://pixabay.com/sound-effects/pouring-liquid-into-the-liquid-102174/)
    * [Fire sound](https://pixabay.com/sound-effects/fire-forest-2-377740/)
    * [RocksMoving](https://pixabay.com/sound-effects/dropping-rocks-5996/)
    * [Ambiend](https://pixabay.com/sound-effects/summer-insects-243572/)
    * [Wind](https://pixabay.com/sound-effects/a-gentle-breeze-wind-3-7009/)
* Fonts Used
    * [Sign Ron Font](https://www.1001freefonts.com/sign-ron.font)

##### The fire effect and fire assets are from this [tutorial](https://www.youtube.com/watch?v=R3xMwfrlTI8&t=847s)
