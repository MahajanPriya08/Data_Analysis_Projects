SELECT * FROM `housing nashville`.` housing`;
--- changed the data type and update records in date format
update nashhouse set SaleDate= str_to_date(saledate,"%M %d, %Y");
 select * from nashhouse;
 alter table nashhouse modify SaleDate date;
 -- Updated space from column value
 update nashhouse set ParcelId = replace(ParcelID,' ','');
 select ParcelID from nashhouse;
select cast(ParcelID as decimal(12,2)) from nashhouse;
---- splitting the address 
select  PropertyAddress, substring_index(PropertyAddress,',',1)as address from nashhouse;
UPDATE nashhouse 
SET 
    PropertyAddress = SUBSTRING_INDEX(PropertyAddress, ',', 1);
    ---- splitting adress and saving in different column
select OwnerAddress,substring_index(OwnerAddress,',',1) as address,
substring(OwnerAddress,Locate(',',OwnerAddress)+ 1,length(OwnerAddress)) as city from nashhouse;
alter table nashhouse add OwnerState varchar(20);
update nashhouse set OwnerState= substring(OwnerAddress,Locate(',',OwnerAddress)+ 1,length(OwnerAddress));
select OwnerState from nashhouse;
update nashhouse set OwnerAddress=substring_index(OwnerAddress,',',1);
select OwnerAddress from nashhouse;

---- checking for null values
select * from nashhouse where ParcelID Is null ;
select UniqueID from nashhouse where LegalReference is not null;
 -- integrity of field value to Y/N 
select ParcelID,length(SoldAsVacant) from nashhouse where length(SoldAsVacant) between 2 and 3 ;
Select ParcelID,length(SoldAsVacant) from nashhouse where length(SoldAsVacant)= 1 ;
select SoldASVacant,replace(SoldAsVacant,'No','N')as Sold from nashhouse ;
Select SoldAsVacant from nashhouse where SoldAsVacant = 'y';
update nashhouse set SoldAsVacant = replace(SoldAsVacant,'Yes','Y');
update nashhouse set SoldAsVacant = replace(SoldAsVacant,'No','N');
select SoldASVacant,replace(SoldAsVacant,'Y','Yes')as Sold from nashhouse ;
select SoldASVacant from nashhouse;
--- selecting empty column value with self join
 Select NH1.ParcelID as parcel1,NH1.PropertyAddress as PropAdd1,NH2.ParcelID as parcel2,NH2.PropertyAddress as PropAdd2
 from nashhouse NH1,nashhouse NH2
where  NH1.ParcelID = NH2.ParcelID and NH1.UniqueID <> NH2.UniqueID;
---- updating null values with self join
Update nashhouse a JOIN nashhouse b on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID 
SET a.PropertyAddress = ifnull(a.PropertyAddress,b.PropertyAddress)
where a.propertyAddress is null;
select * from nashhouse where PropertyAddress is null;
---- delete duplicate columns
Alter table nashhouse drop column TaxDistrict;
alter table nashhouse drop column solddate;
/* Remove duplicates
--- Row_number() function is not working because of mysql old version
--- select UniqueID,ParcelID,LandUse,PropertyAddress,SaleDate,SalePrice,LegalReference,
---  SoldAsVacant,OwnerName,OwnerAddress ROW_NUMBER() over(partition by ParcelID,PropertyAddress,OwnerName
-- order by UniqueID)as row_number;
-- delete from nashouse where row_number>1;
--- duplicate deletion by creating another table */
create table copy_of_nashhouse as select distinct UniqueId,ParcelID,Landuse,PropertyAddress,SaleDate,SalePrice,
LegalReference,SoldAsvacant,OwnerName,OwnerAddress,Acreage,OwnerState from nashhouse;
select * from copy_of_nashhouse;

