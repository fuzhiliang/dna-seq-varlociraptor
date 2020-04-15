rule bcf_index:
    input:
        "{prefix}.bcf",
    output:
        "{prefix}.bcf.csi"
    log:
        "logs/bcf-index/{prefix}.log"
    conda:
        "../envs/bcftools.yaml"
    threads:
        8
    shell:
        "bcftools index --threads {threads} {input} 2> {log}"


rule bam_index:
    input:
        "{prefix}.bam"
    output:
        "{prefix}.bam.bai"
    log:
        "logs/bam-index/{prefix}.log"
    wrapper:
        "0.39.0/bio/samtools/index"


rule tabix_known_variants:
    input:
        "resources/{prefix}"
    output:
        "resources/{prefix}.tbi"
    log:
        "logs/tabix/{prefix}.log"
    params:
        get_tabix_params
    cache: True
    wrapper:
        "0.45.1/bio/tabix"
