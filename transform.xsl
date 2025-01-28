<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        
        <!-- Создаем блок для сохранения преобразованных данных -->
        <ORDRSP>
            <!-- Данные о датах и номерах заказа -->
            <NUMBER><xsl:value-of select="/eDIMessage/orderResponse/@number"/></NUMBER>
            <DATE><xsl:value-of select="/eDIMessage/orderResponse/@date"/></DATE>
            <ORDERNUMBER><xsl:value-of select="/eDIMessage/orderResponse/originOrder/@number"/></ORDERNUMBER>
            <ORDERDATE><xsl:value-of select="/eDIMessage/orderResponse/originOrder/@date"/></ORDERDATE>
            <DELIVERYDATE><xsl:value-of select="/eDIMessage/orderResponse/deliveryInfo/estimatedDeliveryDateTime"/></DELIVERYDATE>
            <DELIVERYTIME><xsl:value-of select="substring(/eDIMessage/orderResponse/deliveryInfo/estimatedDeliveryDateTime, 12, 5)" /></DELIVERYTIME>
            <CURRENCY><xsl:value-of select="/eDIMessage/orderResponse/lineItems/currencyISOCode"/></CURRENCY>
            <ACTION>29</ACTION>

            <!-- Данные о покупателе и продавце -->
            <HEAD>
                <BUYER><xsl:value-of select="/eDIMessage/orderResponse/buyer/gln"/></BUYER>
                <SUPPLIER><xsl:value-of select="/eDIMessage/orderResponse/seller/gln"/></SUPPLIER>
                <DELIVERYPLACE><xsl:value-of select="/eDIMessage/orderResponse/deliveryInfo/shipTo/gln"/></DELIVERYPLACE>
                <SENDER><xsl:value-of select="/eDIMessage/interchangeHeader/sender"/></SENDER>
                <RECIPIENT><xsl:value-of select="/eDIMessage/interchangeHeader/recipient"/></RECIPIENT>
                <EDIINTERCHANGEID><xsl:value-of select="/eDIMessage/@id"/></EDIINTERCHANGEID>
                
                <!-- Обрабатываем lineItems -->
                <xsl:for-each select="/eDIMessage/orderResponse/lineItems/lineItem">
                    <POSITION>
                        <!-- Нумерация позиций -->
                        <POSITIONNUMBER><xsl:value-of select="position()"/></POSITIONNUMBER>
                        
                        <!-- Данные о продукте -->
                        <PRODUCT><xsl:value-of select="gtin"/></PRODUCT>
                        <PRODUCTIDBUYER><xsl:value-of select="internalBuyerCode"/></PRODUCTIDBUYER>
                        <PRODUCTIDSUPPLIER><xsl:value-of select="internalSupplierCode"/></PRODUCTIDSUPPLIER>
                        <DESCRIPTION><xsl:value-of select="description"/></DESCRIPTION>
                        <ORDEREDQUANTITY><xsl:value-of select="orderedQuantity"/></ORDEREDQUANTITY>
                        <ACCEPTEDQUANTITY><xsl:value-of select="confirmedQuantity"/></ACCEPTEDQUANTITY>
                        <PRICE><xsl:value-of select="netPrice"/></PRICE>
                        <PRICEWITHVAT><xsl:value-of select="netPriceWithVAT"/></PRICEWITHVAT>
                        <VAT><xsl:value-of select="vATRate"/></VAT>
                    </POSITION>
                </xsl:for-each>  
            </HEAD>
        </ORDRSP>
    </xsl:template>
</xsl:stylesheet>