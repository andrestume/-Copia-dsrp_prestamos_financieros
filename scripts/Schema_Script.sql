USE [master]
GO
/****** Object:  Database [dsrp_prestamos_financieros]    Script Date: 5/09/2024 20:10:21 ******/
CREATE DATABASE [dsrp_prestamos_financieros]

GO
ALTER DATABASE [dsrp_prestamos_financieros] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dsrp_prestamos_financieros].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET ARITHABORT OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET RECOVERY FULL 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET  MULTI_USER 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dsrp_prestamos_financieros', N'ON'
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET QUERY_STORE = OFF
GO
USE [dsrp_prestamos_financieros]
GO
/****** Object:  Table [dbo].[clientes]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[persona_id] [int] NOT NULL,
	[tipo_cliente] [varchar](100) NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cuotas]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cuotas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[prestamo_id] [int] NOT NULL,
	[numero_cuota] [int] NOT NULL,
	[monto_cuota] [money] NOT NULL,
	[estado] [varchar](55) NOT NULL,
	[fecha_vencimiento] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalles_cuotas_pagos]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalles_cuotas_pagos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cuota_id] [int] NOT NULL,
	[pago_id] [int] NOT NULL,
	[saldo_restante] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[empleados]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[empleados](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[persona_id] [int] NOT NULL,
	[sucursal_id] [int] NOT NULL,
	[supervisor_id] [int] NULL,
	[fecha_ingreso] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[metodos_pago]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[metodos_pago](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](255) NOT NULL,
	[estado] [bit] NOT NULL,
	[descripcion] [varchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pagos]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pagos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[metodo_pago_id] [int] NOT NULL,
	[codigo_operacion] [varchar](20) NOT NULL,
	[monto_pagado] [money] NOT NULL,
	[fecha_pago] [datetime] NOT NULL,
	[created_at] [datetime2](7) NOT NULL,
	[updated_at] [datetime2](7) NULL,
	[deleted_at] [datetime2](7) NULL,
	[created_by] [int] NOT NULL,
	[updated_by] [int] NULL,
	[deleted_by] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personas_juridicas]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personas_juridicas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[numero_documento] [varchar](20) NOT NULL,
	[razon_social] [varchar](255) NOT NULL,
	[domicilio_fiscal] [nvarchar](1000) NOT NULL,
	[telefono] [varchar](15) NOT NULL,
	[email] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[numero_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personas_naturales]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personas_naturales](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[numero_documento] [varchar](15) NOT NULL,
	[nombres] [varchar](255) NOT NULL,
	[apellido_paterno] [varchar](255) NOT NULL,
	[apellido_materno] [varchar](255) NOT NULL,
	[direccion] [nvarchar](1000) NOT NULL,
	[celular] [varchar](15) NOT NULL,
	[email] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[numero_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[prestamos]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prestamos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_id] [int] NOT NULL,
	[sucursal_id] [int] NOT NULL,
	[tipo_prestamo_id] [int] NOT NULL,
	[oficial_credito_id] [int] NOT NULL,
	[estado_prestamo] [varchar](55) NOT NULL,
	[monto] [money] NOT NULL,
	[tasa_interes] [decimal](9, 4) NOT NULL,
	[plazo_meses] [int] NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sucursales]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sucursales](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](255) NOT NULL,
	[telefono] [varchar](20) NOT NULL,
	[direccion] [nvarchar](500) NOT NULL,
	[gerente_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipos_prestamo]    Script Date: 5/09/2024 20:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipos_prestamo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](155) NOT NULL,
	[estado] [bit] NOT NULL,
	[descripcion] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[clientes] ADD  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[cuotas] ADD  DEFAULT (getdate()) FOR [fecha_vencimiento]
GO
ALTER TABLE [dbo].[pagos] ADD  DEFAULT (getdate()) FOR [fecha_pago]
GO
ALTER TABLE [dbo].[prestamos] ADD  DEFAULT (getdate()) FOR [fecha_inicio]
GO
ALTER TABLE [dbo].[cuotas]  WITH CHECK ADD FOREIGN KEY([prestamo_id])
REFERENCES [dbo].[prestamos] ([id])
GO
ALTER TABLE [dbo].[detalles_cuotas_pagos]  WITH CHECK ADD  CONSTRAINT [fk_detalle_cuotas_pagos_cuotas] FOREIGN KEY([cuota_id])
REFERENCES [dbo].[cuotas] ([id])
GO
ALTER TABLE [dbo].[detalles_cuotas_pagos] CHECK CONSTRAINT [fk_detalle_cuotas_pagos_cuotas]
GO
ALTER TABLE [dbo].[detalles_cuotas_pagos]  WITH CHECK ADD  CONSTRAINT [fk_detalle_cuotas_pagos_pagos] FOREIGN KEY([pago_id])
REFERENCES [dbo].[pagos] ([id])
GO
ALTER TABLE [dbo].[detalles_cuotas_pagos] CHECK CONSTRAINT [fk_detalle_cuotas_pagos_pagos]
GO
ALTER TABLE [dbo].[empleados]  WITH CHECK ADD FOREIGN KEY([sucursal_id])
REFERENCES [dbo].[sucursales] ([id])
GO
ALTER TABLE [dbo].[empleados]  WITH CHECK ADD FOREIGN KEY([supervisor_id])
REFERENCES [dbo].[empleados] ([id])
GO
ALTER TABLE [dbo].[empleados]  WITH CHECK ADD  CONSTRAINT [fk_persona_natural_empleado] FOREIGN KEY([persona_id])
REFERENCES [dbo].[personas_naturales] ([id])
GO
ALTER TABLE [dbo].[empleados] CHECK CONSTRAINT [fk_persona_natural_empleado]
GO
ALTER TABLE [dbo].[pagos]  WITH CHECK ADD FOREIGN KEY([metodo_pago_id])
REFERENCES [dbo].[metodos_pago] ([id])
GO
ALTER TABLE [dbo].[prestamos]  WITH CHECK ADD FOREIGN KEY([cliente_id])
REFERENCES [dbo].[clientes] ([id])
GO
ALTER TABLE [dbo].[prestamos]  WITH CHECK ADD FOREIGN KEY([oficial_credito_id])
REFERENCES [dbo].[empleados] ([id])
GO
ALTER TABLE [dbo].[prestamos]  WITH CHECK ADD FOREIGN KEY([sucursal_id])
REFERENCES [dbo].[sucursales] ([id])
GO
ALTER TABLE [dbo].[prestamos]  WITH CHECK ADD FOREIGN KEY([tipo_prestamo_id])
REFERENCES [dbo].[tipos_prestamo] ([id])
GO
USE [master]
GO
ALTER DATABASE [dsrp_prestamos_financieros] SET  READ_WRITE 
GO
