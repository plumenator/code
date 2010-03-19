// Modify the following constants to change sprite count, type and OpenGL version.

enum SPRITE_TYPE 
{
	Circles,
	Images,
	ImagesWithAlpha
};


#define SPRITE_COUNT 320 // Number of sprites
#define ES2 1 // Set to zero to use ES1 OR 1 to use ES2
#define SpriteType Circles // Circles or Images or ImagesWithAlpha