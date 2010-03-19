//
//  Shader.fsh
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

varying lowp vec2 v_texCoord;

uniform sampler2D s_texture;
void main()
{
		gl_FragColor = texture2D(s_texture, v_texCoord);
}
