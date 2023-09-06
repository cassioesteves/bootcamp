USE [BDProducoes]
GO
/****** Object:  Table [dbo].[Autoria]    Script Date: 24/07/2020 19:36:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Autoria](
	[cod_Autoria] [int] IDENTITY(1,1) NOT NULL,
	[cod_titulo] [int] NOT NULL,
	[cod_pessoa] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Avaliacao]    Script Date: 24/07/2020 19:36:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Avaliacao](
	[cod_titulo] [int] NOT NULL,
	[classificacao_media] [int] NOT NULL,
	[qtd_votos] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Direcao]    Script Date: 24/07/2020 19:36:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direcao](
	[cod_direcao] [int] IDENTITY(1,1) NOT NULL,
	[cod_titulo] [int] NOT NULL,
	[cod_pessoa] [int] NOT NULL,
 CONSTRAINT [PK_Direcao] PRIMARY KEY CLUSTERED 
(
	[cod_direcao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[cod_titulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Elenco]    Script Date: 24/07/2020 19:36:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Elenco](
	[cod_elenco] [int] IDENTITY(1,1) NOT NULL,
	[cod_titulo] [int] NOT NULL,
	[cod_pessoa] [int] NOT NULL,
	[dsc_funcao] [varchar](1000) NOT NULL,
	[desc_personagem] [varchar](1000) NULL,
 CONSTRAINT [PK_Elenco] PRIMARY KEY CLUSTERED 
(
	[cod_elenco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pessoa]    Script Date: 24/07/2020 19:36:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pessoa](
	[cod_pessoa] [int] IDENTITY(1,1) NOT NULL,
	[nom_pessoa] [varchar](500) NOT NULL,
	[ano_nascimento] [int] NULL,
	[ano_falescimento] [int] NULL,
	[dsc_profissao] [varchar](1000) NULL,
 CONSTRAINT [PK_Pessoa] PRIMARY KEY CLUSTERED 
(
	[cod_pessoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Titulo]    Script Date: 24/07/2020 19:36:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Titulo](
	[cod_titulo] [int] NOT NULL,
	[num_titulo] [varchar](1000) NULL,
 CONSTRAINT [PK_Titulo] PRIMARY KEY CLUSTERED 
(
	[cod_titulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Titulo_Detalhe]    Script Date: 24/07/2020 19:36:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Titulo_Detalhe](
	[cod_titulo] [int] NOT NULL,
	[tip_titulo] [varchar](100) NOT NULL,
	[nom_principal_titulo] [varchar](1000) NOT NULL,
	[nom_original_titulo] [varchar](1000) NOT NULL,
	[ind_adulto] [bit] NOT NULL,
	[ano_lancamento] [int] NOT NULL,
	[qtd_minutos] [smallint] NULL,
	[dsc_genero] [varchar](1000) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Autoria]  WITH CHECK ADD  CONSTRAINT [FK_Autoria_Pessoa] FOREIGN KEY([cod_pessoa])
REFERENCES [dbo].[Pessoa] ([cod_pessoa])
GO
ALTER TABLE [dbo].[Autoria] CHECK CONSTRAINT [FK_Autoria_Pessoa]
GO
ALTER TABLE [dbo].[Autoria]  WITH CHECK ADD  CONSTRAINT [FK_Autoria_Titulo] FOREIGN KEY([cod_titulo])
REFERENCES [dbo].[Titulo] ([cod_titulo])
GO
ALTER TABLE [dbo].[Autoria] CHECK CONSTRAINT [FK_Autoria_Titulo]
GO
ALTER TABLE [dbo].[Avaliacao]  WITH CHECK ADD  CONSTRAINT [FK_Avaliacao_Titulo] FOREIGN KEY([cod_titulo])
REFERENCES [dbo].[Titulo] ([cod_titulo])
GO
ALTER TABLE [dbo].[Avaliacao] CHECK CONSTRAINT [FK_Avaliacao_Titulo]
GO
ALTER TABLE [dbo].[Direcao]  WITH CHECK ADD  CONSTRAINT [FK_Direcao_Pessoa] FOREIGN KEY([cod_pessoa])
REFERENCES [dbo].[Pessoa] ([cod_pessoa])
GO
ALTER TABLE [dbo].[Direcao] CHECK CONSTRAINT [FK_Direcao_Pessoa]
GO
ALTER TABLE [dbo].[Direcao]  WITH CHECK ADD  CONSTRAINT [FK_Direcao_Titulo] FOREIGN KEY([cod_titulo])
REFERENCES [dbo].[Titulo] ([cod_titulo])
GO
ALTER TABLE [dbo].[Direcao] CHECK CONSTRAINT [FK_Direcao_Titulo]
GO
ALTER TABLE [dbo].[Elenco]  WITH CHECK ADD  CONSTRAINT [FK_Elenco_Pessoa] FOREIGN KEY([cod_pessoa])
REFERENCES [dbo].[Pessoa] ([cod_pessoa])
GO
ALTER TABLE [dbo].[Elenco] CHECK CONSTRAINT [FK_Elenco_Pessoa]
GO
ALTER TABLE [dbo].[Elenco]  WITH CHECK ADD  CONSTRAINT [FK_Elenco_Titulo] FOREIGN KEY([cod_titulo])
REFERENCES [dbo].[Titulo] ([cod_titulo])
GO
ALTER TABLE [dbo].[Elenco] CHECK CONSTRAINT [FK_Elenco_Titulo]
GO
ALTER TABLE [dbo].[Titulo_Detalhe]  WITH CHECK ADD  CONSTRAINT [FK_Titulo_Detalhe] FOREIGN KEY([cod_titulo])
REFERENCES [dbo].[Titulo] ([cod_titulo])
GO
ALTER TABLE [dbo].[Titulo_Detalhe] CHECK CONSTRAINT [FK_Titulo_Detalhe]
GO
