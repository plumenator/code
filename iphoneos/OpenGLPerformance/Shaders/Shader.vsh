//
//  Shader.vsh
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

uniform mat4 u_mvp_matrix;
uniform vec4 u_translated;

attribute vec4 a_position;
attribute vec2 a_texCoord;

varying vec2 v_texCoord;

void main()
{
	mat4 translated_matrix = u_mvp_matrix;
	translated_matrix[3] += translated_matrix[0]*u_translated.x + translated_matrix[1]*u_translated.y + translated_matrix[2]*u_translated.z;
	gl_Position = translated_matrix * a_position;
	v_texCoord = a_texCoord;
}							
	