Shader "Unlit/Water"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _DispTex ("Displacement Texture", 2D) = "white" {}
        _WaveHeight("Wave Height", Range(-2, 5)) = 0
        _Tint ("Tint Colour", Color) = (1, 1, 1, 1)
        _AnimParams("Animation parameter", Vector) = (0, 0, 0, 0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float4 tint : TEXCOORD1;
            };

            sampler2D _MainTex;
            sampler2D _DispTex;
            float _WaveHeight;
            float4 _MainTex_ST;
            float4 _Tint;
            float4 _AnimParams;

            v2f vert (appdata v)
            {
                v2f o;

                //Create waves
                float vPos = v.uv.x % 0.25; //break up the vertex heights based on UV position as it goes from 0-1
                float invertNum = -1;   //Inverter to make vPos be pending from positive to negative and vice versa, so it doesn't reset to 0.
                if (vPos > 0.249) {
                    invertNum *= -1;
                }

                //TODO: make the waves move to one side without the object leaving its position.
                //Animate the vertex position based on a sine curve, the 
                float animVPosX = 1 + _CosTime.y * invertNum * vPos * _WaveHeight;
                float animVPosY = _SinTime.x * vPos * _WaveHeight;

                v.vertex.x += animVPosX;
                v.vertex.y += animVPosY;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.vertex.x += _Time.y % 2; //translate horizontally based on a sine wave

                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                o.tint = _Tint;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                /*float2 distuv = float2(i.uv.x + _SinTime.x * 0.1, i.uv.y + _Time.x * 0.2);

                    float2 disTex = tex2D(_DisTex, i.uv / distuv).xy * _Multiplier;*/

                //Add displacement texture
                float2 distex = tex2D(_DispTex, i.uv).xy;

                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv + distex) * i.tint;

                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);

                if (col.g > 0.8) {
                    col *= 2;
                }
                return col;
            }
            ENDCG
        }
    }
}
