# UMAP plots for key metadata
sc.pl.umap(adata, color='Condition', title='Condition', frameon=False)
sc.pl.umap(adata, color='low_anno', title='Low-level Annotation', frameon=False)
sc.pl.umap(adata, color='sub_anno', title='Detailed Annotation', frameon=False)



##Cell count
# Cell count by Condition + sub_anno
sub_anno_group = (
    adata.obs.groupby(['Condition', 'sub_anno'])
    .size()
    .reset_index(name='Cell Count')
)
print("Cell counts (Condition + sub_anno):")
print(sub_anno_group)
# Cell count by Condition + low_anno
low_anno_group = (
    adata.obs.groupby(['Condition', 'low_anno'])
    .size()
    .reset_index(name='Cell Count')
)
print("Cell counts (Condition + low_anno):")
print(low_anno_group)
# Save to CSV
sub_anno_group.to_csv("cell_counts_by_condition_sub_anno.csv", index=False)
low_anno_group.to_csv("cell_counts_by_condition_low_anno.csv", index=False)




## metadata
# 바코드별 메타데이터 추출
metadata = adata.obs.copy()
metadata.index.name = "Barcode"  # index를 'Barcode'로 명확히
#주요 열만 추려서 저장 (선택적으로 수정 가능)
columns_to_keep = ['Condition', 'sub_anno', 'low_anno']
metadata_subset = metadata[columns_to_keep].reset_index()
# CSV로 저장
metadata_subset.to_csv("single_cell_metadata.csv", index=False)

