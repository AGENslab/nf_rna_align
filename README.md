# Pipeline de alineación de RNA-seq

Este pipeline automatiza las etapas de **preprocesamiento**, **alineamiento** y **cuantificación** de lecturas provenientes de experimentos de **RNA-seq**.  
Está desarrollado en **Nextflow** y permite ejecutar de forma reproducible todo el flujo de análisis utilizando un contenedor con **BWA**.

---

## Descripción general

El pipeline recibe como entrada:

- Archivos **FASTQ** que contienen las secuencias de lectura.  
- Un archivo **FASTA** correspondiente al **genoma de referencia**.

El flujo de trabajo produce como salida:

- Archivos **BAM** generados tras el alineamiento.  
- Tres carpetas de resultados:
  - Una con los datos **trimming** (lecturas filtradas).  
  - Dos carpetas con los reportes de **control de calidad** de las lecturas, correspondientes al análisis **antes** y **después** del trimming.

---

## Etapas del pipeline

### 1. Preprocesamiento
- **BWA index**: genera los archivos de indexación necesarios del genoma de referencia.  
- **FastQC**: realiza el control de calidad inicial de las lecturas crudas.

### 2. Trimming
- Elimina adaptadores y lecturas de baja calidad, generando las secuencias filtradas para alineamiento.

### 3. Alineamiento
- **BWA MEM**: ejecuta el alineamiento de las lecturas contra el genoma de referencia indexado.  
- Los resultados se almacenan en formato **BAM**.

---

## Requerimientos

- **Nextflow** (última versión, instalado localmente o en un entorno de ejecución).  
- Contenedor con **BWA** (última versión disponible).

---

## Estructura del proyecto
```
.
├── containers
│ └── bwa.sif
├── data
│ ├── reference
├── main.nf
├── modules
│ ├── fastqc.nf
│ ├── htseq.nf
│ ├── index.nf
│ ├── mem.nf
│ └── triming.nf
├── nextflow.config
├── params.csv
├── params.yml
├── results
└── workflows
├── aligment.nf
├── get_counts.nf
├── preprocessing.nf
└── p_trimming.nf

```
---

## Ejecución

El pipeline se ejecuta con el siguiente comando:

```bash
nextflow run main.nf -config nextflow.config -profile kutral -params-file params.yml
```

## Estructura del archivo `params.csv`

El archivo `params.csv` define las muestras que serán procesadas por el pipeline de alineación de RNA-seq.  
Este archivo es esencial para la ejecución, ya que especifica las rutas de los archivos FASTQ de entrada y los identificadores únicos de cada muestra.

---

## Formato general

El archivo debe tener **tres columnas** obligatorias, separadas por comas (`,`) y sin espacios adicionales:

| Columna | Descripción |
|----------|--------------|
| **ID** | Identificador único de la muestra (por ejemplo, el número de acceso SRA o un nombre de muestra definido por el usuario). |
| **forward** | Ruta completa al archivo FASTQ correspondiente a las lecturas del extremo **forward (R1)**. |
| **reverse** | Ruta completa al archivo FASTQ correspondiente a las lecturas del extremo **reverse (R2)**. |

---

## Ejemplo de archivo `params.csv`

```csv
ID,forward,reverse
SRR1424731,/data/all/SRR1424731_1.fastq,/data/all/SRR1424731_2.fastq
SRR1424738,/data/all/SRR1424738_1.fastq,/data/all/SRR1424738_2.fastq
SRR1424739,/data/all/SRR1424739_1.fastq,/data/all/SRR1424739_2.fastq
SRR1424741,/data/all/SRR1424741_1.fastq,/data/all/SRR1424741_2.fastq
SRR1424745,/data/all/SRR1424745_1.fastq,/data/all/SRR1424745_2.fastq
```

## Salidas principales

- results/
Carpeta raíz donde se almacenan todos los resultados del pipeline.

- results/bam/
Archivos BAM con las lecturas alineadas al genoma de referencia.

- results/trimmed/
Lecturas filtradas tras el proceso de trimming.

- results/fastqc_before/ y results/fastqc_after/
Reportes de control de calidad generados por FastQC antes y después del trimming.
