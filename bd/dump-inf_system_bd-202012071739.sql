PGDMP         '                x            inf_system_bd    12.5    12.5 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    26670    inf_system_bd    DATABASE        CREATE DATABASE inf_system_bd WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8';
    DROP DATABASE inf_system_bd;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3                        1255    26990    add_values()    FUNCTION        CREATE FUNCTION public.add_values() RETURNS void
    LANGUAGE sql
    AS $$
	insert into public.shop_category (id,"name",description)
	values
	(1,'category1','generaldesc1'),
	(2,'category2','generaldesc2'),
	(3,'category3','generaldesc3'),
	(4,'category4','generaldesc4');
	insert into public.shop_client (id,first_name,last_name,middle_name,email,phone,address)
	values
	(1,'Pakhom','Menshikov','Samsonovich','example1@gmail.com','+375333415378','address1'),
	(2,'Pakhom','Zakryatin','Nikanorovich','example2@gmail.com','+375333515378','address2'),
	(3,'Agap','Shein','Nikiforovich','example3@gmail.com','+375333615378','address3'),
	(4,'Vladlen','Mikhalitsyn','Samuilovich','example4@gmail.com','+375333715378','address4'),
	(5,'Varvara','Selezneva','Georgievna','example5@gmail.com','+375333225378','address5');
	insert into public.shop_position (id,"name",salary)
	values
	(1,'employee',100),
	(2,'manager',200);
	insert into public.shop_employee (id,first_name,last_name,middle_name,email,phone,position_id)
	values
	(2,'Agata','Domasha','Ippolitovna','example8@gmail.com','+375333221378',1),
	(3,'Zoya','Rodionova','Mikheevna','example9@gmail.com','+375333217778',1),
	(4,'Ksenia','Tabernakulova','Yulievna','example10@gmail.com','+375333211318',2),
	(5,'Terenty','Kotyash','Nikanorovich','example11@gmail.com','+375333245338',1),
	(6,'Margarita','Bandurkina','Timurovna','example12@gmail.com','+375333225379',1),
	(7,'Matvey','Sechenov','Onisimovich','example13@gmail.com','+375333216373',1);
	insert into public.shop_provider (id,"name",representative,email,phone,address)
	values
	(1,'provider1','representative1','email123@gmail.com','+375339540312','address10'),
	(2,'provider2','representative2','email124@gmail.com','+375339541312','address11');
	insert into public.shop_supply (id,"date" ,provider_id)
	values
	(1,TO_DATE('12/11/2018', 'DD/MM/YYYY'),1),
	(2,TO_DATE('12/10/2018', 'DD/MM/YYYY'),2),
	(3,TO_DATE('11/11/2018', 'DD/MM/YYYY'),2),
	(4,TO_DATE('15/4/2018', 'DD/MM/YYYY'),1),
	(5,TO_DATE('12/12/2018', 'DD/MM/YYYY'),2);
	insert into public.shop_product (id,"name",tech_description,price,is_on_shop,category_id,supply_id)
	values
	(1,'product1','techdescription1',30,true,1,1),
	(2,'product2','techdescription2',40,true,2,2),
	(3,'product3','techdescription3',50,true,3,3),
	(4,'product4','techdescription4',60,true,4,4),
	(5,'product5','techdescription5',70,true,1,5),
	(6,'product6','techdescription6',80,true,2,1),
	(7,'product7','techdescription7',90,true,3,2),
	(8,'product8','techdescription8',100,true,4,3),
	(9,'product9','techdescription9',10,true,2,4),
	(10,'product10','techdescription10',15,true,4,3);
--	insert into public.shop_order (id,client_id,employee_id,product_id)
--	values
--	(1,1,1,1),
--	(2,2,2,2),
--	(3,1,5,3),
--	(4,1,4,4),
--	(5,3,1,5),
--	(6,4,6,1),
--	(7,1,1,6),
--	(8,6,2,2),
--	(9,1,4,3);
$$;
 #   DROP FUNCTION public.add_values();
       public          postgres    false    3            �            1255    26989    delete_values()    FUNCTION     c  CREATE FUNCTION public.delete_values() RETURNS void
    LANGUAGE sql
    AS $$
	delete from public.shop_category;
	delete from public.shop_client;
	delete from public.shop_position;
	delete from public.shop_employee;
	delete from public.shop_provider;
	delete from public.shop_supply;
	delete from public.shop_product;
	delete from public.shop_order;
$$;
 &   DROP FUNCTION public.delete_values();
       public          postgres    false    3            �            1255    26992    get_count_employees()    FUNCTION     �   CREATE FUNCTION public.get_count_employees() RETURNS bigint
    LANGUAGE sql
    AS $$
	select count(*)
	from shop_employee se
	join shop_position sp on se.position_id = sp.id 
	where sp.name = 'employee';
$$;
 ,   DROP FUNCTION public.get_count_employees();
       public          postgres    false    3                       1255    27028 /   get_product_by_provider_name(character varying)    FUNCTION       CREATE FUNCTION public.get_product_by_provider_name(prov_name character varying) RETURNS TABLE(prod_name character varying, prod_techdescr character varying, prod_image character varying, prod_price numeric, prov_name character varying, prov_address character varying)
    LANGUAGE sql
    AS $$
	select sp."name" , sp.tech_description , sp.image , sp.price , sp2."name" , sp2.address 
	from shop_product sp 
	join shop_supply ss on sp.supply_id = ss.id
	join shop_provider sp2 on sp2.id = ss.provider_id 
	where sp2."name" = prov_name;
$$;
 P   DROP FUNCTION public.get_product_by_provider_name(prov_name character varying);
       public          postgres    false    3            �            1255    26993 %   get_product_where_price_more(integer)    FUNCTION     8  CREATE FUNCTION public.get_product_where_price_more(inter_price integer) RETURNS TABLE(product_name character varying, product_tech_description character varying, price numeric)
    LANGUAGE sql
    AS $$
	select sp.name, sp.tech_description , sp.price 
	from shop_product sp 
	where sp.price > inter_price;
$$;
 H   DROP FUNCTION public.get_product_where_price_more(inter_price integer);
       public          postgres    false    3            �            1255    27027    get_products_in_shop()    FUNCTION     0  CREATE FUNCTION public.get_products_in_shop() RETURNS TABLE(prod_name character varying, prod_techdescr character varying, prod_image character varying, prod_price numeric)
    LANGUAGE sql
    AS $$
	select "name" , tech_description , image , price 
	from shop_product sp 
	where is_on_shop = true;
