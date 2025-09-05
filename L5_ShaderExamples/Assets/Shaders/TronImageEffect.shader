Shader "Huda/MagicDoor/Tron Image Effect"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _TronColour("Tron Colour", Color) = (1,1,1,1)
    }
        SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 100

        Pass
        {
            Tags {
                "LightMode" = "ForwardBase"
                "PassFlags" = "OnlyDirectional"
            }

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float3 worldNormal : NORMAL;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _TronColour;


            v2f vert(appdata v)
            {
                v2f output;
                output.vertex = UnityObjectToClipPos(v.vertex);
                output.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return output;
            }

            fixed4 frag(v2f input) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, input.uv);

            if (col.r == col.g && col.g == col.b) {
                col.rgb += 0.5;
               }

                return col;
            }
            ENDHLSL
        }
    }
}
