// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SirCondoms/Eye Shader 2.0"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (1,1,1,0)
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Float1("Float 1", Float) = 0
		_Float0("Float 0", Float) = -0.01
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float4 _Color0;
		uniform sampler2D _TextureSample1;
		uniform sampler2D _TextureSample0;
		uniform float _Float1;
		uniform float4 _TextureSample0_ST;
		uniform float _Float0;


		float2 voronoihash119( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi119( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash119( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			
			 		}
			 	}
			}
			return F1;
		}


		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float4 tex2DNode50 = tex2D( _TextureSample1, i.uv_texcoord );
			float4 blendOpSrc77 = tex2DNode50;
			float4 blendOpDest77 = tex2D( _TextureSample0, i.uv_texcoord );
			float4 Eyespinning58 = (tex2DNode50 + (float4( 0,0,0,0 ) - ( ( saturate( ( 1.0 - ( ( 1.0 - blendOpDest77) / max( blendOpSrc77, 0.00001) ) ) )) + float4( 0,0,0,0 ) )) * (float4( 1,1,1,1 ) - tex2DNode50) / (float4( 1,1,1,1 ) - ( ( saturate( ( 1.0 - ( ( 1.0 - blendOpDest77) / max( blendOpSrc77, 0.00001) ) ) )) + float4( 0,0,0,0 ) )));
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3 ase_vertexBitangent = mul( unity_WorldToObject, float4( ase_worldBitangent, 0 ) );
			ase_vertexBitangent = normalize( ase_vertexBitangent );
			float temp_output_88_0 = distance( ( Eyespinning58 * float4( ase_vertexBitangent , 0.0 ) ) , float4( 0,0,0,0 ) );
			float2 temp_cast_2 = (temp_output_88_0).xx;
			float2 temp_cast_3 = (ase_vertexBitangent.x).xx;
			float temp_output_2_0_g4 = 0.9;
			float2 appendResult10_g5 = (float2(temp_output_2_0_g4 , temp_output_2_0_g4));
			float2 temp_output_11_0_g5 = ( abs( (frac( (i.uv_texcoord*temp_cast_2 + temp_cast_3) )*2.0 + -1.0) ) - appendResult10_g5 );
			float2 break16_g5 = ( 1.0 - ( temp_output_11_0_g5 / fwidth( temp_output_11_0_g5 ) ) );
			float Stareye95 = ( temp_output_88_0 + saturate( min( break16_g5.x , break16_g5.y ) ) );
			float4 temp_cast_4 = (Stareye95).xxxx;
			float4 temp_cast_5 = (Stareye95).xxxx;
			float4 temp_cast_6 = (Stareye95).xxxx;
			float4 blendOpSrc105 = Eyespinning58;
			float4 blendOpDest105 = temp_cast_6;
			float2 temp_cast_7 = (i.uv_texcoord.x).xx;
			float cos116 = cos( ( i.uv_texcoord.y + _Time.y ) );
			float sin116 = sin( ( i.uv_texcoord.y + _Time.y ) );
			float2 rotator116 = mul( i.uv_texcoord - temp_cast_7 , float2x2( cos116 , -sin116 , sin116 , cos116 )) + temp_cast_7;
			float time119 = rotator116.x;
			float2 voronoiSmoothId119 = 0;
			float2 coords119 = rotator116 * rotator116.x;
			float2 id119 = 0;
			float2 uv119 = 0;
			float voroi119 = voronoi119( coords119, time119, id119, uv119, 0, voronoiSmoothId119 );
			float4 Eye2125 = ( Stareye95 * ( ( saturate( ( blendOpSrc105 + blendOpDest105 - 1.0 ) )) * voroi119 ) );
			float layeredBlendVar134 = Stareye95;
			float4 layeredBlend134 = ( lerp( temp_cast_5,Eye2125 , layeredBlendVar134 ) );
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 Greyeyes152 = ( layeredBlend134 * tex2D( _TextureSample0, uv_TextureSample0 ) );
			float4 blendOpSrc226 = temp_cast_4;
			float4 blendOpDest226 = Greyeyes152;
			float temp_output_1_0_g8 = ( ( ( Eyespinning58 * ( Stareye95 + _Float1 ) ) + float4( 0,0,0,0 ) ) + ( ( saturate( ( 1.0 - ( ( 1.0 - blendOpDest226) / max( blendOpSrc226, 0.00001) ) ) )) + _Float0 ) ).r;
			float3 temp_cast_11 = (( ( abs( ( ( temp_output_1_0_g8 - floor( ( temp_output_1_0_g8 + 0.5 ) ) ) * 2 ) ) * 2 ) - 1.0 )).xxx;
			c.rgb = temp_cast_11;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			o.Emission = _Color0.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting alpha:fade keepalpha fullforwardshadows exclude_path:deferred 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19105
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-3659.2,-152.331;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;44;-3594.289,403.2577;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-1966.101,61.14582;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;50;-3026.54,314.3467;Inherit;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;0;False;0;False;-1;da3eb005388cf774f9ac5304e2334eb9;None;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;77;-2390.442,77.97036;Inherit;False;ColorBurn;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;8;-2971.219,-10.81871;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;da3eb005388cf774f9ac5304e2334eb9;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;76;-2043.253,355.594;Inherit;True;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;3;COLOR;0,0,0,0;False;4;COLOR;1,1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;-1649.667,146.1653;Inherit;False;Eyespinning;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BitangentVertexDataNode;80;-1659.379,370.5512;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-1341.148,176.6868;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DistanceOpNode;88;-1109.665,288.5011;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;94;-972.0293,567.9543;Inherit;False;Grid;-1;;4;a9240ca2be7e49e4f9fa3de380c0dbe9;0;3;5;FLOAT2;8,8;False;6;FLOAT2;0,0;False;2;FLOAT;0.9;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;99;-2773.118,1144.535;Inherit;False;58;Eyespinning;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;100;-2770.002,1340.992;Inherit;False;95;Stareye;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;105;-2453.543,1142.059;Inherit;False;LinearBurn;True;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;117;-2537.587,1378.258;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;118;-2458.955,1750.775;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;120;-2404.366,1452.423;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-1511.726,974.7689;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-1841.397,1127.651;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VoronoiNode;119;-1908.854,1330.275;Inherit;False;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.GetLocalVarNode;124;-1810.127,946.8069;Inherit;False;95;Stareye;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;-1215.864,993.7609;Inherit;False;Eye2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RotatorNode;116;-2193.487,1365.458;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;131;-2487.296,2039.89;Inherit;False;95;Stareye;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-2476.622,2261.937;Inherit;False;125;Eye2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LayeredBlendNode;134;-2130.74,2142.098;Inherit;False;6;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;158;-2027.636,1949.651;Inherit;True;Property;_TextureSample2;Texture Sample 2;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;8;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;159;-1833.836,2156.752;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;152;-1475.049,2141.22;Inherit;False;Greyeyes;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;92;-782.1815,169.6633;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-506.0075,174.8077;Inherit;False;Stareye;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;167;-2462.969,-963.7253;Inherit;False;58;Eyespinning;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;178;-2455.041,-790.0617;Inherit;False;152;Greyeyes;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;189;-2472.721,-585.0589;Inherit;False;95;Stareye;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;186;-2114.99,-816.9024;Inherit;False;HardMix;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;196;-1741.25,-740.4474;Inherit;False;Actualeye;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;217;291.3267,-375.6569;Inherit;False;58;Eyespinning;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;210;193.6214,86.93878;Inherit;False;58;Eyespinning;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;218;339.1563,230.6764;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;212;153.5701,317.083;Inherit;False;Property;_Float1;Float 1;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;164.3721,221.312;Inherit;False;95;Stareye;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;188.9225,158.9782;Inherit;False;196;Actualeye;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;219;393.6035,38.88344;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;220;283.7618,295.0574;Inherit;True;95;Stareye;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;224;277.624,471.4991;Inherit;True;152;Greyeyes;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;223;567.0526,-7.167591;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;226;465.9803,276.0231;Inherit;False;ColorBurn;True;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;231;599.1138,524.366;Inherit;False;Property;_Float0;Float 0;3;0;Create;True;0;0;0;False;0;False;-0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1091.51,-38.57384;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;SirCondoms/Eye Shader 2.0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;True;0;True;Transparent;;Transparent;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;0;3;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.SimpleAddOpNode;232;670.9107,216.9316;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;236;669.33,84.40729;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;235;876.9528,84.49747;Inherit;False;Triangle Wave;-1;;8;51ec3c8d117f3ec4fa3742c3e00d535b;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;209;644.7425,-51.80887;Inherit;False;Property;_Color0;Color 0;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
WireConnection;57;0;77;0
WireConnection;50;1;44;0
WireConnection;77;0;50;0
WireConnection;77;1;8;0
WireConnection;8;1;1;0
WireConnection;76;1;57;0
WireConnection;76;3;50;0
WireConnection;58;0;76;0
WireConnection;81;0;58;0
WireConnection;81;1;80;0
WireConnection;88;0;81;0
WireConnection;94;5;88;0
WireConnection;94;6;80;1
WireConnection;105;0;99;0
WireConnection;105;1;100;0
WireConnection;120;0;117;2
WireConnection;120;1;118;0
WireConnection;110;0;124;0
WireConnection;110;1;123;0
WireConnection;123;0;105;0
WireConnection;123;1;119;0
WireConnection;119;0;116;0
WireConnection;119;1;116;0
WireConnection;119;2;116;0
WireConnection;125;0;110;0
WireConnection;116;0;117;0
WireConnection;116;1;117;1
WireConnection;116;2;120;0
WireConnection;134;0;131;0
WireConnection;134;1;131;0
WireConnection;134;2;132;0
WireConnection;159;0;134;0
WireConnection;159;1;158;0
WireConnection;152;0;159;0
WireConnection;92;0;88;0
WireConnection;92;1;94;0
WireConnection;95;0;92;0
WireConnection;186;0;167;0
WireConnection;186;1;178;0
WireConnection;186;2;189;0
WireConnection;196;0;186;0
WireConnection;218;0;198;0
WireConnection;218;1;212;0
WireConnection;219;0;210;0
WireConnection;219;1;218;0
WireConnection;223;0;219;0
WireConnection;226;0;220;0
WireConnection;226;1;224;0
WireConnection;0;2;209;0
WireConnection;0;13;235;0
WireConnection;232;0;226;0
WireConnection;232;1;231;0
WireConnection;236;0;223;0
WireConnection;236;1;232;0
WireConnection;235;1;236;0
ASEEND*/
//CHKSM=5C630B00E48CCD67CC259CB92C4C9C16B4FBB515