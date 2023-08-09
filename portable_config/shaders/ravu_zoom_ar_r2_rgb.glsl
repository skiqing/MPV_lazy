// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

//!DESC RAVU-Zoom-AR (rgb, r2, compute)
//!HOOK MAIN
//!BIND HOOKED
//!BIND ravu_zoom_lut2
//!BIND ravu_zoom_lut2_ar
//!WIDTH OUTPUT.w
//!HEIGHT OUTPUT.h
//!OFFSET ALIGN
//!WHEN HOOKED.w OUTPUT.w < HOOKED.h OUTPUT.h < *
//!COMPUTE 32 8
const vec3 color_primary = vec3(0.2126, 0.7152, 0.0722);
#define LUTPOS(x, lut_size) mix(0.5 / (lut_size), 1.0 - 0.5 / (lut_size), (x))
shared vec3 samples[432];
void hook() {
ivec2 group_begin = ivec2(gl_WorkGroupID) * ivec2(gl_WorkGroupSize);
ivec2 group_end = group_begin + ivec2(gl_WorkGroupSize) - ivec2(1);
ivec2 rectl = ivec2(floor(HOOKED_size * HOOKED_map(group_begin) - 0.5)) - 1;
ivec2 rectr = ivec2(floor(HOOKED_size * HOOKED_map(group_end) - 0.5)) + 2;
ivec2 rect = rectr - rectl + 1;
for (int id = int(gl_LocalInvocationIndex); id < rect.x * rect.y; id += int(gl_WorkGroupSize.x * gl_WorkGroupSize.y)) {
int y = id / rect.x, x = id % rect.x;
samples[x + y * 36] = HOOKED_tex(HOOKED_pt * (vec2(rectl + ivec2(x, y)) + vec2(0.5,0.5) + HOOKED_off)).xyz;
}
groupMemoryBarrier();
barrier();
vec2 pos = HOOKED_size * HOOKED_map(ivec2(gl_GlobalInvocationID));
vec2 subpix = fract(pos - 0.5);
pos -= subpix;
subpix = LUTPOS(subpix, vec2(9.0));
vec2 subpix_inv = 1.0 - subpix;
subpix /= vec2(2.0, 288.0);
subpix_inv /= vec2(2.0, 288.0);
ivec2 ipos = ivec2(floor(pos)) - rectl;
int lpos = ipos.x + ipos.y * 36;
vec3 sample0 = samples[-37 + lpos];
float luma0 = dot(sample0, color_primary);
vec3 sample1 = samples[-1 + lpos];
float luma1 = dot(sample1, color_primary);
vec3 sample2 = samples[35 + lpos];
float luma2 = dot(sample2, color_primary);
vec3 sample3 = samples[71 + lpos];
float luma3 = dot(sample3, color_primary);
vec3 sample4 = samples[-36 + lpos];
float luma4 = dot(sample4, color_primary);
vec3 sample5 = samples[0 + lpos];
float luma5 = dot(sample5, color_primary);
vec3 sample6 = samples[36 + lpos];
float luma6 = dot(sample6, color_primary);
vec3 sample7 = samples[72 + lpos];
float luma7 = dot(sample7, color_primary);
vec3 sample8 = samples[-35 + lpos];
float luma8 = dot(sample8, color_primary);
vec3 sample9 = samples[1 + lpos];
float luma9 = dot(sample9, color_primary);
vec3 sample10 = samples[37 + lpos];
float luma10 = dot(sample10, color_primary);
vec3 sample11 = samples[73 + lpos];
float luma11 = dot(sample11, color_primary);
vec3 sample12 = samples[-34 + lpos];
float luma12 = dot(sample12, color_primary);
vec3 sample13 = samples[2 + lpos];
float luma13 = dot(sample13, color_primary);
vec3 sample14 = samples[38 + lpos];
float luma14 = dot(sample14, color_primary);
vec3 sample15 = samples[74 + lpos];
float luma15 = dot(sample15, color_primary);
vec3 abd = vec3(0.0);
float gx, gy;
gx = (luma4-luma0);
gy = (luma1-luma0);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (luma5-luma1);
gy = (luma2-luma0)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (luma6-luma2);
gy = (luma3-luma1)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (luma7-luma3);
gy = (luma3-luma2);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (luma8-luma0)/2.0;
gy = (luma5-luma4);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (luma9-luma1)/2.0;
gy = (luma6-luma4)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (luma10-luma2)/2.0;
gy = (luma7-luma5)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (luma11-luma3)/2.0;
gy = (luma7-luma6);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (luma12-luma4)/2.0;
gy = (luma9-luma8);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (luma13-luma5)/2.0;
gy = (luma10-luma8)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (luma14-luma6)/2.0;
gy = (luma11-luma9)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (luma15-luma7)/2.0;
gy = (luma11-luma10);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (luma12-luma8);
gy = (luma13-luma12);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (luma13-luma9);
gy = (luma14-luma12)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (luma14-luma10);
gy = (luma15-luma13)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (luma15-luma11);
gy = (luma15-luma14);
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
float a = abd.x, b = abd.y, d = abd.z;
float T = a + d, D = a * d - b * b;
float delta = sqrt(max(T * T / 4.0 - D, 0.0));
float L1 = T / 2.0 + delta, L2 = T / 2.0 - delta;
float sqrtL1 = sqrt(L1), sqrtL2 = sqrt(L2);
float theta = mix(mod(atan(L1 - a, b) + 3.141592653589793, 3.141592653589793), 0.0, abs(b) < 1.192092896e-7);
float lambda = sqrtL1;
float mu = mix((sqrtL1 - sqrtL2) / (sqrtL1 + sqrtL2), 0.0, sqrtL1 + sqrtL2 < 1.192092896e-7);
float angle = floor(theta * 24.0 / 3.141592653589793);
float strength = mix(mix(0.0, 1.0, lambda >= 0.004), mix(2.0, 3.0, lambda >= 0.05), lambda >= 0.016);
float coherence = mix(mix(0.0, 1.0, mu >= 0.25), 2.0, mu >= 0.5);
float coord_y = ((angle * 4.0 + strength) * 3.0 + coherence) / 288.0;
vec3 res = vec3(0.0);
vec4 w;
mat4x3 cg, cg1;
vec3 lo = vec3(0.0), hi = vec3(0.0);
vec3 lo2 = vec3(0.0), hi2 = vec3(0.0);
w = texture(ravu_zoom_lut2, vec2(0.0, coord_y) + subpix);
res += sample0 * w[0];
res += sample1 * w[1];
res += sample2 * w[2];
res += sample3 * w[3];
w = texture(ravu_zoom_lut2, vec2(0.5, coord_y) + subpix);
res += sample4 * w[0];
res += sample5 * w[1];
res += sample6 * w[2];
res += sample7 * w[3];
w = texture(ravu_zoom_lut2, vec2(0.0, coord_y) + subpix_inv);
res += sample15 * w[0];
res += sample14 * w[1];
res += sample13 * w[2];
res += sample12 * w[3];
w = texture(ravu_zoom_lut2, vec2(0.5, coord_y) + subpix_inv);
res += sample11 * w[0];
res += sample10 * w[1];
res += sample9 * w[2];
res += sample8 * w[3];
w = texture(ravu_zoom_lut2_ar, vec2(0.0, coord_y) + subpix);
cg = mat4x3(1.0 + sample0, 2.0 - sample0, 1.0 + sample1, 2.0 - sample1);
cg1 = cg;
cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);
hi += cg[0] * w[0] + cg[2] * w[1];
lo += cg[1] * w[0] + cg[3] * w[1];
cg = matrixCompMult(cg, cg1);
hi2 += cg[0] * w[0] + cg[2] * w[1];
lo2 += cg[1] * w[0] + cg[3] * w[1];
cg = mat4x3(1.0 + sample2, 2.0 - sample2, 1.0 + sample3, 2.0 - sample3);
cg1 = cg;
cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);
hi += cg[0] * w[2] + cg[2] * w[3];
lo += cg[1] * w[2] + cg[3] * w[3];
cg = matrixCompMult(cg, cg1);
hi2 += cg[0] * w[2] + cg[2] * w[3];
lo2 += cg[1] * w[2] + cg[3] * w[3];
w = texture(ravu_zoom_lut2_ar, vec2(0.5, coord_y) + subpix);
cg = mat4x3(1.0 + sample4, 2.0 - sample4, 1.0 + sample5, 2.0 - sample5);
cg1 = cg;
cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);
hi += cg[0] * w[0] + cg[2] * w[1];
lo += cg[1] * w[0] + cg[3] * w[1];
cg = matrixCompMult(cg, cg1);
hi2 += cg[0] * w[0] + cg[2] * w[1];
lo2 += cg[1] * w[0] + cg[3] * w[1];
cg = mat4x3(1.0 + sample6, 2.0 - sample6, 1.0 + sample7, 2.0 - sample7);
cg1 = cg;
cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);
hi += cg[0] * w[2] + cg[2] * w[3];
lo += cg[1] * w[2] + cg[3] * w[3];
cg = matrixCompMult(cg, cg1);
hi2 += cg[0] * w[2] + cg[2] * w[3];
lo2 += cg[1] * w[2] + cg[3] * w[3];
w = texture(ravu_zoom_lut2_ar, vec2(0.0, coord_y) + subpix_inv);
cg = mat4x3(1.0 + sample15, 2.0 - sample15, 1.0 + sample14, 2.0 - sample14);
cg1 = cg;
cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);
hi += cg[0] * w[0] + cg[2] * w[1];
lo += cg[1] * w[0] + cg[3] * w[1];
cg = matrixCompMult(cg, cg1);
hi2 += cg[0] * w[0] + cg[2] * w[1];
lo2 += cg[1] * w[0] + cg[3] * w[1];
cg = mat4x3(1.0 + sample13, 2.0 - sample13, 1.0 + sample12, 2.0 - sample12);
cg1 = cg;
cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);
hi += cg[0] * w[2] + cg[2] * w[3];
lo += cg[1] * w[2] + cg[3] * w[3];
cg = matrixCompMult(cg, cg1);
hi2 += cg[0] * w[2] + cg[2] * w[3];
lo2 += cg[1] * w[2] + cg[3] * w[3];
w = texture(ravu_zoom_lut2_ar, vec2(0.5, coord_y) + subpix_inv);
cg = mat4x3(1.0 + sample11, 2.0 - sample11, 1.0 + sample10, 2.0 - sample10);
cg1 = cg;
cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);
hi += cg[0] * w[0] + cg[2] * w[1];
lo += cg[1] * w[0] + cg[3] * w[1];
cg = matrixCompMult(cg, cg1);
hi2 += cg[0] * w[0] + cg[2] * w[1];
lo2 += cg[1] * w[0] + cg[3] * w[1];
cg = mat4x3(1.0 + sample9, 2.0 - sample9, 1.0 + sample8, 2.0 - sample8);
cg1 = cg;
cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);cg = matrixCompMult(cg, cg);
hi += cg[0] * w[2] + cg[2] * w[3];
lo += cg[1] * w[2] + cg[3] * w[3];
cg = matrixCompMult(cg, cg1);
hi2 += cg[0] * w[2] + cg[2] * w[3];
lo2 += cg[1] * w[2] + cg[3] * w[3];
hi = hi2 / hi - 1.0;
lo = 2.0 - lo2 / lo;
res = mix(res, clamp(res, lo, hi), 0.800000);
imageStore(out_image, ivec2(gl_GlobalInvocationID), vec4(res, 1.0));
}
//!TEXTURE ravu_zoom_lut2
//!SIZE 18 2592
//!FORMAT rgba16f
//!FILTER LINEAR
//!TEXTURE ravu_zoom_lut2_ar
//!SIZE 18 2592
//!FORMAT rgba16f
//!FILTER LINEAR