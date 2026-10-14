# Theme

Identidad visual y personalización del portal vía [ckanext-gobar-theme](https://github.com/datosgobar/ckanext-gobar-theme).

## Perfiles

Un único flag decide la estética base del nodo: `ckanext.gobar_theme.profile`
(`nacional` por defecto, `apn` | `subnacional` | `base`). `nacional` es la
identidad "Datos Abiertos" completa (la de datos.gob.ar); `apn` es la
variante Poncho para organismos de la Administración Pública Nacional.
`subnacional`/`base` hoy se comportan igual que `nacional` (variantes
propias todavía sin diseñar).

```
CKANEXT__GOBAR_THEME__PROFILE=apn
```

## Personalización por nodo

Todo lo demás (colores, imagen de fondo del hero, título/subtítulo de la
home, si se muestra la sección `/recursos`, el nombre de "Organizaciones",
el logo institucional del footer, el link de "Institucional", etc.) se
configura igual, por variables `CKANEXT__GOBAR_THEME__*` — nunca editando
templates para un nodo puntual. La guía completa, con la lista de variables
y ejemplos, vive en el propio repo del theme:
[`docs/personalizacion.md`](https://github.com/datosgobar/ckanext-gobar-theme/blob/main/docs/personalizacion.md).
