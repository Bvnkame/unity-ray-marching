﻿/******************************************************************************/
/*
  Project - Unity Ray Marching
            https://github.com/TheAllenChou/unity-ray-marching

  Author  - Ming-Lun "Allen" Chou
  Web     - http://AllenChou.net
  Twitter - @TheAllenChou

*/
/******************************************************************************/

#ifndef RAY_MARCHING_SDF_DATA
#define RAY_MARCHING_SDF_DATA

#include "Primitives.cginc"

#define kSdfSphere       (0)
#define kSdfBox          (1)
#define kSdfCapsule      (2)
#define kSdfCylinder     (3)

#define kSdfUnion        (0)
#define kSdfSubtraction  (1)
#define kSdfIntersection (3)

struct SdfShape
{
  int4   data0; // type, operator
                // sphere     box        capsule    cylinder
  float4 data1; // c.xyz, r   c.xyz, r   a.xyz, r   a.xyz, r
  float4 data2; // h.xyz      b.xyz      b.xyz
  float4 data3; // q
};

float sdf_shape(float3 p, SdfShape s)
{
  switch (s.data0.x)
  {
    case kSdfSphere:
      return sdf_sphere(p, s.data1.xyz, s.data1.w);

    case kSdfBox:
      return sdf_box(p, s.data1.xyz, s.data2.xyz, s.data3, s.data1.w);

    case kSdfCapsule:
      return sdf_capsule(p, s.data1.xyz, s.data2.xyz, s.data1.w);

    case kSdfCylinder:
      return sdf_cylinder(p, s.data1.xyz, s.data2.xyz, s.data1.w);
  }

  return 1e16f;
}

#endif