$$;
 -   DROP FUNCTION public.get_products_in_shop();
       public          postgres    false    3            �            1255    27004    trigger_add_employee()    FUNCTION     �  CREATE FUNCTION public.trigger_add_employee() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare 
			employee_user_name varchar;
			employee_password varchar;
			employee_first_name varchar;
			employee_last_name varchar;
			employee_email varchar;
			employee_is_staff bool;
			employee_is_active bool;
	BEGIN
		employee_user_name = ('employee' || new.id);
		employee_password = ('Employee_Pass' || new.id || '*');
		employee_first_name = new.first_name;
		employee_last_name = new.last_name;
		employee_email = new.email;
		employee_is_active = true;
		employee_is_staff = true;
		insert into auth_user (id,username,"password",first_name,last_name,email,is_staff,is_active,is_superuser,date_joined)
		values
		(new.id,employee_user_name,md5(employee_password),employee_first_name,
		employee_last_name,employee_email,employee_is_staff,employee_is_active,false,now());
		insert into auth_user_groups(user_id,group_id)
		values
		(new.id,new.position_id);
	return null;
	END;
$$;
 -   DROP FUNCTION public.trigger_add_employee();
       public          postgres    false    3            �            1255    27006    trigger_delete_employee()    FUNCTION       CREATE FUNCTION public.trigger_delete_employee() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		delete from auth_user_groups aug
			where aug.user_id = old.id;
			delete from auth_user
			where username = ('employee' || old.id);
		return null;
	END;
$$;
 0   DROP FUNCTION public.trigger_delete_employee();
       public          postgres    false    3            �            1255    27015    trigger_for_product()    FUNCTION     �   CREATE FUNCTION public.trigger_for_product() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
	if new.price <= 0 then 
		raise exception 'Cannot add or update price less or equal 0';
	else
		return new;
	end if;
	END;
