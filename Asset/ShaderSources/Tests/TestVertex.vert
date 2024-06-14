#version 450 core

#define ALPHA_MODE_OPAQUE 0
#define ALPHA_MODE_MASK 1
#define ALPHA_MODE_BLEND 2

#define MAX_LIGHT_COUNT 20
#define EPSILON 0.1

// Using 48 as it's "16*3"
// The first 16 control points are for the initial u factor and the later 16 point are for the v factor.
#define NUM_CONTROL_POINTS_MAX 48

layout(std140, binding = 0) uniform Camera
{
    mat4 u_ViewProjectionMatrix;
    vec4 u_CameraPosition;
    vec4 u_CameraDirection;
};

layout(std140, binding = 1) uniform Model
{
    mat4 u_ModelMatrix;
    mat4 u_NormalMatrix;
    int u_EntityId;
};

layout(location = 0) in vec3 a_Position;
layout(location = 1) in vec3 a_Normal;
layout(location = 2) in vec2 a_TexCoord;
layout(location = 3) in vec4 a_Color;


layout (location = 0) out vec3 v_Position;
layout (location = 1) out vec3 v_Normal;
layout (location = 2) out vec2 v_TexCoord;
layout (location = 3) out vec4 v_Color;
layout (location = 4) out flat int v_EntityId;

void main() {
    gl_Position = u_ModelMatrix * vec4(a_Position, 1.0);
    v_Position = (u_ModelMatrix * vec4(a_Position, 1.0)).xyz;
    v_Normal = normalize((u_NormalMatrix * vec4(a_Normal, 1.0)).xyz);
//    v_Normal = a_Normal;
    v_TexCoord = a_TexCoord;
    v_Color = a_Color;
    v_EntityId = u_EntityId;
}


