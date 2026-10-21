# Theme

Identidad visual y personalización del portal vía [ckanext-gobar-theme](https://github.com/datosgobar/ckanext-gobar-theme).

## Perfiles

El perfil es **obligatorio**: `ckanext.gobar_theme.profile` no tiene default
y, si falta o no es un valor válido, CKAN no arranca (el error lo explica en
el log).

| Perfil | Para quién |
|---|---|
| `datosgobar` | El portal nacional datos.gob.ar: identidad de la Dirección de Datos Abiertos |
| `apn` | Portales de organismos de la Administración Pública Nacional: estética Poncho, con logo, textos, colores y contacto del organismo; sin rastros de la identidad de datos.gob.ar |

```
CKANEXT__GOBAR_THEME__PROFILE=datosgobar
```

> Migración: el valor anterior `nacional` pasa a ser `datosgobar`, y `base` y
> `subnacional` dejan de existir. Hay que actualizar el `.env` de cada
> despliegue (incluido producción) **antes** de levantar la versión del theme
> que trae este cambio.

## Personalización por nodo

Todo lo demás (logo y textos del portal, colores, contacto y "Reportar un
problema", imagen de fondo del hero, título/subtítulo de la home, si se
muestra la sección `/recursos`, el nombre de "Organismos", el logo y el link
institucional del footer, etc.) se configura por `.env`, con las claves
nativas de CKAN (`CKAN__SITE_LOGO`, `CKAN__SITE_DESCRIPTION`,
`CKAN__SITE_ABOUT`) o las `CKANEXT__GOBAR_THEME__*`, nunca editando templates
para un nodo puntual. En `.env.example` está el bloque comentado con todas. La guía completa, con la lista de variables
y ejemplos, vive en el propio repo del theme:
[`docs/personalizacion.md`](https://github.com/datosgobar/ckanext-gobar-theme/blob/main/docs/personalizacion.md).
