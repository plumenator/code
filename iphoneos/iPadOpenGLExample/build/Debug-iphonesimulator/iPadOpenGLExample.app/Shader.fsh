//
//  Shader.fsh
//  iPadOpenGLExample
//
//  Created by Karthik Ravikanti on 09/02/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
