Shader "Huda/Colours"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct MeshData
            {
                //vertex position provided by the mesh, stored in float4 "vertex" variable
                float4 vertex : POSITION;
                float4 uv : TEXCOORD0;
            };

            //Passes on data from the vert shader to the frag shader.
            struct TheBridge
            {
                //Vertex position in the clip space (the viewport), stored in a float4 "vertex" variable.
                float4 vertex : SV_POSITION;
                float4 uv : TEXCOORD0;
            };

            //THE VERTEX SHADER
            TheBridge vert (MeshData md)
            {
                TheBridge tb;
                //Convert the vertices from object's local space to the clip space,
                //so that the mesh data can be rendered according to the object's shape
                //in relation to clip space.
                tb.vertex = UnityObjectToClipPos(md.vertex);

                tb.uv = md.uv;

                //This information will be passed on to the fragment automatically.
                return tb;
            }

            float4 frag(TheBridge tb) : SV_Target //the fragment shader will output to the frame buffer "SV_Target"
            {
                //color outputted as RGB with values that are up to you
               float4 color = float4(tb.uv.y*0.9, tb.uv.y, 0, 1);
               return color;
            }
            ENDCG
        }
    }
}
