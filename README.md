## CoreValueTrainingGame
## Documentation

### Table of Contents
- [Stack](#stack)
- [Quick Start](#quick-start)
- [How to Edit Scenes](#how-to-edit-scene-files)
- [How to Edit Scripts](#how-to-edit-script-files)
- [Code Style Guide](#code-style-guide)
- [File Structure](#file-structure)


### Stack
This game is built using the [Godot Engine](https://godotengine.org/download/)
Godot uses its own script and has a version where you can use C#.
For the purposes of this game, GDScript is used as most tutorials and guides
are written in this script.

GDScript closely resembles Python in terms of syntax.

### Quick Start
1. Install Godot
2. Clone this repository
3. Locate Main.tscn in src/Main and double click it
4. Press F6 to run these scene

### How to Edit Scene files
1. Select a scene file (.tscn extension)
2. Press F1 to display the scene, scene tree will be displayed on the left
3. Select a node (anything named) on the scene tree and press CTRL + A to add a new node as a child
4. Select a node on the scene and view the Inspector on the right to edit its attributes
    1. Use this to edit label texts, adjust the size of the container, and margins of the conatiner.


#### FAQ
-**I can't move a node in the 2D viewport**
Some GUI nodes like VBoxContainer and HBoxContainer take control of where their children are displayed and Godot won't allow you to move those children manually in the viewport. These nodes act similar to Web Dev components like Flexbox and Grids. Think of them as Flexbox parent containers.

A few things you can do:

1. With a child node selected, you can edit the size flags of it in the Inspector. Default is set to Fill, but you can select Expand so that node will take up any left over space. You can Shrink Center or Shrink End.
    You can adjust the minmum size in Rect and any extra margins in Margin.
2. You can add a node that doesn't have restrictions like VBox, HBox, or Margin such as a plain Control node or ColorRect if you want a background. Any child nodes added here can be moved manually in the 2D viewport.

Something like this:
    MarginContainer
    --ColorRect
    ----VBoxContainer/ Other Nodes


### How to Edit Script files
1. Double click a script file (.gd extension)
2. Press F3 to enter the script editor


### Signals, what are they and how do I use them?
Signals documentation [here]([https://docs.godotengine.org/en/3.2/getting_started/step_by_step/signals.html#signals)


### Code Documentation
Code documenations if found here: https://docs.godotengine.org/en/3.2/

### Code Style Guide
Follow the best practices guide found here: https://docs.godotengine.org/en/latest/getting_started/scripting/gdscript/gdscript_styleguide.html


### File Structure
Keep Scene files and scripts associated with each other in the same folder.
i.e. from the [Docs](https://docs.godotengine.org/en/latest/getting_started/workflow/project_setup/project_organization.html)

    models
        town
            house
                house.fbx
                window.png
                door.png
    characters
        player
            player.fbx
            player.png
        enemies
            goblin
                goblin.fbx
                goblin.png
        npcs
            suzanne
                suzanne.fbx
                suzanne.png
    levels
        riverdale
            riverdale.scn



### Tutorials
List of tutorials collected by Godot here: https://docs.godotengine.org/en/latest/community/tutorials.html



