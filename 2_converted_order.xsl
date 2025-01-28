<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="ORDER">

		<eDIMessage>
			<!-- уникальный номер сообщения (max 36 символов), задается отправителем   -->
			<xsl:attribute name="id"> 
				<xsl:value-of select="/ORDER/HEAD/EDIINTERCHANGEID"/>  
			</xsl:attribute> 
			<xsl:attribute name="creationDateTime"> 
				<xsl:value-of select="/ORDER/DATE"/>  
			</xsl:attribute> 
			<interchangeHeader>
				<sender>
					<xsl:value-of select="/ORDER/HEAD/BUYER"/>
				</sender>
				<recipient>
					<xsl:value-of select="/ORDER/HEAD/RECIPIENT"/>
				</recipient>	
				<documentType>ORDERS</documentType>
			</interchangeHeader>	

			<order>
				<xsl:attribute name="number"> 
					<xsl:value-of select="NUMBER"/> 
				</xsl:attribute> 
				<xsl:attribute name="date"> 
					<xsl:value-of select="DATE"/> 
				</xsl:attribute> 
				<xsl:attribute name="status">Original</xsl:attribute> 

				<xsl:if test="/ORDER/HEAD/BUYERCODE">
					<contractIdentificator>
						<xsl:attribute name="number"> 
							<xsl:value-of select="/ORDER/HEAD/BUYERCODE"/> 
						</xsl:attribute> 
					</contractIdentificator> 
				</xsl:if>

				<xsl:apply-templates select="./HEAD"/>	

			</order>				
		</eDIMessage>
	</xsl:template>



	<xsl:template match="HEAD">
		<xsl:if test="SUPPLIER">
			<seller>
				<gln>
					<xsl:value-of select="SUPPLIER"/>
				</gln>
			</seller>
		</xsl:if>

		<xsl:if test="BUYER">
			<buyer>
				<gln>
					<xsl:value-of select="BUYER"/>
				</gln>
			</buyer>
		</xsl:if>

		<xsl:if test="INVOICEPARTNER">
			<invoicee>
				<gln>
					<xsl:value-of select="INVOICEPARTNER"/>
				</gln>
			</invoicee>
		</xsl:if>

		<deliveryInfo>
			<requestedDeliveryDateTime>
				<xsl:value-of select="/ORDER/DELIVERYDATE"/>
			</requestedDeliveryDateTime>
			<shipTo>
				<gln>
					<xsl:value-of select="DELIVERYPLACE"/>
				</gln>
			</shipTo>
		</deliveryInfo>
		<lineItems>
			<xsl:if test="/ORDER/CURRENCY">
				<currencyISOCode>
					<xsl:value-of select="/ORDER/CURRENCY"/>
				</currencyISOCode>
			</xsl:if>
			<xsl:apply-templates select="./POSITION"/>
		</lineItems>

	</xsl:template>


	<xsl:template match="POSITION">
		<lineItem>  
			<xsl:if test="PRODUCT">
				<gtin>
					<!-- GTIN -->
					<xsl:value-of select="PRODUCT"/>
				</gtin>
			</xsl:if>
			<xsl:if test="CHARACTERISTIC/DESCRIPTION">
				<description>
					<!-- Название товара -->
					<xsl:value-of select="CHARACTERISTIC/DESCRIPTION"/>
				</description>
			</xsl:if>
			<xsl:if test="PRODUCTIDBUYER">
				<internalBuyerCode>
					<!-- Код товара в системе сети-->
					<xsl:value-of select="PRODUCTIDBUYER"/>
				</internalBuyerCode>
			</xsl:if>
			<xsl:if test="PRODUCTIDSUPPLIER">
				<internalSupplierCode>
					<!-- Код товара в системе поставщика -->
					<xsl:value-of select="PRODUCTIDSUPPLIER"/>
				</internalSupplierCode>
			</xsl:if>

			<requestedQuantity>
				<!-- Количество с единицей измерения (PCE - штука, KGM - килограмм) -->
				<xsl:choose>
					<xsl:when test="ORDERUNIT">
						<xsl:attribute name="unitOfMeasure"> 
							<xsl:value-of select="ORDERUNIT"/> 
						</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="unitOfMeasure">PCE</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="ORDEREDQUANTITY"/> 
			</requestedQuantity>

			<lineNumber>
				<xsl:value-of select="POSITIONNUMBER"/>
			</lineNumber>


			<xsl:if test="ORDERPRICE and ORDERPRICE !=''">
				<netPrice>
					<!-- Цена за единицу без НДС -->
					<xsl:value-of select="ORDERPRICE"/>
				</netPrice>
			</xsl:if>
			<xsl:if test="PRICEWITHVAT and PRICEWITHVAT !=''">
				<netPriceWithVAT>
					<!-- Цена за единицу c НДС -->
					<xsl:value-of select="PRICEWITHVAT"/>
				</netPriceWithVAT>
			</xsl:if>

			<xsl:if test="VAT and VAT !=''">
				<vATRate>
					<!-- НДС -->
					<xsl:value-of select="format-number(VAT, '#')"/>
				</vATRate>
			</xsl:if>


		</lineItem>
	</xsl:template>		

</xsl:stylesheet>