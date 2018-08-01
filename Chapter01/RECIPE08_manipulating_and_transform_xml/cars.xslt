<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="cars">
    <html>
      <head>
				<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet"/>				
        <title>
          Sport Cars
        </title>
      </head>
      <body>				
			  <div class="container">
				<div class="row">
				<h1>Sport Cars</h1>
        <table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>Model</th>
							<th>Manufacturer</th>
							<th class="text-right">Price</th>
						</tr>
					</thead>
					<tbody>
          <xsl:for-each select="car">
						<tr>
							<td>
								<xsl:value-of select="name"/>
							</td>
							<td>
								<xsl:value-of select="manufacturer"/>
							</td>
							<td class="text-right">					
								<span class="glyphicon glyphicon-euro"></span>  								
								<xsl:value-of select="price"/>
							</td>
						</tr>
          </xsl:for-each>
					</tbody>
        </table>
				</div>
				</div>				
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>