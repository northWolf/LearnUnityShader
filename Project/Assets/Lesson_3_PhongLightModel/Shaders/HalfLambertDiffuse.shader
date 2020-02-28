﻿Shader "Learn/HalfLambertDiffuse"
{
    Properties
    {
       _Diffuse("Diffuse",Color) = (1,1,1,1)
    }
    
    SubShader
    {
       

        Pass
        {
            Tags {"LightMode" = "ForwardBase"}
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
           
            fixed4 _Diffuse;
            
            struct a2v
            {
                float4 vertex:POSITION;
                float4 normal:NORMAL;
            };
            
            struct v2f
            {
                float4 pos:SV_POSITION;
                float3 worldNormal:TEXCOORD0;
            };
            
            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                
                fixed3 worldNormal = mul(v.normal,(float3x3) unity_WorldToObject);
                o.worldNormal = worldNormal;
                
                return o;
            }
            
            fixed4 frag(v2f i):SV_Target
            {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 halfLambert = dot(worldNormal,worldLight) * 0.5 + 0.5;
                fixed3 diffuse = unity_LightColor[0].rgb * _Diffuse.rgb * halfLambert;
                
                fixed3 color = ambient + diffuse;
                return fixed4(color,1.0);
                
            }
            ENDCG
        }
    }
}