$$;
 ,   DROP FUNCTION public.trigger_for_product();
       public          postgres    false    3            �            1259    26702 
   auth_group    TABLE     f   CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);
    DROP TABLE public.auth_group;
       public         heap    postgres    false    3            �            1259    26700    auth_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.auth_group_id_seq;
       public          postgres    false    3    209            �           0    0    auth_group_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;
          public          postgres    false    208            �            1259    26712    auth_group_permissions    TABLE     �   CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);
 *   DROP TABLE public.auth_group_permissions;
       public         heap    postgres    false    3            �            1259    26710    auth_group_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.auth_group_permissions_id_seq;
       public          postgres    false    211    3            �           0    0    auth_group_permissions_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;
          public          postgres    false    210            �            1259    26694    auth_permission    TABLE     �   CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);
 #   DROP TABLE public.auth_permission;
       public         heap    postgres    false    3            �            1259    26692    auth_permission_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.auth_permission_id_seq;
       public          postgres    false    207    3            �           0    0    auth_permission_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;
          public          postgres    false    206            �            1259    26720 	   auth_user    TABLE     �  CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);
    DROP TABLE public.auth_user;
       public         heap    postgres    false    3            �            1259    26730    auth_user_groups    TABLE        CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);
 $   DROP TABLE public.auth_user_groups;
       public         heap    postgres    false    3            �            1259    26728    auth_user_groups_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.auth_user_groups_id_seq;
       public          postgres    false    215    3            �           0    0    auth_user_groups_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;
          public          postgres    false    214            �            1259    26718    auth_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.auth_user_id_seq;
       public          postgres    false    3    213            �           0    0    auth_user_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;
          public          postgres    false    212            �            1259    26738    auth_user_user_permissions    TABLE     �   CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);
 .   DROP TABLE public.auth_user_user_permissions;
       public         heap    postgres    false    3            �            1259    26736 !   auth_user_user_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.auth_user_user_permissions_id_seq;
       public          postgres    false    217    3            �           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;
          public          postgres    false    216            �            1259    26798    django_admin_log    TABLE     �  CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);
 $   DROP TABLE public.django_admin_log;
       public         heap    postgres    false    3            �            1259    26796    django_admin_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.django_admin_log_id_seq;
       public          postgres    false    219    3            �           0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;
          public          postgres    false    218            �            1259    26684    django_content_type    TABLE     �   CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);
 '   DROP TABLE public.django_content_type;
       public         heap    postgres    false    3            �            1259    26682    django_content_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.django_content_type_id_seq;
       public          postgres    false    3    205            �           0    0    django_content_type_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;
          public          postgres    false    204            �            1259    26673    django_migrations    TABLE     �   CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);
 %   DROP TABLE public.django_migrations;
       public         heap    postgres    false    3            �            1259    26671    django_migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.django_migrations_id_seq;
       public          postgres    false    3    203            �           0    0    django_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;
          public          postgres    false    202            �            1259    26829    django_session    TABLE     �   CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);
 "   DROP TABLE public.django_session;
       public         heap    postgres    false    3            �            1259    26841    shop_category    TABLE     �   CREATE TABLE public.shop_category (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL
);
 !   DROP TABLE public.shop_category;
       public         heap    postgres    false    3            �            1259    26839    shop_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shop_category_id_seq;
       public          postgres    false    222    3            �           0    0    shop_category_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shop_category_id_seq OWNED BY public.shop_category.id;
          public          postgres    false    221            �            1259    26851    shop_client    TABLE     L  CREATE TABLE public.shop_client (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    middle_name character varying(50) NOT NULL,
    email character varying(80) NOT NULL,
    phone character varying(128) NOT NULL,
    address character varying(100) NOT NULL
);
    DROP TABLE public.shop_client;
       public         heap    postgres    false    3            �            1259    26849    shop_client_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.shop_client_id_seq;
       public          postgres    false    3    224            �           0    0    shop_client_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.shop_client_id_seq OWNED BY public.shop_client.id;
          public          postgres    false    223            �            1259    26865    shop_employee    TABLE     C  CREATE TABLE public.shop_employee (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    middle_name character varying(50) NOT NULL,
    email character varying(80) NOT NULL,
    phone character varying(128) NOT NULL,
    position_id integer NOT NULL
);
 !   DROP TABLE public.shop_employee;
       public         heap    postgres    false    3            �            1259    26863    shop_employee_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shop_employee_id_seq;
       public          postgres    false    3    226            �           0    0    shop_employee_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shop_employee_id_seq OWNED BY public.shop_employee.id;
          public          postgres    false    225            �            1259    26927 
   shop_order    TABLE     �   CREATE TABLE public.shop_order (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    client_id integer NOT NULL,
    employee_id integer NOT NULL,
    product_id integer NOT NULL
);
    DROP TABLE public.shop_order;
       public         heap    postgres    false    3            �            1259    26925    shop_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.shop_order_id_seq;
       public          postgres    false    236    3            �           0    0    shop_order_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.shop_order_id_seq OWNED BY public.shop_order.id;
          public          postgres    false    235            �            1259    26877    shop_position    TABLE     �   CREATE TABLE public.shop_position (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    salary numeric(9,2) NOT NULL
);
 !   DROP TABLE public.shop_position;
       public         heap    postgres    false    3            �            1259    26875    shop_position_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shop_position_id_seq;
       public          postgres    false    228    3            �           0    0    shop_position_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shop_position_id_seq OWNED BY public.shop_position.id;
          public          postgres    false    227            �            1259    26914    shop_product    TABLE     D  CREATE TABLE public.shop_product (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    tech_description character varying(255) NOT NULL,
    image character varying(100),
    price numeric(9,2) NOT NULL,
    is_on_shop boolean NOT NULL,
    category_id integer NOT NULL,
    supply_id integer NOT NULL
);
     DROP TABLE public.shop_product;
       public         heap    postgres    false    3            �            1259    26912    shop_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.shop_product_id_seq;
       public          postgres    false    3    234            �           0    0    shop_product_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.shop_product_id_seq OWNED BY public.shop_product.id;
          public          postgres    false    233            �            1259    26887    shop_provider    TABLE       CREATE TABLE public.shop_provider (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    representative character varying(100) NOT NULL,
    email character varying(80) NOT NULL,
    phone character varying(128) NOT NULL,
    address character varying(100) NOT NULL
);
 !   DROP TABLE public.shop_provider;
       public         heap    postgres    false    3            �            1259    26885    shop_provider_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_provider_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.shop_provider_id_seq;
       public          postgres    false    230    3            �           0    0    shop_provider_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.shop_provider_id_seq OWNED BY public.shop_provider.id;
          public          postgres    false    229            �            1259    26906    shop_supply    TABLE     w   CREATE TABLE public.shop_supply (
    id integer NOT NULL,
    date date NOT NULL,
    provider_id integer NOT NULL
);
    DROP TABLE public.shop_supply;
       public         heap    postgres    false    3            �            1259    26904    shop_supply_id_seq    SEQUENCE     �   CREATE SEQUENCE public.shop_supply_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.shop_supply_id_seq;
       public          postgres    false    3    232            �           0    0    shop_supply_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.shop_supply_id_seq OWNED BY public.shop_supply.id;
          public          postgres    false    231            �           2604    26705    auth_group id    DEFAULT     n   ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);
 <   ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    208    209            �           2604    26715    auth_group_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);
 H   ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211            �           2604    26697    auth_permission id    DEFAULT     x   ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);
 A   ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    206    207            �           2604    26723    auth_user id    DEFAULT     l   ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);
 ;   ALTER TABLE public.auth_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    213    213            �           2604    26733    auth_user_groups id    DEFAULT     z   ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);
 B   ALTER TABLE public.auth_user_groups ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    26741    auth_user_user_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);
 L   ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    26801    django_admin_log id    DEFAULT     z   ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);
 B   ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219                       2604    26687    django_content_type id    DEFAULT     �   ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);
 E   ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            ~           2604    26676    django_migrations id    DEFAULT     |   ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);
 C   ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    202    203    203            �           2604    26844    shop_category id    DEFAULT     t   ALTER TABLE ONLY public.shop_category ALTER COLUMN id SET DEFAULT nextval('public.shop_category_id_seq'::regclass);
 ?   ALTER TABLE public.shop_category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    26854    shop_client id    DEFAULT     p   ALTER TABLE ONLY public.shop_client ALTER COLUMN id SET DEFAULT nextval('public.shop_client_id_seq'::regclass);
 =   ALTER TABLE public.shop_client ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    26868    shop_employee id    DEFAULT     t   ALTER TABLE ONLY public.shop_employee ALTER COLUMN id SET DEFAULT nextval('public.shop_employee_id_seq'::regclass);
 ?   ALTER TABLE public.shop_employee ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    26930    shop_order id    DEFAULT     n   ALTER TABLE ONLY public.shop_order ALTER COLUMN id SET DEFAULT nextval('public.shop_order_id_seq'::regclass);
 <   ALTER TABLE public.shop_order ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    236    235    236            �           2604    26880    shop_position id    DEFAULT     t   ALTER TABLE ONLY public.shop_position ALTER COLUMN id SET DEFAULT nextval('public.shop_position_id_seq'::regclass);
 ?   ALTER TABLE public.shop_position ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227    228            �           2604    26917    shop_product id    DEFAULT     r   ALTER TABLE ONLY public.shop_product ALTER COLUMN id SET DEFAULT nextval('public.shop_product_id_seq'::regclass);
 >   ALTER TABLE public.shop_product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    234    234            �           2604    26890    shop_provider id    DEFAULT     t   ALTER TABLE ONLY public.shop_provider ALTER COLUMN id SET DEFAULT nextval('public.shop_provider_id_seq'::regclass);
 ?   ALTER TABLE public.shop_provider ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    230    230            �           2604    26909    shop_supply id    DEFAULT     p   ALTER TABLE ONLY public.shop_supply ALTER COLUMN id SET DEFAULT nextval('public.shop_supply_id_seq'::regclass);
 =   ALTER TABLE public.shop_supply ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231    232            �          0    26702 
   auth_group 
   TABLE DATA                 public          postgres    false    209            �          0    26712    auth_group_permissions 
   TABLE DATA                 public          postgres    false    211            �          0    26694    auth_permission 
   TABLE DATA                 public          postgres    false    207            �          0    26720 	   auth_user 
   TABLE DATA                 public          postgres    false    213            �          0    26730    auth_user_groups 
   TABLE DATA                 public          postgres    false    215            �          0    26738    auth_user_user_permissions 
   TABLE DATA                 public          postgres    false    217            �          0    26798    django_admin_log 
   TABLE DATA                 public          postgres    false    219            �          0    26684    django_content_type 
   TABLE DATA                 public          postgres    false    205            �          0    26673    django_migrations 
   TABLE DATA                 public          postgres    false    203            �          0    26829    django_session 
   TABLE DATA                 public          postgres    false    220            �          0    26841    shop_category 
   TABLE DATA                 public          postgres    false    222            �          0    26851    shop_client 
   TABLE DATA                 public          postgres    false    224            �          0    26865    shop_employee 
   TABLE DATA                 public          postgres    false    226            �          0    26927 
   shop_order 
   TABLE DATA                 public          postgres    false    236            �          0    26877    shop_position 
   TABLE DATA                 public          postgres    false    228            �          0    26914    shop_product 
   TABLE DATA                 public          postgres    false    234            �          0    26887    shop_provider 
   TABLE DATA                 public          postgres    false    230            �          0    26906    shop_supply 
   TABLE DATA                 public          postgres    false    232            �           0    0    auth_group_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.auth_group_id_seq', 2, true);
          public          postgres    false    208            �           0    0    auth_group_permissions_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 44, true);
          public          postgres    false    210            �           0    0    auth_permission_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.auth_permission_id_seq', 56, true);
          public          postgres    false    206            �           0    0    auth_user_groups_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 9, true);
          public          postgres    false    214            �           0    0    auth_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);
          public          postgres    false    212            �           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);
          public          postgres    false    216            �           0    0    django_admin_log_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.django_admin_log_id_seq', 48, true);
          public          postgres    false    218            �           0    0    django_content_type_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);
          public          postgres    false    204            �           0    0    django_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.django_migrations_id_seq', 23, true);
          public          postgres    false    202            �           0    0    shop_category_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.shop_category_id_seq', 13, true);
          public          postgres    false    221            �           0    0    shop_client_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.shop_client_id_seq', 7, true);
          public          postgres    false    223            �           0    0    shop_employee_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shop_employee_id_seq', 9, true);
          public          postgres    false    225            �           0    0    shop_order_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.shop_order_id_seq', 8, true);
          public          postgres    false    235            �           0    0    shop_position_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shop_position_id_seq', 1, true);
          public          postgres    false    227            �           0    0    shop_product_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shop_product_id_seq', 12, true);
          public          postgres    false    233            �           0    0    shop_provider_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.shop_provider_id_seq', 1, true);
          public          postgres    false    229            �           0    0    shop_supply_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.shop_supply_id_seq', 1, true);
          public          postgres    false    231            �           2606    26827    auth_group auth_group_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
       public            postgres    false    209            �           2606    26754 R   auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);
 |   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
       public            postgres    false    211    211            �           2606    26717 2   auth_group_permissions auth_group_permissions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
       public            postgres    false    211            �           2606    26707    auth_group auth_group_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
       public            postgres    false    209            �           2606    26745 F   auth_permission auth_permission_content_type_id_codename_01ab375a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);
 p   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
       public            postgres    false    207    207            �           2606    26699 $   auth_permission auth_permission_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
       public            postgres    false    207            �           2606    26735 &   auth_user_groups auth_user_groups_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_pkey;
       public            postgres    false    215            �           2606    26769 @   auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);
 j   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq;
       public            postgres    false    215    215            �           2606    26725    auth_user auth_user_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_pkey;
       public            postgres    false    213            �           2606    26743 :   auth_user_user_permissions auth_user_user_permissions_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_pkey;
       public            postgres    false    217            �           2606    26783 Y   auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
       public            postgres    false    217    217            �           2606    26821     auth_user auth_user_username_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);
 J   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_username_key;
       public            postgres    false    213            �           2606    26807 &   django_admin_log django_admin_log_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public            postgres    false    219            �           2606    26691 E   django_content_type django_content_type_app_label_model_76bd3d3b_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);
 o   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
       public            postgres    false    205    205            �           2606    26689 ,   django_content_type django_content_type_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public            postgres    false    205            �           2606    26681 (   django_migrations django_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public            postgres    false    203            �           2606    26836 "   django_session django_session_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public            postgres    false    220            �           2606    26848 $   shop_category shop_category_name_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.shop_category
    ADD CONSTRAINT shop_category_name_key UNIQUE (name);
 N   ALTER TABLE ONLY public.shop_category DROP CONSTRAINT shop_category_name_key;
       public            postgres    false    222            �           2606    26846     shop_category shop_category_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shop_category
    ADD CONSTRAINT shop_category_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shop_category DROP CONSTRAINT shop_category_pkey;
       public            postgres    false    222            �           2606    26862 #   shop_client shop_client_address_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shop_client
    ADD CONSTRAINT shop_client_address_key UNIQUE (address);
 M   ALTER TABLE ONLY public.shop_client DROP CONSTRAINT shop_client_address_key;
       public            postgres    false    224            �           2606    26858 !   shop_client shop_client_email_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.shop_client
    ADD CONSTRAINT shop_client_email_key UNIQUE (email);
 K   ALTER TABLE ONLY public.shop_client DROP CONSTRAINT shop_client_email_key;
       public            postgres    false    224            �           2606    26860 !   shop_client shop_client_phone_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.shop_client
    ADD CONSTRAINT shop_client_phone_key UNIQUE (phone);
 K   ALTER TABLE ONLY public.shop_client DROP CONSTRAINT shop_client_phone_key;
       public            postgres    false    224            �           2606    26856    shop_client shop_client_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.shop_client
    ADD CONSTRAINT shop_client_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.shop_client DROP CONSTRAINT shop_client_pkey;
       public            postgres    false    224            �           2606    26872 %   shop_employee shop_employee_email_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shop_employee
    ADD CONSTRAINT shop_employee_email_key UNIQUE (email);
 O   ALTER TABLE ONLY public.shop_employee DROP CONSTRAINT shop_employee_email_key;
       public            postgres    false    226            �           2606    26874 %   shop_employee shop_employee_phone_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shop_employee
    ADD CONSTRAINT shop_employee_phone_key UNIQUE (phone);
 O   ALTER TABLE ONLY public.shop_employee DROP CONSTRAINT shop_employee_phone_key;
       public            postgres    false    226            �           2606    26870     shop_employee shop_employee_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shop_employee
    ADD CONSTRAINT shop_employee_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shop_employee DROP CONSTRAINT shop_employee_pkey;
       public            postgres    false    226            �           2606    26932    shop_order shop_order_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.shop_order DROP CONSTRAINT shop_order_pkey;
       public            postgres    false    236            �           2606    26884 $   shop_position shop_position_name_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.shop_position
    ADD CONSTRAINT shop_position_name_key UNIQUE (name);
 N   ALTER TABLE ONLY public.shop_position DROP CONSTRAINT shop_position_name_key;
       public            postgres    false    228            �           2606    26882     shop_position shop_position_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shop_position
    ADD CONSTRAINT shop_position_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shop_position DROP CONSTRAINT shop_position_pkey;
       public            postgres    false    228            �           2606    26924 "   shop_product shop_product_name_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_name_key UNIQUE (name);
 L   ALTER TABLE ONLY public.shop_product DROP CONSTRAINT shop_product_name_key;
       public            postgres    false    234            �           2606    26922    shop_product shop_product_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.shop_product DROP CONSTRAINT shop_product_pkey;
       public            postgres    false    234            �           2606    26903 '   shop_provider shop_provider_address_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.shop_provider
    ADD CONSTRAINT shop_provider_address_key UNIQUE (address);
 Q   ALTER TABLE ONLY public.shop_provider DROP CONSTRAINT shop_provider_address_key;
       public            postgres    false    230            �           2606    26899 %   shop_provider shop_provider_email_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shop_provider
    ADD CONSTRAINT shop_provider_email_key UNIQUE (email);
 O   ALTER TABLE ONLY public.shop_provider DROP CONSTRAINT shop_provider_email_key;
       public            postgres    false    230            �           2606    26897 $   shop_provider shop_provider_name_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.shop_provider
    ADD CONSTRAINT shop_provider_name_key UNIQUE (name);
 N   ALTER TABLE ONLY public.shop_provider DROP CONSTRAINT shop_provider_name_key;
       public            postgres    false    230            �           2606    26901 %   shop_provider shop_provider_phone_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.shop_provider
    ADD CONSTRAINT shop_provider_phone_key UNIQUE (phone);
 O   ALTER TABLE ONLY public.shop_provider DROP CONSTRAINT shop_provider_phone_key;
       public            postgres    false    230            �           2606    26895     shop_provider shop_provider_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.shop_provider
    ADD CONSTRAINT shop_provider_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.shop_provider DROP CONSTRAINT shop_provider_pkey;
       public            postgres    false    230            �           2606    26911    shop_supply shop_supply_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.shop_supply
    ADD CONSTRAINT shop_supply_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.shop_supply DROP CONSTRAINT shop_supply_pkey;
       public            postgres    false    232            �           1259    26828    auth_group_name_a6ea08ec_like    INDEX     h   CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);
 1   DROP INDEX public.auth_group_name_a6ea08ec_like;
       public            postgres    false    209            �           1259    26765 (   auth_group_permissions_group_id_b120cbf9    INDEX     o   CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);
 <   DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
       public            postgres    false    211            �           1259    26766 -   auth_group_permissions_permission_id_84c5c92e    INDEX     y   CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);
 A   DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
       public            postgres    false    211            �           1259    26751 (   auth_permission_content_type_id_2f476e4b    INDEX     o   CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);
 <   DROP INDEX public.auth_permission_content_type_id_2f476e4b;
       public            postgres    false    207            �           1259    26781 "   auth_user_groups_group_id_97559544    INDEX     c   CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);
 6   DROP INDEX public.auth_user_groups_group_id_97559544;
       public            postgres    false    215            �           1259    26780 !   auth_user_groups_user_id_6a12ed8b    INDEX     a   CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);
 5   DROP INDEX public.auth_user_groups_user_id_6a12ed8b;
       public            postgres    false    215            �           1259    26795 1   auth_user_user_permissions_permission_id_1fbb5f2c    INDEX     �   CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);
 E   DROP INDEX public.auth_user_user_permissions_permission_id_1fbb5f2c;
       public            postgres    false    217            �           1259    26794 +   auth_user_user_permissions_user_id_a95ead1b    INDEX     u   CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);
 ?   DROP INDEX public.auth_user_user_permissions_user_id_a95ead1b;
       public            postgres    false    217            �           1259    26822     auth_user_username_6821ab7c_like    INDEX     n   CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);
 4   DROP INDEX public.auth_user_username_6821ab7c_like;
       public            postgres    false    213            �           1259    26818 )   django_admin_log_content_type_id_c4bce8eb    INDEX     q   CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);
 =   DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
       public            postgres    false    219            �           1259    26819 !   django_admin_log_user_id_c564eba6    INDEX     a   CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);
 5   DROP INDEX public.django_admin_log_user_id_c564eba6;
       public            postgres    false    219            �           1259    26838 #   django_session_expire_date_a5c62663    INDEX     e   CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);
 7   DROP INDEX public.django_session_expire_date_a5c62663;
       public            postgres    false    220            �           1259    26837 (   django_session_session_key_c0390e0f_like    INDEX     ~   CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);
 <   DROP INDEX public.django_session_session_key_c0390e0f_like;
       public            postgres    false    220            �           1259    26939     shop_category_name_11b68823_like    INDEX     n   CREATE INDEX shop_category_name_11b68823_like ON public.shop_category USING btree (name varchar_pattern_ops);
 4   DROP INDEX public.shop_category_name_11b68823_like;
       public            postgres    false    222            �           1259    26942 !   shop_client_address_db54efcf_like    INDEX     p   CREATE INDEX shop_client_address_db54efcf_like ON public.shop_client USING btree (address varchar_pattern_ops);
 5   DROP INDEX public.shop_client_address_db54efcf_like;
       public            postgres    false    224            �           1259    26940    shop_client_email_f9da64da_like    INDEX     l   CREATE INDEX shop_client_email_f9da64da_like ON public.shop_client USING btree (email varchar_pattern_ops);
 3   DROP INDEX public.shop_client_email_f9da64da_like;
       public            postgres    false    224            �           1259    26941    shop_client_phone_f28b12b1_like    INDEX     l   CREATE INDEX shop_client_phone_f28b12b1_like ON public.shop_client USING btree (phone varchar_pattern_ops);
 3   DROP INDEX public.shop_client_phone_f28b12b1_like;
       public            postgres    false    224            �           1259    26943 !   shop_employee_email_c9ec26ba_like    INDEX     p   CREATE INDEX shop_employee_email_c9ec26ba_like ON public.shop_employee USING btree (email varchar_pattern_ops);
 5   DROP INDEX public.shop_employee_email_c9ec26ba_like;
       public            postgres    false    226            �           1259    26944 !   shop_employee_phone_fc1acf9d_like    INDEX     p   CREATE INDEX shop_employee_phone_fc1acf9d_like ON public.shop_employee USING btree (phone varchar_pattern_ops);
 5   DROP INDEX public.shop_employee_phone_fc1acf9d_like;
       public            postgres    false    226            �           1259    26987 "   shop_employee_position_id_d359c108    INDEX     c   CREATE INDEX shop_employee_position_id_d359c108 ON public.shop_employee USING btree (position_id);
 6   DROP INDEX public.shop_employee_position_id_d359c108;
       public            postgres    false    226            �           1259    26984    shop_order_client_id_5ef2b3ba    INDEX     Y   CREATE INDEX shop_order_client_id_5ef2b3ba ON public.shop_order USING btree (client_id);
 1   DROP INDEX public.shop_order_client_id_5ef2b3ba;
       public            postgres    false    236            �           1259    26985    shop_order_employee_id_abfbf4ff    INDEX     ]   CREATE INDEX shop_order_employee_id_abfbf4ff ON public.shop_order USING btree (employee_id);
 3   DROP INDEX public.shop_order_employee_id_abfbf4ff;
       public            postgres    false    236            �           1259    26986    shop_order_product_id_0eef2166    INDEX     [   CREATE INDEX shop_order_product_id_0eef2166 ON public.shop_order USING btree (product_id);
 2   DROP INDEX public.shop_order_product_id_0eef2166;
       public            postgres    false    236            �           1259    26945     shop_position_name_5c8bee57_like    INDEX     n   CREATE INDEX shop_position_name_5c8bee57_like ON public.shop_position USING btree (name varchar_pattern_ops);
 4   DROP INDEX public.shop_position_name_5c8bee57_like;
       public            postgres    false    228            �           1259    26967 !   shop_product_category_id_14d7eea8    INDEX     a   CREATE INDEX shop_product_category_id_14d7eea8 ON public.shop_product USING btree (category_id);
 5   DROP INDEX public.shop_product_category_id_14d7eea8;
       public            postgres    false    234            �           1259    26966    shop_product_name_b8d5e94c_like    INDEX     l   CREATE INDEX shop_product_name_b8d5e94c_like ON public.shop_product USING btree (name varchar_pattern_ops);
 3   DROP INDEX public.shop_product_name_b8d5e94c_like;
       public            postgres    false    234            �           1259    26968    shop_product_supply_id_08596c9d    INDEX     ]   CREATE INDEX shop_product_supply_id_08596c9d ON public.shop_product USING btree (supply_id);
 3   DROP INDEX public.shop_product_supply_id_08596c9d;
       public            postgres    false    234            �           1259    26949 #   shop_provider_address_d9a83975_like    INDEX     t   CREATE INDEX shop_provider_address_d9a83975_like ON public.shop_provider USING btree (address varchar_pattern_ops);
 7   DROP INDEX public.shop_provider_address_d9a83975_like;
       public            postgres    false    230            �           1259    26947 !   shop_provider_email_b9ea9fc0_like    INDEX     p   CREATE INDEX shop_provider_email_b9ea9fc0_like ON public.shop_provider USING btree (email varchar_pattern_ops);
 5   DROP INDEX public.shop_provider_email_b9ea9fc0_like;
       public            postgres    false    230            �           1259    26946     shop_provider_name_f803d349_like    INDEX     n   CREATE INDEX shop_provider_name_f803d349_like ON public.shop_provider USING btree (name varchar_pattern_ops);
 4   DROP INDEX public.shop_provider_name_f803d349_like;
       public            postgres    false    230            �           1259    26948 !   shop_provider_phone_f716f97d_like    INDEX     p   CREATE INDEX shop_provider_phone_f716f97d_like ON public.shop_provider USING btree (phone varchar_pattern_ops);
 5   DROP INDEX public.shop_provider_phone_f716f97d_like;
       public            postgres    false    230            �           1259    26955     shop_supply_provider_id_83ec874c    INDEX     _   CREATE INDEX shop_supply_provider_id_83ec874c ON public.shop_supply USING btree (provider_id);
 4   DROP INDEX public.shop_supply_provider_id_83ec874c;
       public            postgres    false    232                       2620    27016 &   shop_product add_or_update_check_price    TRIGGER     �   CREATE TRIGGER add_or_update_check_price BEFORE INSERT OR UPDATE ON public.shop_product FOR EACH ROW EXECUTE FUNCTION public.trigger_for_product();
 ?   DROP TRIGGER add_or_update_check_price ON public.shop_product;
       public          postgres    false    234    255                       2620    27009    shop_employee delete_employee    TRIGGER     �   CREATE TRIGGER delete_employee AFTER DELETE ON public.shop_employee FOR EACH ROW EXECUTE FUNCTION public.trigger_delete_employee();
 6   DROP TRIGGER delete_employee ON public.shop_employee;
       public          postgres    false    226    254            
           2620    27005    shop_employee new_employee    TRIGGER     ~   CREATE TRIGGER new_employee AFTER INSERT ON public.shop_employee FOR EACH ROW EXECUTE FUNCTION public.trigger_add_employee();
 3   DROP TRIGGER new_employee ON public.shop_employee;
       public          postgres    false    226    253            �           2606    26760 O   auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
       public          postgres    false    2970    211    207            �           2606    26755 P   auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
       public          postgres    false    2975    209    211            �           2606    26746 E   auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
       public          postgres    false    205    207    2965            �           2606    26775 D   auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id;
       public          postgres    false    2975    215    209            �           2606    26770 B   auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
       public          postgres    false    2983    213    215                        2606    26789 S   auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
       public          postgres    false    217    207    2970            �           2606    26784 V   auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
       public          postgres    false    217    213    2983                       2606    26808 G   django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
       public          postgres    false    205    219    2965                       2606    26813 B   django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id;
       public          postgres    false    213    219    2983                       2606    26934 D   shop_employee shop_employee_position_id_d359c108_fk_shop_position_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_employee
    ADD CONSTRAINT shop_employee_position_id_d359c108_fk_shop_position_id FOREIGN KEY (position_id) REFERENCES public.shop_position(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.shop_employee DROP CONSTRAINT shop_employee_position_id_d359c108_fk_shop_position_id;
       public          postgres    false    226    3036    228                       2606    26969 :   shop_order shop_order_client_id_5ef2b3ba_fk_shop_client_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_client_id_5ef2b3ba_fk_shop_client_id FOREIGN KEY (client_id) REFERENCES public.shop_client(id) DEFERRABLE INITIALLY DEFERRED;
 d   ALTER TABLE ONLY public.shop_order DROP CONSTRAINT shop_order_client_id_5ef2b3ba_fk_shop_client_id;
       public          postgres    false    224    3022    236                       2606    26974 >   shop_order shop_order_employee_id_abfbf4ff_fk_shop_employee_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_employee_id_abfbf4ff_fk_shop_employee_id FOREIGN KEY (employee_id) REFERENCES public.shop_employee(id) DEFERRABLE INITIALLY DEFERRED;
 h   ALTER TABLE ONLY public.shop_order DROP CONSTRAINT shop_order_employee_id_abfbf4ff_fk_shop_employee_id;
       public          postgres    false    236    226    3030            	           2606    26979 <   shop_order shop_order_product_id_0eef2166_fk_shop_product_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_product_id_0eef2166_fk_shop_product_id FOREIGN KEY (product_id) REFERENCES public.shop_product(id) DEFERRABLE INITIALLY DEFERRED;
 f   ALTER TABLE ONLY public.shop_order DROP CONSTRAINT shop_order_product_id_0eef2166_fk_shop_product_id;
       public          postgres    false    236    3059    234                       2606    26956 B   shop_product shop_product_category_id_14d7eea8_fk_shop_category_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_category_id_14d7eea8_fk_shop_category_id FOREIGN KEY (category_id) REFERENCES public.shop_category(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.shop_product DROP CONSTRAINT shop_product_category_id_14d7eea8_fk_shop_category_id;
       public          postgres    false    234    3011    222                       2606    26961 >   shop_product shop_product_supply_id_08596c9d_fk_shop_supply_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_supply_id_08596c9d_fk_shop_supply_id FOREIGN KEY (supply_id) REFERENCES public.shop_supply(id) DEFERRABLE INITIALLY DEFERRED;
 h   ALTER TABLE ONLY public.shop_product DROP CONSTRAINT shop_product_supply_id_08596c9d_fk_shop_supply_id;
       public          postgres    false    234    232    3052                       2606    26950 @   shop_supply shop_supply_provider_id_83ec874c_fk_shop_provider_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.shop_supply
    ADD CONSTRAINT shop_supply_provider_id_83ec874c_fk_shop_provider_id FOREIGN KEY (provider_id) REFERENCES public.shop_provider(id) DEFERRABLE INITIALLY DEFERRED;
 j   ALTER TABLE ONLY public.shop_supply DROP CONSTRAINT shop_supply_provider_id_83ec874c_fk_shop_provider_id;
       public          postgres    false    3050    232    230            �   O   x���v
Q���W((M��L�K,-ɈO/�/-Ps�	uV�0�QP�M�KLO-R״��$J�!PSjnAN~ej*H r`!�      �   '  x��ֽJ�`��G�QA$�ϗ�89tH[]�р�И��9o�z/o��I��m��U��?V���5o_������4�����=L�p�������ͮ����/�r}�����š�Eq*�P\�Q�,q�(n�;Ŏ�bvm�U�s����	Y����%���Y����e�Z�2Y-i�vm��l�&kɬ��%�沖̚�Za�\�
��V�5��¬��f�e��w��f�/��)F��p%a����U��D�f+�T�Ve��J�Q�V�j��;�l%!kp%)kp%)kp%)k��'e~�-�<���.[�      �   �  x���Mk�@���ni!�,�S1>J��נJ�#P$����ʻ3��Ȇ���1<��xgu�{��x�wO�Q3�.��K:�/ύm_��+�*������c���F7����<���٪oO7��y>ΞǙ}�:;�?�����Nd?���s[�~���O +�	}j�%)���ǐ����=����_�����M>�]s��%Տm=4�����s�g�<65���5�1e!���iZ���*rA��mG0���c ��D��t�kbj�mIH�R�Iɬ���T��ScGw	Ea즁����� ��gly�π��g�s���\��tvO�� 8	D���.tW�b�qr+i��8�*+Y�������g����)�/b�	�h����U4[u��U�·��^,`x˚O
�:�L
�::�	�o:�n���+z���bb�b�	#+q����8ۆ����0݊�צ�O�|Ի��9��Y�+�����V�P�[�'lJ�������l����g�n|�x6�*}q��6�� *=�rHC�L7�}*��խBk��Y��\ȫr�d��2��ۥ�=�����2����(i�>+u���g��֠���Y)�M�+���}f�0�@S�A�bg�,v ���Jf����?u6���Qp      �   j  x���]o�@���+�0q7�t>�a��&[ݶ�ZE�z��PX(*��l7�ٚ�!�	���a�?�]O�?r�ZZz���EY��e�2ͽίg�t���	8@"L`�}�=I9�&��sm4ϵ@�rUOP�t�TJ��M��E�)~&k���R�D=D�/k�t?Y�O��T�m���`r� �3NL�����Y��q�-r#��	؃Hb}B��.���t�T{�i"�$N6��������|dJ�c�<��`z!PJaH"<A��'��2US�����Cx� f�IHMO0������4U.2=�lP�D�Q{���CU��� ��h�)��2@���E��� ��|�_� -\�ZI��oS\�l;
r���-���r͸n����l���^.��و�����n  k��5A�Ld/"���RWĲ̖Q|�!:�㘎��5��8c�u�)�B�������fo��~v��2���W��j��]���Â\70�\��_ι��}zGx*�Ų\}ܞ�Z<����=�Nz��ikr���5�a������n(�6�C����q�һ�vzK���Abaf�n ��t�Gr�������&#B":�f�=������      �   d   x���v
Q���W((M��L�K,-Ɉ/-N-�O/�/-(Vs�	uV�0�Q0�Q0Դ��$A����1��t@֑��\G��t�,t�H�e��`���  c�      �   
   x���          �   <  x�͘Mo�F����/i�z�3���(��@�I�C� `DRQ�/��#��dْ�R+��}��$����ξ�˫�/_��.�����?}�����g�r2��φٟ?������7�}�5�����B�Qì�;M/���bv3*�E|��z���(˪<ϳ�_��������g�G�c��Q�� ���������I��@y���M�Aq]g������M�ot��28Ц��)�����ҜJc�A�w�UWʃ���y=��e#�o�/'Ű:������	f�&f"^�ơ.ʢ�3�M��4��`9�a��^�}�:�B)@rw��~�E-C�'@�@���,k�!�V%�tQ7e��e��xTY��<ʰ�	��P�S*�k����M�)#Vvwq�:�-��/���B`�%�
YY7K��2�Y�͉��	��9��&�9�?!
���IUmղ��b"��~�Fy�����T&�
9ke��N�A���%�� �Ja!jk7��Sڄ�e˲����w������XiOt�e���;=Qv���;��fs[���v�n�_ * ���k@��n{_%5d�o�������)/87�A=i��"��٠����#=�8O%�����&��춪��w�;�����k�-�5)�b����Du�0����~�7��]�a�� r��9i4���1p]5m�i�&�6�Fӥ�.'ل:w ԏ��m�L��f=ϰr�e#.�Ȣ�7�!��NRc6�S���f2�c�A�58�n�i����jZ-�qVV�`1�_�f��)�K�#hcĠ�k1�σSF'+T9���&�jJ\���h�T3D�)��hr�I�c?[��D�6դ�6��l��9���ir�D��m��kBǇs�����*����`4i�5��@�L|�ܙ��FMR�����ŕ�tE{��|�f��� ���g���I��|��M�ݵ�$+�nζ���D�W�ɨi��5X.N�L����3�[�U�l��Oi�ڹCd]w��X|9c��6h��+�W�R�7�)��f�E��蟏Uu3-N��~N�f��"ģ��5^ۭ4�|1+?����}v�/P���      �   �   x���=��0 ཿ"[D���898D��U���F�ܑ��ޤ8���.��wG��yw���p92��JV��Y��h'����m��ݙ���e�J��@AL�7Y�3��w�Ƞ0��V�&@�jx$���V����xo��3A\��~,���	�*V? {�#*���Ծre�*`��u�'�#ZT�	ʌ9���%k���4q��Y�T�������!!*Y�|jE�      �   ]  x���MO�0�����h�n���8 UT*�W��5�U��$�}�e�e#K��V�wf^�syu}��&�����u��ʯ��۔��}��ۦ�~}����:� ���u�������Ӝ�7~��H�� V�d ��9W(�'B�?~9�|��q�;$4�DgҦ�ͩ(�\(LA���-���G\��;3����,����S���M_�������V�4�֯�j|T���⸋���53/���nQ�"@D��
��L�B��~N��5�}0�kʧ��%hNy�K�;	c?���:����I�1����a~���W�S�8����ٕ�ْ~��X->�1H�CL����><�nkI3�b��l�L�B����ء����`j���\>�
%Os?�X�:Z����(����
�+�*��iI�� ;	eh��d� �h^�x0c7Y��.��{�h��BPI���g�ևw�_J��4���w/!�r�*M4$�;�^�vo�t�@�S���$F��u>C`z�"_��"�!-�,��
�I~B���5U���\��)-V��,�R���J�3Q�O�8O*&Ҙ��#*��ZsT�>����n8+T      �   {  x���I��@ ���
n�T��M7t79��Ap��b�`���4
��L吩\2�y��ի��.��Ryq���"9t��?�|/#)����̱g-�Oϡ��Q����KJ��Ox��%:��_��n�ڮR˚4�9�G���gr�\�F91W&t��!��=
���q�*6��i$�'���{��r�Y�v/��^�^wlt:o 8�(�ɱ�V��#sV��;t�񢟹-߁�gl �E������M���%���q�ᆘ}7��R�d�i�S/?�F�^�ow���4��A/��vs�b�-�*PA���U5��J� �����˿�&A#� �:D��Qǲ�A�e���AY�j�b}?��`w�jR��%S��ΐ=vF�_����;V�ƪ�t1eLS?ΊK1!�7��U|�AĥmA.@���lN���Ae��f�YP=��d�V%q��/p��s�=+U 0�j`�e:f���ęz�AH��I��~u����+r��b9����ܶ{�>Du�L�t)�ږ��aѩ�NX;�M��f�o'��L�8���Cޢ"O��$����(��=(��>4z�����k�zr��5C<�:����L�h�Q�?YU�@lh��P�����7�����$U      �   �   x���O�@��~��Y���:u� �AZט�k]R�:��ۍ���{/ˋ�XB���^W{��rk�K�O]��λ�)-`� ��ӆ�6h,7�J�|1à��� H0\n��_�x��ֵ~�-i��Y�H�o�]��0"��w�iJ�B�I(5���HɄ�xR| ﵃n      �   :  x���AO�0���+���l1��6��E#�����PZ��믷-f��A�6�7���2m��맭�f��;�qV,u-�ׂ3{o��^��Yx����Բ�M��:	+2ր�J�����h;��m���b�\�$&��AL�k� Jj��7����Vt֞�x�g��x25�'3�#c�q�]��55p��G'sh��1�I�d����-��\��)�w����~0ēa8b�g0�����Y#��9h)�s&���p΃$�HA�fQ%5��UP�P[;m�m{��|��w�K7=��1�!����`���      �   %  x���OO�@��|���h�ۥ,ċ94hI����,eB'mw���o���A{ټ�d�/o^m���x��6�dT�T~BQ��xo����ƻ�o��|/k94�
Y�N�eI9��*74?a��/$棄
���"���>�bj��~��̍�u�~M;$E�^0K~�g��L���1XV��b��d��G�{��	��]�3�,��,4���^K�;st+#̤"M-&�O:;O��w��=��{�����T�Fgxc��ҙ����Y_�p��~I
�w�W
+,���N?���7v��      �   e   x���v
Q���W((M��L�+��/��/JI-Rs�	uV�0�QP7202�54�50Q��A<C �DG�XG�\Ӛ˓(�,��3UG�Z���"�q\\ n^';      �   ]   x���v
Q���W((M��L�+��/�/�/�,���Ss�	uV�0�QPO�-�ɯLMU�Q040�30д��$� #���y��E@�F0�\\ ��'      �   �   x���M�0�b7���|�S��v�RKA��I_���Y�к�?<�x��t� N[@�k]efWbr&-�����&9F{�p�O���7-�2/����p3d�1I��	�h�`S�r��?"�@\	�rě#l�U@�@�A���6S@<�x��H0Gl�( �@|	�s$���V@�$���JQi>J(Q��_*�[P(�0�pr��˰[���#c�����n��GS�Kn���bg\�v����{д'���      �   �   x���v
Q���W((M��L�+��/�/(�/�LI-Rs�	uV�0�QP�	�9E�E�ũy%�%�e�`�����C#c�tC/9?$�mlnjllijb`lhHLI�,64P״��$�FH0�t��Lp8��� pq �BN�      �   j   x���v
Q���W((M��L�+��/�/.-(ȩTs�	uV�0�QP720��54�54R�Q0Դ��$N�\�D��z���5$M�	L�����)in6��k�p3 ��S(     