Shader "Huda/Phong lighting"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Magic("Magic number", Float) = 1.00
    }
        SubShader
    {
        Tags { "RenderType" = "Opaque" }

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
                float3 normal : NORMAL;
                float3 tangent : TANGENT;
            };

            //Passes on data from the vert shader to the frag shader.
            struct TheBridge
            {
                //Vertex position in the clip space, stored in a float4 "vertex" variable.
                float4 vertex : SV_POSITION;
                float4 uv : TEXCOORD0;
                float3 normal : NORMAL;
                float3 tangent : TANGENT;
                float3 bitangent : TEXCOORD1;
                float magic : TEXCOORD2;
            };

            float _Magic;
            float _NormalTex_ST;

            //THE VERTEX SHADER
            TheBridge vert(MeshData md)
            {
                TheBridge tb;
                //Convert the vertices from object's local space to the clip space,
                 //so that the mesh data can be rendered according to the object's shape
                 //in relation to clip space.
                tb.vertex = UnityObjectToClipPos(md.vertex);
                //tb.uv = TRANSFORM_TEX(md.uv, _NormalTex);
                tb.uv = md.uv;


                tb.normal = mul(md.normal, unity_WorldToObject);
                tb.tangent = mul(md.tangent, unity_WorldToObject);
                tb.bitangent = cross(tb.tangent, tb.normal);


                tb.magic = _Magic;

                //This information will be passed on to the fragment automatically.
                return tb;
            }

            float4 frag(TheBridge tb) : SV_Target //the fragment shader will output to the frame buffer "SV_Target"
            {
               float3 n = normalize(tb.normal);
               //n = (n + 1) * tb.magic;
               //float4 color = float4(n, 1);
               
               float4 color = saturate(dot(n, _WorldSpaceLightPos0));
               //color.r *= tb.tangent;
               //color.g *= tb.bitangent;
               //color.b *= tb.normal;
               return color;
            }
    ENDCG
}
    }
}
