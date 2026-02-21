# Bubble Bobble Godot Clone
## Controls

* `Left:` Left arrow key, `a`, and `h`
* `Right:` Right arrow key, `d`, and `l`
* `Jump:` Up arrow key, `w`
* `Fire:` Spacebar
* `Start:` Spacebar and Enter key
* `Restart:` `r`

## Implemented Features
[x] Core movement + world
	[x] `TileMap` platforms with collisions;
		adapted from [here](https://www.reddit.com/r/godot/comments/18tsssj/comment/n7yg4z1/)
	[x] Player
		[x] Left/right movement
		[x] Jump (with gravity)
		[x] Can't walk through walls
	[x] Use `CharacterBody2D` and `move_and_slide()`.
[ ] Bubble shooting
