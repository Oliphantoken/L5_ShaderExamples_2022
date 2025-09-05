Shader "Huda/MagicDoor/Toon Image Effect"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
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

            float4 ToonShading(float4 colour) {
                float threshold;
            }

            v2f vert(appdata v)
            {
                v2f output;
                output.vertex = UnityObjectToClipPos(v.vertex);
                output.worldNormal = UnityObjectToWorldNormal(v.normal);
                output.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return output;
            }

            fixed4 frag(v2f input) : SV_Target
            {
                float3 norm = normalize(input.worldNormal);
                float NdotL = dot(_WorldSpaceLightPos0, norm);

                // sample the texture
                fixed4 col = tex2D(_MainTex, input.uv);

                return col * NdotL;
            }
            ENDHLSL
        }
    }
}
