Shader "Huda/BasicLighting"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _AmbColour("Ambient colour", Color) = (0.1, 0.1, 0.1, 1)
        _DiffColour("Tinting colour", Color) = (1, 1, 1, 1)
        _SpecColour("Specular colour", Color) = (1, 1, 1, 1)
        _Shades("Shade amount", Float) = 2
        _Thickness("Thickness", Float) = 1
    }
    SubShader
    {
        Tags { "LightMode" = "ForwardBase" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _AmbColour;
            float4 _DiffColour;
            float4 _SpecColour;
            float _Shades;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : TEXCOORD1;
                float dotProduct : TEXCOORD2;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.normal = v.normal;    //range -1 to 1. You can divide by 2 then add 0.5 to change range to 0-1
                //o.dotProduct = dot(normalize(v.normal), normalize(_WorldSpaceLightPos0));
                
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {

                /*float4 diffuseLight = _DiffColour * i.dotProduct;

                diffuseLight = step(0.2, diffuseLight);
                diffuseLight = floor(diffuseLight * _Shades)/ _Shades;
                
                float4 colour = float4(_AmbColour + diffuseLight);*/
                
                
                //float4 colour = _AmbColour + (_DiffColour * i.dotProduct);
                
                //colour = step(0.1, colour);
                //colour = floor(colour * _Shades) / _Shades;
                //float4 diffuseLight = max(i.dotProduct, 0.0);


                //return colour;




                //Get the dot product between the vertex normal (vec3) and the global lighting position (vec3)
                float3 norm = normalize(i.normal);
                float3 worldLight = normalize(_WorldSpaceLightPos0);
                float dotProduct = dot(norm, worldLight);


                float4 diffuseLight = saturate(_DiffColour * dotProduct);

                diffuseLight = step(0.1, diffuseLight);

                diffuseLight = max(dotProduct * diffuseLight, 0.0);

                diffuseLight = floor(diffuseLight * _Shades) / _Shades;


                float4 ambientLight = float4(0.1, 0.1, 0.1, 1);
                //clamp value between 0-1
                float4 colour = float4(diffuseLight + ambientLight);//clamp(dotProduct, 0, 1);


                    
                return colour;
            }
            ENDCG
        }
            //Outline
            Pass
            {
                Cull Front
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"
                float4 _OutlineColour;
                float _Thickness;


                struct appdata
                {
                    float4 vertex : POSITION;
                    float3 normal : NORMAL;
                };

                struct v2f
                {
                    float4 vertex : SV_POSITION;
                };

                v2f vert(appdata v)
                {
                    v2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex + v.normal * _Thickness * 0.01);
                    return o;
                }

                float4 frag(v2f i) : SV_Target
                {
                   return _OutlineColour;
                }
            ENDCG
        }
    }
}



//Shader "Huda/Lambert"
//{
//	Properties{
//		_Color("Color", Color) = (1.0,1.0,1.0)
//	}
//
//	SubShader{
//		Tags {"LightMode" = "ForwardBase"}
//		Pass{
//
//			CGPROGRAM
//
//			#pragma vertex vert
//			#pragma fragment frag
//
//			// user defined variables
//			uniform float4 _Color;
//
//			// unity defined variables
//			uniform float4 _LightColor0;
//
//			// unity 3 definitions
//			// float4x4 _Object2World;
//			// float4x4 _World2Object;
//			// float4 _WorldSpaceLightPos0;
//
//			// base input structs
//			struct MeshData {
//				float4 vertex: POSITION;
//				float3 normal: NORMAL;
//			};
//
//			struct v2f {
//				float4 pos: SV_POSITION;
//				float4 col: COLOR;
//			};
//
//
//			// vertex functions
//			v2f vert(MeshData v) {
//				v2f o;
//				//Get the vertex normal in 
//				float3 normalDirection = normalize(mul(float4(v.normal, 0.0),unity_WorldToObject).xyz);
//				float3 lightDirection;
//				float atten = 1.0;
//
//				lightDirection = normalize(_WorldSpaceLightPos0.xyz);
//				float3 diffuseReflection = atten * _LightColor0.xyz * _Color.rgb * max(0.0,dot(normalDirection, lightDirection));
//
//				o.col = float4(diffuseReflection, 1.0);
//				o.pos = UnityObjectToClipPos(v.vertex);
//
//				return o;
//			}
//
//	// fragment function
//	float4 frag(v2f i) : COLOR
//	{
//		return i.col;
//	}
//
//
//ENDCG
//}
//
//	}
//}