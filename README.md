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
	[x] Use *`CharacterBody2D`* and `move_and_slide()`.
[x] Bubble shooting
	[x] Player can shoot a bubble in the facing direction
	[x] Bubble travels horizontally, then floats upward
	[x] Bubble has a lifetime (despawns eventually)
[ ] Enemies
	[x] Spawn 3–6 enemies in the level
	[x] Enemies patrol platforms (simple AI: move left/right and turn at walls/edges)
	[ ] Enemy damages player on contact (lose health or life)
[x] Trapping mechanic
	[x] If a bubble overlaps an enemy, the enemy becomes *trapped*
	[x] Trapped enemy stops acting and becomes attached to the bubble (or replaced by a “trapped bubble”)
	[x] Bubble now floats (or continues floating) with trapped enemy inside
[ ] Popping + scoring + game loop
	[x] Player can pop trapped bubbles by touching them (or pressing an action near them)
	[ ] On pop:
		[x] trapped enemy is destroyed
		[ ] player gains points
	[ ] HUD shows *score* and *lives/health*
	[ ] When player loses all lives/health → Game Over screen with restart
