#version 300 es
precision highp float;

// inputs
in vec2 v_texcoord;
uniform sampler2D tex;

// outputs
out vec4 fragColor;

const float temperature = 1000.0;
const float temperatureStrength = 1.0;

#define WithQuickAndDirtyLuminancePreservation
const float LuminancePreservationFactor = 1.0;

// color-temperature conversion (1000–40000K)
vec3 colorTemperatureToRGB(const in float temp) {
    mat3 m = (temp <= 6500.0)
        ? mat3(
            vec3(0.0, -2902.1955373783176, -8257.7997278925690),
            vec3(0.0,  1669.5803561666639,  2575.2827530017594),
            vec3(1.0,   1.3302673723350029,  1.8993753891711275)
          )
        : mat3(
            vec3(1745.0425298314172, 1216.6168361476490, -8257.7997278925690),
            vec3(-2666.3474220535695,-2173.1012343082230,  2575.2827530017594),
            vec3(0.5599538913993148, 0.7038120314055455,   1.8993753891711275)
          );
    vec3 rgb = clamp(
        vec3(m[0] / (vec3(clamp(temp,1000.0,40000.0)) + m[1]) + m[2]),
        vec3(0.0), vec3(1.0)
    );
    return mix(rgb, vec3(1.0), smoothstep(1000.0, 0.0, temp));
}

void main() {
    vec4 pix = texture(tex, v_texcoord);
    vec3 color = pix.rgb;

    #ifdef WithQuickAndDirtyLuminancePreservation
        float lum = dot(color, vec3(0.2126,0.7152,0.0722));
        color *= mix(1.0, lum/max(lum,1e-5), LuminancePreservationFactor);
    #endif

    color = mix(color, color * colorTemperatureToRGB(temperature), temperatureStrength);
    fragColor = vec4(color, pix.a);
}
