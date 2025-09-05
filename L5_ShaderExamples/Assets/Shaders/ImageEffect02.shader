Shader "Huda/ImageEffect/Displacement effect"
{
    Properties{
        _MainTex("Texture", 2D) = "white" {}
        _DisTex("Displacement Texture", 2D) = "white" {}
        _Multiplier("Multiplier", Range(0, 1)) = 0
    }
        SubShader
        {
            Tags { "RenderType" = "Opaque" }    //related to the render pipeline

            Pass
            {
                CGPROGRAM                       //the actual shaders
                #pragma vertex vert             //set "vert" as the name of our vertex shader
                #pragma fragment frag           //set "frag" as the name of our fragment shader

                #include "UnityCG.cginc"


                //THE BRIDGE BETWEEN VERT AND FRAG
                struct v2f // Passing on data from vertex shader to fragment shader. Anything used in the frag from vert, must be referenced here
                {
                    float4 vertex : SV_POSITION;    //the clip space position of the vertex
                    float2 uv : TEXCOORD0;          //any data you want. NOTE: TEXCOORD in here doesn't necessarily refer to textures, it's just a default type that can be used for other data as long as it's float of some sort.
                };

                struct MeshData     //This information is always per-vertex data. The Mesh data is passed on automatically.
                {
                    //a variable  :   BUILT-IN MESHDATA IT POINTS TO
                    float4 vertex : POSITION;   //vertex position
                    float2 uv : TEXCOORD0;      //uv texture coordinates
                };

                sampler2D _MainTex;
                sampler2D _DisTex;
                float _Multiplier;

                //THE VERTEX SHADER
                v2f vert(MeshData v)
                {
                    v2f output;
                    output.vertex = UnityObjectToClipPos(v.vertex);  // converts local space to clip space
                    output.uv = v.uv;
                    return output;
                }


                //THE FRAGMENT SHADER
                float4 frag(v2f i) : SV_Target //says that the fragment shader should output to the frame buffer SV_target
                {
                    float2 distuv = float2(i.uv.x + _SinTime.x * 0.1, i.uv.y + _Time.x * 0.2);
                    
                    float2 disTex = tex2D(_DisTex, i.uv / distuv).xy * _Multiplier;

                    float4 color = tex2D(_MainTex, i.uv + disTex);

                    return color;
                }
                ENDCG
            }
        }
}
