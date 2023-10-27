SELECT DISTINCT 
       A.ResourceID
     , A.Name0 AS [Computer Name]
     , S.CompanyName
     , S.ProductName
     , F.FileName
     , F.FileVersion
     , F.FilePath
FROM CM_IFR.dbo.V_R_System AS A
INNER JOIN CM_IFR.dbo.v_GS_SoftwareProduct AS S ON S.ResourceID = A.ResourceID
INNER JOIN CM_IFR.dbo.v_GS_SoftwareFile AS F ON F.ResourceID = S.ResourceID AND F.ProductId = S.ProductID