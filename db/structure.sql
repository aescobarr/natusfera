--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: box2d; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE box2d;


--
-- Name: box2d_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2d_in(cstring) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX2D_in';


--
-- Name: box2d_out(box2d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2d_out(box2d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX2D_out';


--
-- Name: box2d; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE box2d (
    INTERNALLENGTH = 65,
    INPUT = box2d_in,
    OUTPUT = box2d_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


--
-- Name: TYPE box2d; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE box2d IS 'postgis type: A box composed of x min, ymin, xmax, ymax. Often used to return the 2d enclosing box of a geometry.';


--
-- Name: box2df; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE box2df;


--
-- Name: box2df_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2df_in(cstring) RETURNS box2df
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'box2df_in';


--
-- Name: box2df_out(box2df); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2df_out(box2df) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'box2df_out';


--
-- Name: box2df; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE box2df (
    INTERNALLENGTH = 16,
    INPUT = box2df_in,
    OUTPUT = box2df_out,
    ALIGNMENT = double,
    STORAGE = plain
);


--
-- Name: box3d; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE box3d;


--
-- Name: box3d_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d_in(cstring) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_in';


--
-- Name: box3d_out(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d_out(box3d) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_out';


--
-- Name: box3d; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE box3d (
    INTERNALLENGTH = 52,
    INPUT = box3d_in,
    OUTPUT = box3d_out,
    ALIGNMENT = double,
    STORAGE = plain
);


--
-- Name: TYPE box3d; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE box3d IS 'postgis type: A box composed of x min, ymin, zmin, xmax, ymax, zmax. Often used to return the 3d extent of a geometry or collection of geometries.';


--
-- Name: geography; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE geography;


--
-- Name: geography_analyze(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_analyze(internal) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/postgis-2.0', 'geography_analyze';


--
-- Name: geography_in(cstring, oid, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_in(cstring, oid, integer) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_in';


--
-- Name: geography_out(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_out(geography) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_out';


--
-- Name: geography_recv(internal, oid, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_recv(internal, oid, integer) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_recv';


--
-- Name: geography_send(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_send(geography) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_send';


--
-- Name: geography_typmod_in(cstring[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_typmod_in(cstring[]) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_typmod_in';


--
-- Name: geography_typmod_out(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_typmod_out(integer) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'postgis_typmod_out';


--
-- Name: geography; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE geography (
    INTERNALLENGTH = variable,
    INPUT = geography_in,
    OUTPUT = geography_out,
    RECEIVE = geography_recv,
    SEND = geography_send,
    TYPMOD_IN = geography_typmod_in,
    TYPMOD_OUT = geography_typmod_out,
    ANALYZE = geography_analyze,
    DELIMITER = ':',
    ALIGNMENT = double,
    STORAGE = main
);


--
-- Name: TYPE geography; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE geography IS 'postgis type: Ellipsoidal spatial data type.';


--
-- Name: geometry; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE geometry;


--
-- Name: geometry_analyze(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_analyze(internal) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/postgis-2.0', 'geometry_analyze_2d';


--
-- Name: geometry_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_in(cstring) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_in';


--
-- Name: geometry_out(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_out(geometry) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_out';


--
-- Name: geometry_recv(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_recv(internal) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_recv';


--
-- Name: geometry_send(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_send(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_send';


--
-- Name: geometry_typmod_in(cstring[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_typmod_in(cstring[]) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geometry_typmod_in';


--
-- Name: geometry_typmod_out(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_typmod_out(integer) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'postgis_typmod_out';


--
-- Name: geometry; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE geometry (
    INTERNALLENGTH = variable,
    INPUT = geometry_in,
    OUTPUT = geometry_out,
    RECEIVE = geometry_recv,
    SEND = geometry_send,
    TYPMOD_IN = geometry_typmod_in,
    TYPMOD_OUT = geometry_typmod_out,
    ANALYZE = geometry_analyze,
    DELIMITER = ':',
    ALIGNMENT = double,
    STORAGE = main
);


--
-- Name: TYPE geometry; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE geometry IS 'postgis type: Planar spatial data type.';


--
-- Name: geometry_dump; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE geometry_dump AS (
	path integer[],
	geom geometry
);


--
-- Name: TYPE geometry_dump; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE geometry_dump IS 'postgis type: A spatial datatype with two fields - geom (holding a geometry object) and path[] (a 1-d array holding the position of the geometry within the dumped object.)';


--
-- Name: geomval; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE geomval AS (
	geom geometry,
	val double precision
);


--
-- Name: TYPE geomval; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE geomval IS 'postgis raster type: A spatial datatype with two fields - geom (holding a geometry object) and val (holding a double precision pixel value from a raster band).';


--
-- Name: gidx; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE gidx;


--
-- Name: gidx_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gidx_in(cstring) RETURNS gidx
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gidx_in';


--
-- Name: gidx_out(gidx); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gidx_out(gidx) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gidx_out';


--
-- Name: gidx; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE gidx (
    INTERNALLENGTH = variable,
    INPUT = gidx_in,
    OUTPUT = gidx_out,
    ALIGNMENT = double,
    STORAGE = plain
);


--
-- Name: histogram; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE histogram AS (
	min double precision,
	max double precision,
	count bigint,
	percent double precision
);


--
-- Name: TYPE histogram; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE histogram IS 'postgis raster type: A composite type used as record output of the ST_Histogram and ST_ApproxHistogram functions.';


--
-- Name: pgis_abs; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE pgis_abs;


--
-- Name: pgis_abs_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_abs_in(cstring) RETURNS pgis_abs
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'pgis_abs_in';


--
-- Name: pgis_abs_out(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_abs_out(pgis_abs) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'pgis_abs_out';


--
-- Name: pgis_abs; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE pgis_abs (
    INTERNALLENGTH = 8,
    INPUT = pgis_abs_in,
    OUTPUT = pgis_abs_out,
    ALIGNMENT = double,
    STORAGE = plain
);


--
-- Name: quantile; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE quantile AS (
	quantile double precision,
	value double precision
);


--
-- Name: raster; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE raster;


--
-- Name: raster_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_in(cstring) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_in';


--
-- Name: raster_out(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_out(raster) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_out';


--
-- Name: raster; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE raster (
    INTERNALLENGTH = variable,
    INPUT = raster_in,
    OUTPUT = raster_out,
    ALIGNMENT = double,
    STORAGE = extended
);


--
-- Name: TYPE raster; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE raster IS 'postgis raster type: raster spatial data type.';


--
-- Name: reclassarg; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE reclassarg AS (
	nband integer,
	reclassexpr text,
	pixeltype text,
	nodataval double precision
);


--
-- Name: TYPE reclassarg; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE reclassarg IS 'postgis raster type: A composite type used as input into the ST_Reclass function defining the behavior of reclassification.';


--
-- Name: spheroid; Type: SHELL TYPE; Schema: public; Owner: -
--

CREATE TYPE spheroid;


--
-- Name: spheroid_in(cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION spheroid_in(cstring) RETURNS spheroid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ellipsoid_in';


--
-- Name: spheroid_out(spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION spheroid_out(spheroid) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ellipsoid_out';


--
-- Name: spheroid; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE spheroid (
    INTERNALLENGTH = 65,
    INPUT = spheroid_in,
    OUTPUT = spheroid_out,
    ALIGNMENT = double,
    STORAGE = plain
);


--
-- Name: summarystats; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE summarystats AS (
	count bigint,
	sum double precision,
	mean double precision,
	stddev double precision,
	min double precision,
	max double precision
);


--
-- Name: TYPE summarystats; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TYPE summarystats IS 'postgis raster type: A composite type used as output of the ST_SummaryStats function.';


--
-- Name: valid_detail; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE valid_detail AS (
	valid boolean,
	reason character varying,
	location geometry
);


--
-- Name: valuecount; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE valuecount AS (
	value double precision,
	count integer,
	percent double precision
);


--
-- Name: _add_overview_constraint(name, name, name, name, name, name, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_overview_constraint(ovschema name, ovtable name, ovcolumn name, refschema name, reftable name, refcolumn name, factor integer) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
	BEGIN
		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_overview_' || $3;

		sql := 'ALTER TABLE ' || fqtn
			|| ' ADD CONSTRAINT ' || quote_ident(cn)
			|| ' CHECK (_overview_constraint(' || quote_ident($3)
			|| ',' || $7
			|| ',' || quote_literal($4)
			|| ',' || quote_literal($5)
			|| ',' || quote_literal($6)
			|| '))';

		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _add_raster_constraint(name, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint(cn name, sql text) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $$
	BEGIN
		BEGIN
			EXECUTE sql;
		EXCEPTION
			WHEN duplicate_object THEN
				RAISE NOTICE 'The constraint "%" already exists.  To replace the existing constraint, delete the constraint and call ApplyRasterConstraints again', cn;
			WHEN OTHERS THEN
				RAISE NOTICE 'Unable to add constraint "%"', cn;
				RETURN FALSE;
		END;

		RETURN TRUE;
	END;
	$$;


--
-- Name: _add_raster_constraint_alignment(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint_alignment(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
		attr text;
	BEGIN
		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_same_alignment_' || $3;

		sql := 'SELECT st_makeemptyraster(1, 1, upperleftx, upperlefty, scalex, scaley, skewx, skewy, srid) FROM st_metadata((SELECT '
			|| quote_ident($3)
			|| ' FROM ' || fqtn || ' LIMIT 1))';
		BEGIN
			EXECUTE sql INTO attr;
		EXCEPTION WHEN OTHERS THEN
			RAISE NOTICE 'Unable to get the alignment of a sample raster';
			RETURN FALSE;
		END;

		sql := 'ALTER TABLE ' || fqtn ||
			' ADD CONSTRAINT ' || quote_ident(cn) ||
			' CHECK (st_samealignment(' || quote_ident($3) || ', ''' || attr || '''::raster))';
		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _add_raster_constraint_blocksize(name, name, name, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint_blocksize(rastschema name, rasttable name, rastcolumn name, axis text) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
		attr int;
	BEGIN
		IF lower($4) != 'width' AND lower($4) != 'height' THEN
			RAISE EXCEPTION 'axis must be either "width" or "height"';
			RETURN FALSE;
		END IF;

		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_' || $4 || '_' || $3;

		sql := 'SELECT st_' || $4 || '('
			|| quote_ident($3)
			|| ') FROM ' || fqtn
			|| ' LIMIT 1';
		BEGIN
			EXECUTE sql INTO attr;
		EXCEPTION WHEN OTHERS THEN
			RAISE NOTICE 'Unable to get the % of a sample raster', $4;
			RETURN FALSE;
		END;

		sql := 'ALTER TABLE ' || fqtn
			|| ' ADD CONSTRAINT ' || quote_ident(cn)
			|| ' CHECK (st_' || $4 || '('
			|| quote_ident($3)
			|| ') = ' || attr || ')';
		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _add_raster_constraint_extent(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint_extent(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
		attr text;
	BEGIN
		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_max_extent_' || $3;

		sql := 'SELECT st_ashexewkb(st_convexhull(st_collect(st_convexhull('
			|| quote_ident($3)
			|| ')))) FROM '
			|| fqtn;
		BEGIN
			EXECUTE sql INTO attr;
		EXCEPTION WHEN OTHERS THEN
			RAISE NOTICE 'Unable to get the extent of a sample raster';
			RETURN FALSE;
		END;

		sql := 'ALTER TABLE ' || fqtn
			|| ' ADD CONSTRAINT ' || quote_ident(cn)
			|| ' CHECK (st_coveredby(st_convexhull('
			|| quote_ident($3)
			|| '), ''' || attr || '''::geometry))';
		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _add_raster_constraint_nodata_values(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint_nodata_values(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
		attr double precision[];
		max int;
	BEGIN
		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_nodata_values_' || $3;

		sql := 'SELECT _raster_constraint_nodata_values(' || quote_ident($3)
			|| ') FROM ' || fqtn
			|| ' LIMIT 1';
		BEGIN
			EXECUTE sql INTO attr;
		EXCEPTION WHEN OTHERS THEN
			RAISE NOTICE 'Unable to get the nodata values of a sample raster';
			RETURN FALSE;
		END;
		max := array_length(attr, 1);
		IF max < 1 OR max IS NULL THEN
			RAISE NOTICE 'Unable to get the nodata values of a sample raster';
			RETURN FALSE;
		END IF;

		sql := 'ALTER TABLE ' || fqtn
			|| ' ADD CONSTRAINT ' || quote_ident(cn)
			|| ' CHECK (_raster_constraint_nodata_values(' || quote_ident($3)
			|| ')::numeric(16,10)[] = ''{';
		FOR x in 1..max LOOP
			IF attr[x] IS NULL THEN
				sql := sql || 'NULL';
			ELSE
				sql := sql || attr[x];
			END IF;
			IF x < max THEN
				sql := sql || ',';
			END IF;
		END LOOP;
		sql := sql || '}''::numeric(16,10)[])';

		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _add_raster_constraint_num_bands(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint_num_bands(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
		attr int;
	BEGIN
		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_num_bands_' || $3;

		sql := 'SELECT st_numbands(' || quote_ident($3)
			|| ') FROM ' || fqtn
			|| ' LIMIT 1';
		BEGIN
			EXECUTE sql INTO attr;
		EXCEPTION WHEN OTHERS THEN
			RAISE NOTICE 'Unable to get the number of bands of a sample raster';
			RETURN FALSE;
		END;

		sql := 'ALTER TABLE ' || fqtn
			|| ' ADD CONSTRAINT ' || quote_ident(cn)
			|| ' CHECK (st_numbands(' || quote_ident($3)
			|| ') = ' || attr
			|| ')';
		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _add_raster_constraint_out_db(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint_out_db(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
		attr boolean[];
		max int;
	BEGIN
		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_out_db_' || $3;

		sql := 'SELECT _raster_constraint_out_db(' || quote_ident($3)
			|| ') FROM ' || fqtn
			|| ' LIMIT 1';
		BEGIN
			EXECUTE sql INTO attr;
		EXCEPTION WHEN OTHERS THEN
			RAISE NOTICE 'Unable to get the out-of-database bands of a sample raster';
			RETURN FALSE;
		END;
		max := array_length(attr, 1);
		IF max < 1 OR max IS NULL THEN
			RAISE NOTICE 'Unable to get the out-of-database bands of a sample raster';
			RETURN FALSE;
		END IF;

		sql := 'ALTER TABLE ' || fqtn
			|| ' ADD CONSTRAINT ' || quote_ident(cn)
			|| ' CHECK (_raster_constraint_out_db(' || quote_ident($3)
			|| ') = ''{';
		FOR x in 1..max LOOP
			IF attr[x] IS FALSE THEN
				sql := sql || 'FALSE';
			ELSE
				sql := sql || 'TRUE';
			END IF;
			IF x < max THEN
				sql := sql || ',';
			END IF;
		END LOOP;
		sql := sql || '}''::boolean[])';

		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _add_raster_constraint_pixel_types(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint_pixel_types(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
		attr text[];
		max int;
	BEGIN
		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_pixel_types_' || $3;

		sql := 'SELECT _raster_constraint_pixel_types(' || quote_ident($3)
			|| ') FROM ' || fqtn
			|| ' LIMIT 1';
		BEGIN
			EXECUTE sql INTO attr;
		EXCEPTION WHEN OTHERS THEN
			RAISE NOTICE 'Unable to get the pixel types of a sample raster';
			RETURN FALSE;
		END;
		max := array_length(attr, 1);
		IF max < 1 OR max IS NULL THEN
			RAISE NOTICE 'Unable to get the pixel types of a sample raster';
			RETURN FALSE;
		END IF;

		sql := 'ALTER TABLE ' || fqtn
			|| ' ADD CONSTRAINT ' || quote_ident(cn)
			|| ' CHECK (_raster_constraint_pixel_types(' || quote_ident($3)
			|| ') = ''{';
		FOR x in 1..max LOOP
			sql := sql || '"' || attr[x] || '"';
			IF x < max THEN
				sql := sql || ',';
			END IF;
		END LOOP;
		sql := sql || '}''::text[])';

		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _add_raster_constraint_regular_blocking(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint_regular_blocking(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
	BEGIN

		RAISE INFO 'The regular_blocking constraint is just a flag indicating that the column "%" is regularly blocked.  It is up to the end-user to ensure that the column is truely regularly blocked.', quote_ident($3);

		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_regular_blocking_' || $3;

		sql := 'ALTER TABLE ' || fqtn
			|| ' ADD CONSTRAINT ' || quote_ident(cn)
			|| ' CHECK (TRUE)';
		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _add_raster_constraint_scale(name, name, name, character); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint_scale(rastschema name, rasttable name, rastcolumn name, axis character) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
		attr double precision;
	BEGIN
		IF lower($4) != 'x' AND lower($4) != 'y' THEN
			RAISE EXCEPTION 'axis must be either "x" or "y"';
			RETURN FALSE;
		END IF;

		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_scale' || $4 || '_' || $3;

		sql := 'SELECT st_scale' || $4 || '('
			|| quote_ident($3)
			|| ') FROM '
			|| fqtn
			|| ' LIMIT 1';
		BEGIN
			EXECUTE sql INTO attr;
		EXCEPTION WHEN OTHERS THEN
			RAISE NOTICE 'Unable to get the %-scale of a sample raster', upper($4);
			RETURN FALSE;
		END;

		sql := 'ALTER TABLE ' || fqtn
			|| ' ADD CONSTRAINT ' || quote_ident(cn)
			|| ' CHECK (st_scale' || $4 || '('
			|| quote_ident($3)
			|| ')::numeric(16,10) = (' || attr || ')::numeric(16,10))';
		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _add_raster_constraint_srid(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _add_raster_constraint_srid(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
		cn name;
		sql text;
		attr int;
	BEGIN
		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		cn := 'enforce_srid_' || $3;

		sql := 'SELECT st_srid('
			|| quote_ident($3)
			|| ') FROM ' || fqtn
			|| ' LIMIT 1';
		BEGIN
			EXECUTE sql INTO attr;
		EXCEPTION WHEN OTHERS THEN
			RAISE NOTICE 'Unable to get the SRID of a sample raster';
			RETURN FALSE;
		END;

		sql := 'ALTER TABLE ' || fqtn
			|| ' ADD CONSTRAINT ' || quote_ident(cn)
			|| ' CHECK (st_srid('
			|| quote_ident($3)
			|| ') = ' || attr || ')';

		RETURN _add_raster_constraint(cn, sql);
	END;
	$_$;


--
-- Name: _drop_overview_constraint(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_overview_constraint(ovschema name, ovtable name, ovcolumn name) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT _drop_raster_constraint($1, $2, 'enforce_overview_' || $3) $_$;


--
-- Name: _drop_raster_constraint(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint(rastschema name, rasttable name, cn name) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		fqtn text;
	BEGIN
		fqtn := '';
		IF length($1) > 0 THEN
			fqtn := quote_ident($1) || '.';
		END IF;
		fqtn := fqtn || quote_ident($2);

		BEGIN
			EXECUTE 'ALTER TABLE '
				|| fqtn
				|| ' DROP CONSTRAINT '
				|| quote_ident(cn);
			RETURN TRUE;
		EXCEPTION
			WHEN undefined_object THEN
				RAISE NOTICE 'The constraint "%" does not exist.  Skipping', cn;
			WHEN OTHERS THEN
				RAISE NOTICE 'Unable to drop constraint "%"', cn;
				RETURN FALSE;
		END;

		RETURN TRUE;
	END;
	$_$;


--
-- Name: _drop_raster_constraint_alignment(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint_alignment(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT _drop_raster_constraint($1, $2, 'enforce_same_alignment_' || $3) $_$;


--
-- Name: _drop_raster_constraint_blocksize(name, name, name, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint_blocksize(rastschema name, rasttable name, rastcolumn name, axis text) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	BEGIN
		IF lower($4) != 'width' AND lower($4) != 'height' THEN
			RAISE EXCEPTION 'axis must be either "width" or "height"';
			RETURN FALSE;
		END IF;

		RETURN _drop_raster_constraint($1, $2, 'enforce_' || $4 || '_' || $3);
	END;
	$_$;


--
-- Name: _drop_raster_constraint_extent(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint_extent(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT _drop_raster_constraint($1, $2, 'enforce_max_extent_' || $3) $_$;


--
-- Name: _drop_raster_constraint_nodata_values(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint_nodata_values(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT _drop_raster_constraint($1, $2, 'enforce_nodata_values_' || $3) $_$;


--
-- Name: _drop_raster_constraint_num_bands(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint_num_bands(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT _drop_raster_constraint($1, $2, 'enforce_num_bands_' || $3) $_$;


--
-- Name: _drop_raster_constraint_out_db(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint_out_db(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT _drop_raster_constraint($1, $2, 'enforce_out_db_' || $3) $_$;


--
-- Name: _drop_raster_constraint_pixel_types(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint_pixel_types(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT _drop_raster_constraint($1, $2, 'enforce_pixel_types_' || $3) $_$;


--
-- Name: _drop_raster_constraint_regular_blocking(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint_regular_blocking(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT _drop_raster_constraint($1, $2, 'enforce_regular_blocking_' || $3) $_$;


--
-- Name: _drop_raster_constraint_scale(name, name, name, character); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint_scale(rastschema name, rasttable name, rastcolumn name, axis character) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	BEGIN
		IF lower($4) != 'x' AND lower($4) != 'y' THEN
			RAISE EXCEPTION 'axis must be either "x" or "y"';
			RETURN FALSE;
		END IF;

		RETURN _drop_raster_constraint($1, $2, 'enforce_scale' || $4 || '_' || $3);
	END;
	$_$;


--
-- Name: _drop_raster_constraint_srid(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _drop_raster_constraint_srid(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT _drop_raster_constraint($1, $2, 'enforce_srid_' || $3) $_$;


--
-- Name: _overview_constraint(raster, integer, name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _overview_constraint(ov raster, factor integer, refschema name, reftable name, refcolumn name) RETURNS boolean
    LANGUAGE sql STABLE
    AS $_$ SELECT COALESCE((SELECT TRUE FROM raster_columns WHERE r_table_catalog = current_database() AND r_table_schema = $3 AND r_table_name = $4 AND r_raster_column = $5), FALSE) $_$;


--
-- Name: _overview_constraint_info(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _overview_constraint_info(ovschema name, ovtable name, ovcolumn name, OUT refschema name, OUT reftable name, OUT refcolumn name, OUT factor integer) RETURNS record
    LANGUAGE sql STABLE STRICT
    AS $_$
	SELECT
		split_part(split_part(s.consrc, '''::name', 1), '''', 2)::name,
		split_part(split_part(s.consrc, '''::name', 2), '''', 2)::name,
		split_part(split_part(s.consrc, '''::name', 3), '''', 2)::name,
		trim(both from split_part(s.consrc, ',', 2))::integer
	FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
	WHERE n.nspname = $1
		AND c.relname = $2
		AND a.attname = $3
		AND a.attrelid = c.oid
		AND s.connamespace = n.oid
		AND s.conrelid = c.oid
		AND a.attnum = ANY (s.conkey)
		AND s.consrc LIKE '%_overview_constraint(%'
	$_$;


--
-- Name: _raster_constraint_info_alignment(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_info_alignment(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE sql STABLE STRICT
    AS $_$
	SELECT
		TRUE
	FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
	WHERE n.nspname = $1
		AND c.relname = $2
		AND a.attname = $3
		AND a.attrelid = c.oid
		AND s.connamespace = n.oid
		AND s.conrelid = c.oid
		AND a.attnum = ANY (s.conkey)
		AND s.consrc LIKE '%st_samealignment(%';
	$_$;


--
-- Name: _raster_constraint_info_blocksize(name, name, name, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_info_blocksize(rastschema name, rasttable name, rastcolumn name, axis text) RETURNS integer
    LANGUAGE sql STABLE STRICT
    AS $_$
	SELECT
		replace(replace(split_part(s.consrc, ' = ', 2), ')', ''), '(', '')::integer
	FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
	WHERE n.nspname = $1
		AND c.relname = $2
		AND a.attname = $3
		AND a.attrelid = c.oid
		AND s.connamespace = n.oid
		AND s.conrelid = c.oid
		AND a.attnum = ANY (s.conkey)
		AND s.consrc LIKE '%st_' || $4 || '(% = %';
	$_$;


--
-- Name: _raster_constraint_info_extent(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_info_extent(rastschema name, rasttable name, rastcolumn name) RETURNS geometry
    LANGUAGE sql STABLE STRICT
    AS $_$
	SELECT
		trim(both '''' from split_part(trim(split_part(s.consrc, ',', 2)), '::', 1))::geometry
	FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
	WHERE n.nspname = $1
		AND c.relname = $2
		AND a.attname = $3
		AND a.attrelid = c.oid
		AND s.connamespace = n.oid
		AND s.conrelid = c.oid
		AND a.attnum = ANY (s.conkey)
		AND s.consrc LIKE '%st_coveredby(st_convexhull(%';
	$_$;


--
-- Name: _raster_constraint_info_nodata_values(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_info_nodata_values(rastschema name, rasttable name, rastcolumn name) RETURNS double precision[]
    LANGUAGE sql STABLE STRICT
    AS $_$
	SELECT
		trim(both '''' from split_part(replace(replace(split_part(s.consrc, ' = ', 2), ')', ''), '(', ''), '::', 1))::double precision[]
	FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
	WHERE n.nspname = $1
		AND c.relname = $2
		AND a.attname = $3
		AND a.attrelid = c.oid
		AND s.connamespace = n.oid
		AND s.conrelid = c.oid
		AND a.attnum = ANY (s.conkey)
		AND s.consrc LIKE '%_raster_constraint_nodata_values(%';
	$_$;


--
-- Name: _raster_constraint_info_num_bands(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_info_num_bands(rastschema name, rasttable name, rastcolumn name) RETURNS integer
    LANGUAGE sql STABLE STRICT
    AS $_$
	SELECT
		replace(replace(split_part(s.consrc, ' = ', 2), ')', ''), '(', '')::integer
	FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
	WHERE n.nspname = $1
		AND c.relname = $2
		AND a.attname = $3
		AND a.attrelid = c.oid
		AND s.connamespace = n.oid
		AND s.conrelid = c.oid
		AND a.attnum = ANY (s.conkey)
		AND s.consrc LIKE '%st_numbands(%';
	$_$;


--
-- Name: _raster_constraint_info_out_db(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_info_out_db(rastschema name, rasttable name, rastcolumn name) RETURNS boolean[]
    LANGUAGE sql STABLE STRICT
    AS $_$
	SELECT
		trim(both '''' from split_part(replace(replace(split_part(s.consrc, ' = ', 2), ')', ''), '(', ''), '::', 1))::boolean[]
	FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
	WHERE n.nspname = $1
		AND c.relname = $2
		AND a.attname = $3
		AND a.attrelid = c.oid
		AND s.connamespace = n.oid
		AND s.conrelid = c.oid
		AND a.attnum = ANY (s.conkey)
		AND s.consrc LIKE '%_raster_constraint_out_db(%';
	$_$;


--
-- Name: _raster_constraint_info_pixel_types(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_info_pixel_types(rastschema name, rasttable name, rastcolumn name) RETURNS text[]
    LANGUAGE sql STABLE STRICT
    AS $_$
	SELECT
		trim(both '''' from split_part(replace(replace(split_part(s.consrc, ' = ', 2), ')', ''), '(', ''), '::', 1))::text[]
	FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
	WHERE n.nspname = $1
		AND c.relname = $2
		AND a.attname = $3
		AND a.attrelid = c.oid
		AND s.connamespace = n.oid
		AND s.conrelid = c.oid
		AND a.attnum = ANY (s.conkey)
		AND s.consrc LIKE '%_raster_constraint_pixel_types(%';
	$_$;


--
-- Name: _raster_constraint_info_regular_blocking(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_info_regular_blocking(rastschema name, rasttable name, rastcolumn name) RETURNS boolean
    LANGUAGE plpgsql STABLE STRICT
    AS $_$
	DECLARE
		cn text;
		sql text;
		rtn boolean;
	BEGIN
		cn := 'enforce_regular_blocking_' || $3;

		sql := 'SELECT TRUE FROM pg_class c, pg_namespace n, pg_constraint s'
			|| ' WHERE n.nspname = ' || quote_literal($1)
			|| ' AND c.relname = ' || quote_literal($2)
			|| ' AND s.connamespace = n.oid AND s.conrelid = c.oid'
			|| ' AND s.conname = ' || quote_literal(cn);
		EXECUTE sql INTO rtn;
		RETURN rtn;
	END;
	$_$;


--
-- Name: _raster_constraint_info_scale(name, name, name, character); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_info_scale(rastschema name, rasttable name, rastcolumn name, axis character) RETURNS double precision
    LANGUAGE sql STABLE STRICT
    AS $_$
	SELECT
		replace(replace(split_part(split_part(s.consrc, ' = ', 2), '::', 1), ')', ''), '(', '')::double precision
	FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
	WHERE n.nspname = $1
		AND c.relname = $2
		AND a.attname = $3
		AND a.attrelid = c.oid
		AND s.connamespace = n.oid
		AND s.conrelid = c.oid
		AND a.attnum = ANY (s.conkey)
		AND s.consrc LIKE '%st_scale' || $4 || '(% = %';
	$_$;


--
-- Name: _raster_constraint_info_srid(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_info_srid(rastschema name, rasttable name, rastcolumn name) RETURNS integer
    LANGUAGE sql STABLE STRICT
    AS $_$
	SELECT
		replace(replace(split_part(s.consrc, ' = ', 2), ')', ''), '(', '')::integer
	FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
	WHERE n.nspname = $1
		AND c.relname = $2
		AND a.attname = $3
		AND a.attrelid = c.oid
		AND s.connamespace = n.oid
		AND s.conrelid = c.oid
		AND a.attnum = ANY (s.conkey)
		AND s.consrc LIKE '%st_srid(% = %';
	$_$;


--
-- Name: _raster_constraint_nodata_values(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_nodata_values(rast raster) RETURNS double precision[]
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT array_agg(nodatavalue)::double precision[] FROM st_bandmetadata($1, ARRAY[]::int[]); $_$;


--
-- Name: _raster_constraint_out_db(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_out_db(rast raster) RETURNS boolean[]
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT array_agg(isoutdb)::boolean[] FROM st_bandmetadata($1, ARRAY[]::int[]); $_$;


--
-- Name: _raster_constraint_pixel_types(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _raster_constraint_pixel_types(rast raster) RETURNS text[]
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT array_agg(pixeltype)::text[] FROM st_bandmetadata($1, ARRAY[]::int[]); $_$;


--
-- Name: _st_3ddfullywithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_3ddfullywithin(geom1 geometry, geom2 geometry, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_dfullywithin3d';


--
-- Name: _st_3ddwithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_3ddwithin(geom1 geometry, geom2 geometry, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_dwithin3d';


--
-- Name: _st_asgeojson(integer, geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_asgeojson(integer, geometry, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asGeoJson';


--
-- Name: _st_asgeojson(integer, geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_asgeojson(integer, geography, integer, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_as_geojson';


--
-- Name: _st_asgml(integer, geometry, integer, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_asgml(integer, geometry, integer, integer, text) RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'LWGEOM_asGML';


--
-- Name: _st_asgml(integer, geography, integer, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_asgml(integer, geography, integer, integer, text) RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'geography_as_gml';


--
-- Name: _st_askml(integer, geometry, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_askml(integer, geometry, integer, text) RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'LWGEOM_asKML';


--
-- Name: _st_askml(integer, geography, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_askml(integer, geography, integer, text) RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'geography_as_kml';


--
-- Name: _st_aspect4ma(double precision[], text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_aspect4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        pwidth float;
        pheight float;
        dz_dx float;
        dz_dy float;
        aspect float;
    BEGIN
        pwidth := args[1]::float;
        pheight := args[2]::float;
        dz_dx := ((matrix[3][1] + 2.0 * matrix[3][2] + matrix[3][3]) - (matrix[1][1] + 2.0 * matrix[1][2] + matrix[1][3])) / (8.0 * pwidth);
        dz_dy := ((matrix[1][3] + 2.0 * matrix[2][3] + matrix[3][3]) - (matrix[1][1] + 2.0 * matrix[2][1] + matrix[3][1])) / (8.0 * pheight);
        IF abs(dz_dx) = 0::float AND abs(dz_dy) = 0::float THEN
            RETURN -1;
        END IF;

        aspect := atan2(dz_dy, -dz_dx);
        IF aspect > (pi() / 2.0) THEN
            RETURN (5.0 * pi() / 2.0) - aspect;
        ELSE
            RETURN (pi() / 2.0) - aspect;
        END IF;
    END;
    $$;


--
-- Name: _st_asraster(geometry, double precision, double precision, integer, integer, text[], double precision[], double precision[], double precision, double precision, double precision, double precision, double precision, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_asraster(geom geometry, scalex double precision DEFAULT 0, scaley double precision DEFAULT 0, width integer DEFAULT 0, height integer DEFAULT 0, pixeltype text[] DEFAULT ARRAY['8BUI'::text], value double precision[] DEFAULT ARRAY[(1)::double precision], nodataval double precision[] DEFAULT ARRAY[(0)::double precision], upperleftx double precision DEFAULT NULL::double precision, upperlefty double precision DEFAULT NULL::double precision, gridx double precision DEFAULT NULL::double precision, gridy double precision DEFAULT NULL::double precision, skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, touched boolean DEFAULT false) RETURNS raster
    LANGUAGE c STABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_asRaster';


--
-- Name: _st_asx3d(integer, geometry, integer, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_asx3d(integer, geometry, integer, integer, text) RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'LWGEOM_asX3D';


--
-- Name: _st_bestsrid(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_bestsrid(geography) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_BestSRID($1,$1)$_$;


--
-- Name: _st_bestsrid(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_bestsrid(geography, geography) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_bestsrid';


--
-- Name: _st_buffer(geometry, double precision, cstring); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_buffer(geometry, double precision, cstring) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'buffer';


--
-- Name: _st_concavehull(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_concavehull(param_inputgeom geometry) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
	DECLARE     
	vexhull GEOMETRY;
	var_resultgeom geometry;
	var_inputgeom geometry;
	vexring GEOMETRY;
	cavering GEOMETRY;
	cavept geometry[];
	seglength double precision;
	var_tempgeom geometry;
	scale_factor integer := 1;
	i integer;
	
	BEGIN

		-- First compute the ConvexHull of the geometry
		vexhull := ST_ConvexHull(param_inputgeom);
		var_inputgeom := param_inputgeom;
		--A point really has no concave hull
		IF ST_GeometryType(vexhull) = 'ST_Point' OR ST_GeometryType(vexHull) = 'ST_LineString' THEN
			RETURN vexhull;
		END IF;

		-- convert the hull perimeter to a linestring so we can manipulate individual points
		vexring := CASE WHEN ST_GeometryType(vexhull) = 'ST_LineString' THEN vexhull ELSE ST_ExteriorRing(vexhull) END;
		IF abs(ST_X(ST_PointN(vexring,1))) < 1 THEN --scale the geometry to prevent stupid precision errors - not sure it works so make low for now
			scale_factor := 100;
			vexring := ST_Scale(vexring, scale_factor,scale_factor);
			var_inputgeom := ST_Scale(var_inputgeom, scale_factor, scale_factor);
			--RAISE NOTICE 'Scaling';
		END IF;
		seglength := ST_Length(vexring)/least(ST_NPoints(vexring)*2,1000) ;

		vexring := ST_Segmentize(vexring, seglength);
		-- find the point on the original geom that is closest to each point of the convex hull and make a new linestring out of it.
		cavering := ST_Collect(
			ARRAY(

				SELECT 
					ST_ClosestPoint(var_inputgeom, pt ) As the_geom
					FROM (
						SELECT  ST_PointN(vexring, n ) As pt, n
							FROM 
							generate_series(1, ST_NPoints(vexring) ) As n
						) As pt
				
				)
			)
		; 
		

		var_resultgeom := ST_MakeLine(geom) 
			FROM ST_Dump(cavering) As foo;

		IF ST_IsSimple(var_resultgeom) THEN
			var_resultgeom := ST_MakePolygon(var_resultgeom);
			--RAISE NOTICE 'is Simple: %', var_resultgeom;
		ELSE 
			--RAISE NOTICE 'is not Simple: %', var_resultgeom;
			var_resultgeom := ST_ConvexHull(var_resultgeom);
		END IF;
		
		IF scale_factor > 1 THEN -- scale the result back
			var_resultgeom := ST_Scale(var_resultgeom, 1/scale_factor, 1/scale_factor);
		END IF;
		RETURN var_resultgeom;
	
	END;
$$;


--
-- Name: _st_contains(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_contains(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'contains';


--
-- Name: _st_containsproperly(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_containsproperly(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'containsproperly';


--
-- Name: _st_count(raster, integer, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_count(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 1) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
	DECLARE
		rtn bigint;
	BEGIN
		IF exclude_nodata_value IS FALSE THEN
			SELECT width * height INTO rtn FROM ST_Metadata(rast);
		ELSE
			SELECT count INTO rtn FROM _st_summarystats($1, $2, $3, $4);
		END IF;

		RETURN rtn;
	END;
	$_$;


--
-- Name: _st_count(text, text, integer, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_count(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 1) RETURNS bigint
    LANGUAGE plpgsql STABLE STRICT
    AS $_$
	DECLARE
		curs refcursor;

		ctable text;
		ccolumn text;
		rast raster;
		stats summarystats;

		rtn bigint;
		tmp bigint;
	BEGIN
		-- nband
		IF nband < 1 THEN
			RAISE WARNING 'Invalid band index (must use 1-based). Returning NULL';
			RETURN NULL;
		END IF;

		-- sample percent
		IF sample_percent < 0 OR sample_percent > 1 THEN
			RAISE WARNING 'Invalid sample percentage (must be between 0 and 1). Returning NULL';
			RETURN NULL;
		END IF;

		-- exclude_nodata_value IS TRUE
		IF exclude_nodata_value IS TRUE THEN
			SELECT count INTO rtn FROM _st_summarystats($1, $2, $3, $4, $5);
			RETURN rtn;
		END IF;

		-- clean rastertable and rastercolumn
		ctable := quote_ident(rastertable);
		ccolumn := quote_ident(rastercolumn);

		BEGIN
			OPEN curs FOR EXECUTE 'SELECT '
					|| ccolumn
					|| ' FROM '
					|| ctable
					|| ' WHERE '
					|| ccolumn
					|| ' IS NOT NULL';
		EXCEPTION
			WHEN OTHERS THEN
				RAISE WARNING 'Invalid table or column name. Returning NULL';
				RETURN NULL;
		END;

		rtn := 0;
		LOOP
			FETCH curs INTO rast;
			EXIT WHEN NOT FOUND;

			SELECT (width * height) INTO tmp FROM ST_Metadata(rast);
			rtn := rtn + tmp;
		END LOOP;

		CLOSE curs;

		RETURN rtn;
	END;
	$_$;


--
-- Name: _st_coveredby(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_coveredby(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'coveredby';


--
-- Name: _st_covers(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_covers(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'covers';


--
-- Name: _st_covers(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_covers(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'geography_covers';


--
-- Name: _st_crosses(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_crosses(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'crosses';


--
-- Name: _st_dfullywithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_dfullywithin(geom1 geometry, geom2 geometry, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_dfullywithin';


--
-- Name: _st_distance(geography, geography, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_distance(geography, geography, double precision, boolean) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'geography_distance';


--
-- Name: _st_dumppoints(geometry, integer[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_dumppoints(the_geom geometry, cur_path integer[]) RETURNS SETOF geometry_dump
    LANGUAGE plpgsql
    AS $$
DECLARE
  tmp geometry_dump;
  tmp2 geometry_dump;
  nb_points integer;
  nb_geom integer;
  i integer;
  j integer;
  g geometry;
  
BEGIN
  
  -- RAISE DEBUG '%,%', cur_path, ST_GeometryType(the_geom);

  -- Special case collections : iterate and return the DumpPoints of the geometries

  IF (ST_IsCollection(the_geom)) THEN
 
    i = 1;
    FOR tmp2 IN SELECT (ST_Dump(the_geom)).* LOOP

      FOR tmp IN SELECT * FROM _ST_DumpPoints(tmp2.geom, cur_path || tmp2.path) LOOP
	    RETURN NEXT tmp;
      END LOOP;
      i = i + 1;
      
    END LOOP;

    RETURN;
  END IF;
  

  -- Special case (POLYGON) : return the points of the rings of a polygon
  IF (ST_GeometryType(the_geom) = 'ST_Polygon') THEN

    FOR tmp IN SELECT * FROM _ST_DumpPoints(ST_ExteriorRing(the_geom), cur_path || ARRAY[1]) LOOP
      RETURN NEXT tmp;
    END LOOP;
    
    j := ST_NumInteriorRings(the_geom);
    FOR i IN 1..j LOOP
        FOR tmp IN SELECT * FROM _ST_DumpPoints(ST_InteriorRingN(the_geom, i), cur_path || ARRAY[i+1]) LOOP
          RETURN NEXT tmp;
        END LOOP;
    END LOOP;
    
    RETURN;
  END IF;

  -- Special case (TRIANGLE) : return the points of the external rings of a TRIANGLE
  IF (ST_GeometryType(the_geom) = 'ST_Triangle') THEN

    FOR tmp IN SELECT * FROM _ST_DumpPoints(ST_ExteriorRing(the_geom), cur_path || ARRAY[1]) LOOP
      RETURN NEXT tmp;
    END LOOP;
    
    RETURN;
  END IF;

    
  -- Special case (POINT) : return the point
  IF (ST_GeometryType(the_geom) = 'ST_Point') THEN

    tmp.path = cur_path || ARRAY[1];
    tmp.geom = the_geom;

    RETURN NEXT tmp;
    RETURN;

  END IF;


  -- Use ST_NumPoints rather than ST_NPoints to have a NULL value if the_geom isn't
  -- a LINESTRING, CIRCULARSTRING.
  SELECT ST_NumPoints(the_geom) INTO nb_points;

  -- This should never happen
  IF (nb_points IS NULL) THEN
    RAISE EXCEPTION 'Unexpected error while dumping geometry %', ST_AsText(the_geom);
  END IF;

  FOR i IN 1..nb_points LOOP
    tmp.path = cur_path || ARRAY[i];
    tmp.geom := ST_PointN(the_geom, i);
    RETURN NEXT tmp;
  END LOOP;
   
END
$$;


--
-- Name: _st_dwithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_dwithin(geom1 geometry, geom2 geometry, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_dwithin';


--
-- Name: _st_dwithin(geography, geography, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_dwithin(geography, geography, double precision, boolean) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'geography_dwithin';


--
-- Name: _st_equals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_equals(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_Equals';


--
-- Name: _st_expand(geography, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_expand(geography, double precision) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_expand';


--
-- Name: _st_geomfromgml(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_geomfromgml(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'geom_from_gml';


--
-- Name: _st_hillshade4ma(double precision[], text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_hillshade4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        pwidth float;
        pheight float;
        dz_dx float;
        dz_dy float;
        zenith float;
        azimuth float;
        slope float;
        aspect float;
        max_bright float;
        elevation_scale float;
    BEGIN
        pwidth := args[1]::float;
        pheight := args[2]::float;
        azimuth := (5.0 * pi() / 2.0) - args[3]::float;
        zenith := (pi() / 2.0) - args[4]::float;
        dz_dx := ((matrix[3][1] + 2.0 * matrix[3][2] + matrix[3][3]) - (matrix[1][1] + 2.0 * matrix[1][2] + matrix[1][3])) / (8.0 * pwidth);
        dz_dy := ((matrix[1][3] + 2.0 * matrix[2][3] + matrix[3][3]) - (matrix[1][1] + 2.0 * matrix[2][1] + matrix[3][1])) / (8.0 * pheight);
        elevation_scale := args[6]::float;
        slope := atan(sqrt(elevation_scale * pow(dz_dx, 2.0) + pow(dz_dy, 2.0)));
        -- handle special case of 0, 0
        IF abs(dz_dy) = 0::float AND abs(dz_dy) = 0::float THEN
            -- set to pi as that is the expected PostgreSQL answer in Linux
            aspect := pi();
        ELSE
            aspect := atan2(dz_dy, -dz_dx);
        END IF;
        max_bright := args[5]::float;

        IF aspect < 0 THEN
            aspect := aspect + (2.0 * pi());
        END IF;

        RETURN max_bright * ( (cos(zenith)*cos(slope)) + (sin(zenith)*sin(slope)*cos(azimuth - aspect)) );
    END;
    $$;


--
-- Name: _st_histogram(text, text, integer, boolean, double precision, integer, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_histogram(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 1, bins integer DEFAULT 0, width double precision[] DEFAULT NULL::double precision[], "right" boolean DEFAULT false) RETURNS SETOF histogram
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_histogramCoverage';


--
-- Name: _st_histogram(raster, integer, boolean, double precision, integer, double precision[], boolean, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_histogram(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 1, bins integer DEFAULT 0, width double precision[] DEFAULT NULL::double precision[], "right" boolean DEFAULT false, min double precision DEFAULT NULL::double precision, max double precision DEFAULT NULL::double precision) RETURNS SETOF histogram
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_histogram';


--
-- Name: _st_intersects(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_intersects(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'intersects';


--
-- Name: _st_intersects(raster, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_intersects(rast raster, geom geometry, nband integer DEFAULT NULL::integer) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE COST 1000
    AS $$
	DECLARE
		gr raster;
		scale double precision;
	BEGIN
		IF ST_Intersects(geom, ST_ConvexHull(rast)) IS NOT TRUE THEN
			RETURN FALSE;
		ELSEIF nband IS NULL THEN
			RETURN TRUE;
		END IF;

		-- scale is set to 1/100th of raster for granularity
		SELECT least(scalex, scaley) / 100. INTO scale FROM ST_Metadata(rast);
		gr := _st_asraster(geom, scale, scale);
		IF gr IS NULL THEN
			RAISE EXCEPTION 'Unable to convert geometry to a raster';
			RETURN FALSE;
		END IF;

		RETURN ST_Intersects(rast, nband, gr, 1);
	END;
	$$;


--
-- Name: _st_intersects(geometry, raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_intersects(geom geometry, rast raster, nband integer DEFAULT NULL::integer) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE COST 1000
    AS $$
	DECLARE
		hasnodata boolean := TRUE;
		nodata float8 := 0.0;
		convexhull geometry;
		geomintersect geometry;
		x1w double precision := 0.0;
		x2w double precision := 0.0;
		y1w double precision := 0.0;
		y2w double precision := 0.0;
		x1 integer := 0;
		x2 integer := 0;
		x3 integer := 0;
		x4 integer := 0;
		y1 integer := 0;
		y2 integer := 0;
		y3 integer := 0;
		y4 integer := 0;
		x integer := 0;
		y integer := 0;
		xinc integer := 0;
		yinc integer := 0;
		pixelval double precision;
		bintersect boolean := FALSE;
		gtype text;
		scale float8;
		w int;
		h int;
	BEGIN
		convexhull := ST_ConvexHull(rast);
		IF nband IS NOT NULL THEN
			SELECT CASE WHEN bmd.nodatavalue IS NULL THEN FALSE ELSE NULL END INTO hasnodata FROM ST_BandMetaData(rast, nband) AS bmd;
		END IF;

		IF ST_Intersects(geom, convexhull) IS NOT TRUE THEN
			RETURN FALSE;
		ELSEIF nband IS NULL OR hasnodata IS FALSE THEN
			RETURN TRUE;
		END IF;

		-- Get the intersection between with the geometry.
		-- We will search for withvalue pixel only in this area.
		geomintersect := st_intersection(geom, convexhull);

--RAISE NOTICE 'geomintersect=%', st_astext(geomintersect);

		-- If the intersection is empty, return false
		IF st_isempty(geomintersect) THEN
			RETURN FALSE;
		END IF;

		-- We create a minimalistic buffer around the intersection in order to scan every pixels
		-- that would touch the edge or intersect with the geometry
		SELECT sqrt(scalex * scalex + skewy * skewy), width, height INTO scale, w, h FROM ST_Metadata(rast);
		IF scale != 0 THEN
			geomintersect := st_buffer(geomintersect, scale / 1000000);
		END IF;

--RAISE NOTICE 'geomintersect2=%', st_astext(geomintersect);

		-- Find the world coordinates of the bounding box of the intersecting area
		x1w := st_xmin(geomintersect);
		y1w := st_ymin(geomintersect);
		x2w := st_xmax(geomintersect);
		y2w := st_ymax(geomintersect);
		nodata := st_bandnodatavalue(rast, nband);

--RAISE NOTICE 'x1w=%, y1w=%, x2w=%, y2w=%', x1w, y1w, x2w, y2w;

		-- Convert world coordinates to raster coordinates
		x1 := st_world2rastercoordx(rast, x1w, y1w);
		y1 := st_world2rastercoordy(rast, x1w, y1w);
		x2 := st_world2rastercoordx(rast, x2w, y1w);
		y2 := st_world2rastercoordy(rast, x2w, y1w);
		x3 := st_world2rastercoordx(rast, x1w, y2w);
		y3 := st_world2rastercoordy(rast, x1w, y2w);
		x4 := st_world2rastercoordx(rast, x2w, y2w);
		y4 := st_world2rastercoordy(rast, x2w, y2w);

--RAISE NOTICE 'x1=%, y1=%, x2=%, y2=%, x3=%, y3=%, x4=%, y4=%', x1, y1, x2, y2, x3, y3, x4, y4;

		-- Order the raster coordinates for the upcoming FOR loop.
		x1 := int4smaller(int4smaller(int4smaller(x1, x2), x3), x4);
		y1 := int4smaller(int4smaller(int4smaller(y1, y2), y3), y4);
		x2 := int4larger(int4larger(int4larger(x1, x2), x3), x4);
		y2 := int4larger(int4larger(int4larger(y1, y2), y3), y4);

		-- Make sure the range is not lower than 1.
		-- This can happen when world coordinate are exactly on the left border
		-- of the raster and that they do not span on more than one pixel.
		x1 := int4smaller(int4larger(x1, 1), w);
		y1 := int4smaller(int4larger(y1, 1), h);

		-- Also make sure the range does not exceed the width and height of the raster.
		-- This can happen when world coordinate are exactly on the lower right border
		-- of the raster.
		x2 := int4smaller(x2, w);
		y2 := int4smaller(y2, h);

--RAISE NOTICE 'x1=%, y1=%, x2=%, y2=%', x1, y1, x2, y2;

		-- Search exhaustively for withvalue pixel on a moving 3x3 grid
		-- (very often more efficient than searching on a mere 1x1 grid)
		FOR xinc in 0..2 LOOP
			FOR yinc in 0..2 LOOP
				FOR x IN x1+xinc..x2 BY 3 LOOP
					FOR y IN y1+yinc..y2 BY 3 LOOP
						-- Check first if the pixel intersects with the geometry. Often many won't.
						bintersect := NOT st_isempty(st_intersection(st_pixelaspolygon(rast, x, y), geom));

						IF bintersect THEN
							-- If the pixel really intersects, check its value. Return TRUE if with value.
							pixelval := st_value(rast, nband, x, y);
							IF pixelval != nodata THEN
								RETURN TRUE;
							END IF;
						END IF;
					END LOOP;
				END LOOP;
			END LOOP;
		END LOOP;

		RETURN FALSE;
	END;
	$$;


--
-- Name: _st_intersects(raster, integer, raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_intersects(rast1 raster, nband1 integer, rast2 raster, nband2 integer) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 1000
    AS '$libdir/rtpostgis-2.0', 'RASTER_intersects';


--
-- Name: _st_linecrossingdirection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_linecrossingdirection(geom1 geometry, geom2 geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_LineCrossingDirection';


--
-- Name: _st_longestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_longestline(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_longestline2d';


--
-- Name: _st_mapalgebra4unionfinal1(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_mapalgebra4unionfinal1(rast raster) RETURNS raster
    LANGUAGE plpgsql
    AS $$
    DECLARE
    BEGIN
    	-- NOTE: I have to sacrifice RANGE.  Sorry RANGE.  Any 2 banded raster is going to be treated
    	-- as a MEAN
        IF ST_NumBands(rast) = 2 THEN
            RETURN ST_MapAlgebraExpr(rast, 1, rast, 2, 'CASE WHEN [rast2.val] > 0 THEN [rast1.val] / [rast2.val]::float8 ELSE NULL END'::text, NULL::text, 'UNION'::text, NULL::text, NULL::text, NULL::double precision);
        ELSE
            RETURN rast;
        END IF;
    END;
    $$;


--
-- Name: _st_mapalgebra4unionstate(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_mapalgebra4unionstate(rast1 raster, rast2 raster) RETURNS raster
    LANGUAGE sql
    AS $_$
        SELECT _ST_MapAlgebra4UnionState($1,$2, 'LAST', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
    $_$;


--
-- Name: _st_mapalgebra4unionstate(raster, raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_mapalgebra4unionstate(rast1 raster, rast2 raster, bandnum integer) RETURNS raster
    LANGUAGE sql
    AS $_$
        SELECT _ST_MapAlgebra4UnionState($1,ST_Band($2,$3), 'LAST', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
    $_$;


--
-- Name: _st_mapalgebra4unionstate(raster, raster, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_mapalgebra4unionstate(rast1 raster, rast2 raster, p_expression text) RETURNS raster
    LANGUAGE sql
    AS $_$
        SELECT _ST_MapAlgebra4UnionState($1,$2, $3, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
    $_$;


--
-- Name: _st_mapalgebra4unionstate(raster, raster, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_mapalgebra4unionstate(rast1 raster, rast2 raster, bandnum integer, p_expression text) RETURNS raster
    LANGUAGE sql
    AS $_$
        SELECT _ST_MapAlgebra4UnionState($1, ST_Band($2,$3), $4, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
    $_$;


--
-- Name: _st_mapalgebra4unionstate(raster, raster, text, text, text, double precision, text, text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_mapalgebra4unionstate(rast1 raster, rast2 raster, p_expression text, p_nodata1expr text, p_nodata2expr text, p_nodatanodataval double precision, t_expression text, t_nodata1expr text, t_nodata2expr text, t_nodatanodataval double precision) RETURNS raster
    LANGUAGE plpgsql
    AS $$
    DECLARE
        t_raster raster;
        p_raster raster;
    BEGIN
        -- With the new ST_MapAlgebraExpr we must split the main expression in three expressions: expression, nodata1expr, nodata2expr and a nodatanodataval
        -- ST_MapAlgebraExpr(rast1 raster, band1 integer, rast2 raster, band2 integer, expression text, pixeltype text, extentexpr text, nodata1expr text, nodata2expr text, nodatanodatadaval double precision)
        -- We must make sure that when NULL is passed as the first raster to ST_MapAlgebraExpr, ST_MapAlgebraExpr resolve the nodata1expr
        -- Note: rast2 is always a single band raster since it is the accumulated raster thus far
        -- 		There we always set that to band 1 regardless of what band num is requested
        IF upper(p_expression) = 'LAST' THEN
            --RAISE NOTICE 'last asked for ';
            RETURN ST_MapAlgebraExpr(rast1, 1, rast2, 1, '[rast2.val]'::text, NULL::text, 'UNION'::text, '[rast2.val]'::text, '[rast1.val]'::text, NULL::double precision);
        ELSIF upper(p_expression) = 'FIRST' THEN
            RETURN ST_MapAlgebraExpr(rast1, 1, rast2, 1, '[rast1.val]'::text, NULL::text, 'UNION'::text, '[rast2.val]'::text, '[rast1.val]'::text, NULL::double precision);
        ELSIF upper(p_expression) = 'MIN' THEN
            RETURN ST_MapAlgebraExpr(rast1, 1, rast2, 1, 'LEAST([rast1.val], [rast2.val])'::text, NULL::text, 'UNION'::text, '[rast2.val]'::text, '[rast1.val]'::text, NULL::double precision);
        ELSIF upper(p_expression) = 'MAX' THEN
            RETURN ST_MapAlgebraExpr(rast1, 1, rast2, 1, 'GREATEST([rast1.val], [rast2.val])'::text, NULL::text, 'UNION'::text, '[rast2.val]'::text, '[rast1.val]'::text, NULL::double precision);
        ELSIF upper(p_expression) = 'COUNT' THEN
            RETURN ST_MapAlgebraExpr(rast1, 1, rast2, 1, '[rast1.val] + 1'::text, NULL::text, 'UNION'::text, '1'::text, '[rast1.val]'::text, 0::double precision);
        ELSIF upper(p_expression) = 'SUM' THEN
            RETURN ST_MapAlgebraExpr(rast1, 1, rast2, 1, '[rast1.val] + [rast2.val]'::text, NULL::text, 'UNION'::text, '[rast2.val]'::text, '[rast1.val]'::text, NULL::double precision);
        ELSIF upper(p_expression) = 'RANGE' THEN
        -- have no idea what this is 
            t_raster = ST_MapAlgebraExpr(rast1, 2, rast2, 1, 'LEAST([rast1.val], [rast2.val])'::text, NULL::text, 'UNION'::text, '[rast2.val]'::text, '[rast1.val]'::text, NULL::double precision);
            p_raster := _ST_MapAlgebra4UnionState(rast1, rast2, 'MAX'::text, NULL::text, NULL::text, NULL::double precision, NULL::text, NULL::text, NULL::text, NULL::double precision);
            RETURN ST_AddBand(p_raster, t_raster, 1, 2);
        ELSIF upper(p_expression) = 'MEAN' THEN
        -- looks like t_raster is used to keep track of accumulated count
        -- and p_raster is there to keep track of accumulated sum and final state function
        -- would then do a final map to divide them.  This one is currently broken because 
        	-- have not reworked it so it can do without a final function
            t_raster = ST_MapAlgebraExpr(rast1, 2, rast2, 1, '[rast1.val] + 1'::text, NULL::text, 'UNION'::text, '1'::text, '[rast1.val]'::text, 0::double precision);
            p_raster := _ST_MapAlgebra4UnionState(rast1, rast2, 'SUM'::text, NULL::text, NULL::text, NULL::double precision, NULL::text, NULL::text, NULL::text, NULL::double precision);
            RETURN ST_AddBand(p_raster, t_raster, 1, 2);
        ELSE
            IF t_expression NOTNULL AND t_expression != '' THEN
                t_raster = ST_MapAlgebraExpr(rast1, 2, rast2, 1, t_expression, NULL::text, 'UNION'::text, t_nodata1expr, t_nodata2expr, t_nodatanodataval::double precision);
                p_raster = ST_MapAlgebraExpr(rast1, 1, rast2, 1, p_expression, NULL::text, 'UNION'::text, p_nodata1expr, p_nodata2expr, p_nodatanodataval::double precision);
                RETURN ST_AddBand(p_raster, t_raster, 1, 2);
            END IF;
            RETURN ST_MapAlgebraExpr(rast1, 1, rast2, 1, p_expression, NULL, 'UNION'::text, NULL::text, NULL::text, NULL::double precision);
        END IF;
    END;
    $$;


--
-- Name: _st_maxdistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_maxdistance(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_maxdistance2d_linestring';


--
-- Name: _st_orderingequals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_orderingequals(geometrya geometry, geometryb geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_same';


--
-- Name: _st_overlaps(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_overlaps(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'overlaps';


--
-- Name: _st_pointoutside(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_pointoutside(geography) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_point_outside';


--
-- Name: _st_quantile(raster, integer, boolean, double precision, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_quantile(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 1, quantiles double precision[] DEFAULT NULL::double precision[]) RETURNS SETOF quantile
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_quantile';


--
-- Name: _st_quantile(text, text, integer, boolean, double precision, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_quantile(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 1, quantiles double precision[] DEFAULT NULL::double precision[]) RETURNS SETOF quantile
    LANGUAGE c STABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_quantileCoverage';


--
-- Name: _st_raster2worldcoord(raster, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_raster2worldcoord(rast raster, columnx integer DEFAULT NULL::integer, rowy integer DEFAULT NULL::integer, OUT longitude double precision, OUT latitude double precision) RETURNS record
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_rasterToWorldCoord';


--
-- Name: _st_reclass(raster, reclassarg[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_reclass(rast raster, VARIADIC reclassargset reclassarg[]) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_reclass';


--
-- Name: _st_resample(raster, text, double precision, integer, double precision, double precision, double precision, double precision, double precision, double precision, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_resample(rast raster, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125, srid integer DEFAULT NULL::integer, scalex double precision DEFAULT 0, scaley double precision DEFAULT 0, gridx double precision DEFAULT NULL::double precision, gridy double precision DEFAULT NULL::double precision, skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, width integer DEFAULT NULL::integer, height integer DEFAULT NULL::integer) RETURNS raster
    LANGUAGE c STABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_resample';


--
-- Name: _st_slope4ma(double precision[], text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_slope4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        pwidth float;
        pheight float;
        dz_dx float;
        dz_dy float;
    BEGIN
        pwidth := args[1]::float;
        pheight := args[2]::float;
        dz_dx := ((matrix[3][1] + 2.0 * matrix[3][2] + matrix[3][3]) - (matrix[1][1] + 2.0 * matrix[1][2] + matrix[1][3])) / (8.0 * pwidth);
        dz_dy := ((matrix[1][3] + 2.0 * matrix[2][3] + matrix[3][3]) - (matrix[1][1] + 2.0 * matrix[2][1] + matrix[3][1])) / (8.0 * pheight);
        RETURN atan(sqrt(pow(dz_dx, 2.0) + pow(dz_dy, 2.0)));
    END;
    $$;


--
-- Name: _st_summarystats(raster, integer, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_summarystats(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 1) RETURNS summarystats
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_summaryStats';


--
-- Name: _st_summarystats(text, text, integer, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_summarystats(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 1) RETURNS summarystats
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_summaryStatsCoverage';


--
-- Name: _st_touches(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_touches(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'touches';


--
-- Name: _st_valuecount(raster, integer, boolean, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_valuecount(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, searchvalues double precision[] DEFAULT NULL::double precision[], roundto double precision DEFAULT 0) RETURNS SETOF valuecount
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_valueCount';


--
-- Name: _st_valuecount(text, text, integer, boolean, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_valuecount(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, searchvalues double precision[] DEFAULT NULL::double precision[], roundto double precision DEFAULT 0) RETURNS SETOF valuecount
    LANGUAGE c STABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_valueCountCoverage';


--
-- Name: _st_within(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_within(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT _ST_Contains($2,$1)$_$;


--
-- Name: _st_world2rastercoord(raster, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _st_world2rastercoord(rast raster, longitude double precision DEFAULT NULL::double precision, latitude double precision DEFAULT NULL::double precision, OUT columnx integer, OUT rowy integer) RETURNS record
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_worldToRasterCoord';


--
-- Name: addauth(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addauth(text) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$ 
DECLARE
	lockid alias for $1;
	okay boolean;
	myrec record;
BEGIN
	-- check to see if table exists
	--  if not, CREATE TEMP TABLE mylock (transid xid, lockcode text)
	okay := 'f';
	FOR myrec IN SELECT * FROM pg_class WHERE relname = 'temp_lock_have_table' LOOP
		okay := 't';
	END LOOP; 
	IF (okay <> 't') THEN 
		CREATE TEMP TABLE temp_lock_have_table (transid xid, lockcode text);
			-- this will only work from pgsql7.4 up
			-- ON COMMIT DELETE ROWS;
	END IF;

	--  INSERT INTO mylock VALUES ( $1)
--	EXECUTE 'INSERT INTO temp_lock_have_table VALUES ( '||
--		quote_literal(getTransactionID()) || ',' ||
--		quote_literal(lockid) ||')';

	INSERT INTO temp_lock_have_table VALUES (getTransactionID(), lockid);

	RETURN true::boolean;
END;
$_$;


--
-- Name: FUNCTION addauth(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION addauth(text) IS 'args: auth_token - Add an authorization token to be used in current transaction.';


--
-- Name: addgeometrycolumn(character varying, character varying, integer, character varying, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean DEFAULT true) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT AddGeometryColumn('','',$1,$2,$3,$4,$5, $6) into ret;
	RETURN ret;
END;
$_$;


--
-- Name: FUNCTION addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) IS 'args: table_name, column_name, srid, type, dimension, use_typmod=true - Adds a geometry column to an existing table of attributes. By default uses type modifier to define rather than constraints. Pass in false for use_typmod to get old check constraint based behavior';


--
-- Name: addgeometrycolumn(character varying, character varying, character varying, integer, character varying, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean DEFAULT true) RETURNS text
    LANGUAGE plpgsql STABLE STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT AddGeometryColumn('',$1,$2,$3,$4,$5,$6,$7) into ret;
	RETURN ret;
END;
$_$;


--
-- Name: FUNCTION addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) IS 'args: schema_name, table_name, column_name, srid, type, dimension, use_typmod=true - Adds a geometry column to an existing table of attributes. By default uses type modifier to define rather than constraints. Pass in false for use_typmod to get old check constraint based behavior';


--
-- Name: addgeometrycolumn(character varying, character varying, character varying, character varying, integer, character varying, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean DEFAULT true) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $$
DECLARE
	rec RECORD;
	sr varchar;
	real_schema name;
	sql text;
	new_srid integer;

BEGIN

	-- Verify geometry type
	IF (postgis_type_name(new_type,new_dim) IS NULL )
	THEN
		RAISE EXCEPTION 'Invalid type name "%(%)" - valid ones are:
	POINT, MULTIPOINT,
	LINESTRING, MULTILINESTRING,
	POLYGON, MULTIPOLYGON,
	CIRCULARSTRING, COMPOUNDCURVE, MULTICURVE,
	CURVEPOLYGON, MULTISURFACE,
	GEOMETRY, GEOMETRYCOLLECTION,
	POINTM, MULTIPOINTM,
	LINESTRINGM, MULTILINESTRINGM,
	POLYGONM, MULTIPOLYGONM,
	CIRCULARSTRINGM, COMPOUNDCURVEM, MULTICURVEM
	CURVEPOLYGONM, MULTISURFACEM, TRIANGLE, TRIANGLEM,
	POLYHEDRALSURFACE, POLYHEDRALSURFACEM, TIN, TINM
	or GEOMETRYCOLLECTIONM', new_type, new_dim;
		RETURN 'fail';
	END IF;


	-- Verify dimension
	IF ( (new_dim >4) OR (new_dim <2) ) THEN
		RAISE EXCEPTION 'invalid dimension';
		RETURN 'fail';
	END IF;

	IF ( (new_type LIKE '%M') AND (new_dim!=3) ) THEN
		RAISE EXCEPTION 'TypeM needs 3 dimensions';
		RETURN 'fail';
	END IF;


	-- Verify SRID
	IF ( new_srid_in > 0 ) THEN
		IF new_srid_in > 998999 THEN
			RAISE EXCEPTION 'AddGeometryColumn() - SRID must be <= %', 998999;
		END IF;
		new_srid := new_srid_in;
		SELECT SRID INTO sr FROM spatial_ref_sys WHERE SRID = new_srid;
		IF NOT FOUND THEN
			RAISE EXCEPTION 'AddGeometryColumn() - invalid SRID';
			RETURN 'fail';
		END IF;
	ELSE
		new_srid := ST_SRID('POINT EMPTY'::geometry);
		IF ( new_srid_in != new_srid ) THEN
			RAISE NOTICE 'SRID value % converted to the officially unknown SRID value %', new_srid_in, new_srid;
		END IF;
	END IF;


	-- Verify schema
	IF ( schema_name IS NOT NULL AND schema_name != '' ) THEN
		sql := 'SELECT nspname FROM pg_namespace ' ||
			'WHERE text(nspname) = ' || quote_literal(schema_name) ||
			'LIMIT 1';
		RAISE DEBUG '%', sql;
		EXECUTE sql INTO real_schema;

		IF ( real_schema IS NULL ) THEN
			RAISE EXCEPTION 'Schema % is not a valid schemaname', quote_literal(schema_name);
			RETURN 'fail';
		END IF;
	END IF;

	IF ( real_schema IS NULL ) THEN
		RAISE DEBUG 'Detecting schema';
		sql := 'SELECT n.nspname AS schemaname ' ||
			'FROM pg_catalog.pg_class c ' ||
			  'JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace ' ||
			'WHERE c.relkind = ' || quote_literal('r') ||
			' AND n.nspname NOT IN (' || quote_literal('pg_catalog') || ', ' || quote_literal('pg_toast') || ')' ||
			' AND pg_catalog.pg_table_is_visible(c.oid)' ||
			' AND c.relname = ' || quote_literal(table_name);
		RAISE DEBUG '%', sql;
		EXECUTE sql INTO real_schema;

		IF ( real_schema IS NULL ) THEN
			RAISE EXCEPTION 'Table % does not occur in the search_path', quote_literal(table_name);
			RETURN 'fail';
		END IF;
	END IF;


	-- Add geometry column to table
	IF use_typmod THEN
	     sql := 'ALTER TABLE ' ||
            quote_ident(real_schema) || '.' || quote_ident(table_name)
            || ' ADD COLUMN ' || quote_ident(column_name) ||
            ' geometry(' || postgis_type_name(new_type, new_dim) || ', ' || new_srid::text || ')';
        RAISE DEBUG '%', sql;
	ELSE
        sql := 'ALTER TABLE ' ||
            quote_ident(real_schema) || '.' || quote_ident(table_name)
            || ' ADD COLUMN ' || quote_ident(column_name) ||
            ' geometry ';
        RAISE DEBUG '%', sql;
    END IF;
	EXECUTE sql;

	IF NOT use_typmod THEN
        -- Add table CHECKs
        sql := 'ALTER TABLE ' ||
            quote_ident(real_schema) || '.' || quote_ident(table_name)
            || ' ADD CONSTRAINT '
            || quote_ident('enforce_srid_' || column_name)
            || ' CHECK (st_srid(' || quote_ident(column_name) ||
            ') = ' || new_srid::text || ')' ;
        RAISE DEBUG '%', sql;
        EXECUTE sql;
    
        sql := 'ALTER TABLE ' ||
            quote_ident(real_schema) || '.' || quote_ident(table_name)
            || ' ADD CONSTRAINT '
            || quote_ident('enforce_dims_' || column_name)
            || ' CHECK (st_ndims(' || quote_ident(column_name) ||
            ') = ' || new_dim::text || ')' ;
        RAISE DEBUG '%', sql;
        EXECUTE sql;
    
        IF ( NOT (new_type = 'GEOMETRY')) THEN
            sql := 'ALTER TABLE ' ||
                quote_ident(real_schema) || '.' || quote_ident(table_name) || ' ADD CONSTRAINT ' ||
                quote_ident('enforce_geotype_' || column_name) ||
                ' CHECK (GeometryType(' ||
                quote_ident(column_name) || ')=' ||
                quote_literal(new_type) || ' OR (' ||
                quote_ident(column_name) || ') is null)';
            RAISE DEBUG '%', sql;
            EXECUTE sql;
        END IF;
    END IF;

	RETURN
		real_schema || '.' ||
		table_name || '.' || column_name ||
		' SRID:' || new_srid::text ||
		' TYPE:' || new_type ||
		' DIMS:' || new_dim::text || ' ';
END;
$$;


--
-- Name: FUNCTION addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean) IS 'args: catalog_name, schema_name, table_name, column_name, srid, type, dimension, use_typmod=true - Adds a geometry column to an existing table of attributes. By default uses type modifier to define rather than constraints. Pass in false for use_typmod to get old check constraint based behavior';


--
-- Name: addoverviewconstraints(name, name, name, name, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addoverviewconstraints(ovtable name, ovcolumn name, reftable name, refcolumn name, ovfactor integer) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT AddOverviewConstraints('', $1, $2, '', $3, $4, $5) $_$;


--
-- Name: addoverviewconstraints(name, name, name, name, name, name, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addoverviewconstraints(ovschema name, ovtable name, ovcolumn name, refschema name, reftable name, refcolumn name, ovfactor integer) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		x int;
		s name;
		t name;
		oschema name;
		rschema name;
		sql text;
		rtn boolean;
	BEGIN
		FOR x IN 1..2 LOOP
			s := '';

			IF x = 1 THEN
				s := $1;
				t := $2;
			ELSE
				s := $4;
				t := $5;
			END IF;

			-- validate user-provided schema
			IF length(s) > 0 THEN
				sql := 'SELECT nspname FROM pg_namespace '
					|| 'WHERE nspname = ' || quote_literal(s)
					|| 'LIMIT 1';
				EXECUTE sql INTO s;

				IF s IS NULL THEN
					RAISE EXCEPTION 'The value % is not a valid schema', quote_literal(s);
					RETURN FALSE;
				END IF;
			END IF;

			-- no schema, determine what it could be using the table
			IF length(s) < 1 THEN
				sql := 'SELECT n.nspname AS schemaname '
					|| 'FROM pg_catalog.pg_class c '
					|| 'JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace '
					|| 'WHERE c.relkind = ' || quote_literal('r')
					|| ' AND n.nspname NOT IN (' || quote_literal('pg_catalog')
					|| ', ' || quote_literal('pg_toast')
					|| ') AND pg_catalog.pg_table_is_visible(c.oid)'
					|| ' AND c.relname = ' || quote_literal(t);
				EXECUTE sql INTO s;

				IF s IS NULL THEN
					RAISE EXCEPTION 'The table % does not occur in the search_path', quote_literal(t);
					RETURN FALSE;
				END IF;
			END IF;

			IF x = 1 THEN
				oschema := s;
			ELSE
				rschema := s;
			END IF;
		END LOOP;

		-- reference raster
		rtn := _add_overview_constraint(oschema, $2, $3, rschema, $5, $6, $7);
		IF rtn IS FALSE THEN
			RAISE EXCEPTION 'Unable to add the overview constraint.  Is the schema name, table name or column name incorrect?';
			RETURN FALSE;
		END IF;

		RETURN TRUE;
	END;
	$_$;


--
-- Name: addrasterconstraints(name, name, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addrasterconstraints(rasttable name, rastcolumn name, VARIADIC constraints text[]) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT AddRasterConstraints('', $1, $2, VARIADIC $3) $_$;


--
-- Name: FUNCTION addrasterconstraints(rasttable name, rastcolumn name, VARIADIC constraints text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION addrasterconstraints(rasttable name, rastcolumn name, VARIADIC constraints text[]) IS 'args: rasttable, rastcolumn, VARIADIC constraints - Adds raster constraints to a loaded raster table for a specific column that constrains spatial ref, scaling, blocksize, alignment, bands, band type and a flag to denote if raster column is regularly blocked. The table must be loaded with data for the constraints to be inferred. Returns true of the constraint setting was accomplished and if issues a notice.';


--
-- Name: addrasterconstraints(name, name, name, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addrasterconstraints(rastschema name, rasttable name, rastcolumn name, VARIADIC constraints text[]) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		max int;
		cnt int;
		sql text;
		schema name;
		x int;
		kw text;
		rtn boolean;
	BEGIN
		cnt := 0;
		max := array_length(constraints, 1);
		IF max < 1 THEN
			RAISE NOTICE 'No constraints indicated to be added.  Doing nothing';
			RETURN TRUE;
		END IF;

		-- validate schema
		schema := NULL;
		IF length($1) > 0 THEN
			sql := 'SELECT nspname FROM pg_namespace '
				|| 'WHERE nspname = ' || quote_literal($1)
				|| 'LIMIT 1';
			EXECUTE sql INTO schema;

			IF schema IS NULL THEN
				RAISE EXCEPTION 'The value provided for schema is invalid';
				RETURN FALSE;
			END IF;
		END IF;

		IF schema IS NULL THEN
			sql := 'SELECT n.nspname AS schemaname '
				|| 'FROM pg_catalog.pg_class c '
				|| 'JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace '
				|| 'WHERE c.relkind = ' || quote_literal('r')
				|| ' AND n.nspname NOT IN (' || quote_literal('pg_catalog')
				|| ', ' || quote_literal('pg_toast')
				|| ') AND pg_catalog.pg_table_is_visible(c.oid)'
				|| ' AND c.relname = ' || quote_literal($2);
			EXECUTE sql INTO schema;

			IF schema IS NULL THEN
				RAISE EXCEPTION 'The table % does not occur in the search_path', quote_literal($2);
				RETURN FALSE;
			END IF;
		END IF;

		<<kwloop>>
		FOR x in 1..max LOOP
			kw := trim(both from lower(constraints[x]));

			BEGIN
				CASE
					WHEN kw = 'srid' THEN
						RAISE NOTICE 'Adding SRID constraint';
						rtn := _add_raster_constraint_srid(schema, $2, $3);
					WHEN kw IN ('scale_x', 'scalex') THEN
						RAISE NOTICE 'Adding scale-X constraint';
						rtn := _add_raster_constraint_scale(schema, $2, $3, 'x');
					WHEN kw IN ('scale_y', 'scaley') THEN
						RAISE NOTICE 'Adding scale-Y constraint';
						rtn := _add_raster_constraint_scale(schema, $2, $3, 'y');
					WHEN kw = 'scale' THEN
						RAISE NOTICE 'Adding scale-X constraint';
						rtn := _add_raster_constraint_scale(schema, $2, $3, 'x');
						RAISE NOTICE 'Adding scale-Y constraint';
						rtn := _add_raster_constraint_scale(schema, $2, $3, 'y');
					WHEN kw IN ('blocksize_x', 'blocksizex', 'width') THEN
						RAISE NOTICE 'Adding blocksize-X constraint';
						rtn := _add_raster_constraint_blocksize(schema, $2, $3, 'width');
					WHEN kw IN ('blocksize_y', 'blocksizey', 'height') THEN
						RAISE NOTICE 'Adding blocksize-Y constraint';
						rtn := _add_raster_constraint_blocksize(schema, $2, $3, 'height');
					WHEN kw = 'blocksize' THEN
						RAISE NOTICE 'Adding blocksize-X constraint';
						rtn := _add_raster_constraint_blocksize(schema, $2, $3, 'width');
						RAISE NOTICE 'Adding blocksize-Y constraint';
						rtn := _add_raster_constraint_blocksize(schema, $2, $3, 'height');
					WHEN kw IN ('same_alignment', 'samealignment', 'alignment') THEN
						RAISE NOTICE 'Adding alignment constraint';
						rtn := _add_raster_constraint_alignment(schema, $2, $3);
					WHEN kw IN ('regular_blocking', 'regularblocking') THEN
						RAISE NOTICE 'Adding regular blocking constraint';
						rtn := _add_raster_constraint_regular_blocking(schema, $2, $3);
					WHEN kw IN ('num_bands', 'numbands') THEN
						RAISE NOTICE 'Adding number of bands constraint';
						rtn := _add_raster_constraint_num_bands(schema, $2, $3);
					WHEN kw IN ('pixel_types', 'pixeltypes') THEN
						RAISE NOTICE 'Adding pixel type constraint';
						rtn := _add_raster_constraint_pixel_types(schema, $2, $3);
					WHEN kw IN ('nodata_values', 'nodatavalues', 'nodata') THEN
						RAISE NOTICE 'Adding nodata value constraint';
						rtn := _add_raster_constraint_nodata_values(schema, $2, $3);
					WHEN kw IN ('out_db', 'outdb') THEN
						RAISE NOTICE 'Adding out-of-database constraint';
						rtn := _add_raster_constraint_out_db(schema, $2, $3);
					WHEN kw = 'extent' THEN
						RAISE NOTICE 'Adding maximum extent constraint';
						rtn := _add_raster_constraint_extent(schema, $2, $3);
					ELSE
						RAISE NOTICE 'Unknown constraint: %.  Skipping', quote_literal(constraints[x]);
						CONTINUE kwloop;
				END CASE;
			END;

			IF rtn IS FALSE THEN
				cnt := cnt + 1;
				RAISE WARNING 'Unable to add constraint: %.  Skipping', quote_literal(constraints[x]);
			END IF;

		END LOOP kwloop;

		IF cnt = max THEN
			RAISE EXCEPTION 'None of the constraints specified could be added.  Is the schema name, table name or column name incorrect?';
			RETURN FALSE;
		END IF;

		RETURN TRUE;
	END;
	$_$;


--
-- Name: FUNCTION addrasterconstraints(rastschema name, rasttable name, rastcolumn name, VARIADIC constraints text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION addrasterconstraints(rastschema name, rasttable name, rastcolumn name, VARIADIC constraints text[]) IS 'args: rastschema, rasttable, rastcolumn, VARIADIC constraints - Adds raster constraints to a loaded raster table for a specific column that constrains spatial ref, scaling, blocksize, alignment, bands, band type and a flag to denote if raster column is regularly blocked. The table must be loaded with data for the constraints to be inferred. Returns true of the constraint setting was accomplished and if issues a notice.';


--
-- Name: addrasterconstraints(name, name, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addrasterconstraints(rasttable name, rastcolumn name, srid boolean DEFAULT true, scale_x boolean DEFAULT true, scale_y boolean DEFAULT true, blocksize_x boolean DEFAULT true, blocksize_y boolean DEFAULT true, same_alignment boolean DEFAULT true, regular_blocking boolean DEFAULT false, num_bands boolean DEFAULT true, pixel_types boolean DEFAULT true, nodata_values boolean DEFAULT true, out_db boolean DEFAULT true, extent boolean DEFAULT true) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT AddRasterConstraints('', $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14) $_$;


--
-- Name: FUNCTION addrasterconstraints(rasttable name, rastcolumn name, srid boolean, scale_x boolean, scale_y boolean, blocksize_x boolean, blocksize_y boolean, same_alignment boolean, regular_blocking boolean, num_bands boolean, pixel_types boolean, nodata_values boolean, out_db boolean, extent boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION addrasterconstraints(rasttable name, rastcolumn name, srid boolean, scale_x boolean, scale_y boolean, blocksize_x boolean, blocksize_y boolean, same_alignment boolean, regular_blocking boolean, num_bands boolean, pixel_types boolean, nodata_values boolean, out_db boolean, extent boolean) IS 'args: rasttable, rastcolumn, srid, scale_x, scale_y, blocksize_x, blocksize_y, same_alignment, regular_blocking, num_bands=true, pixel_types=true, nodata_values=true, out_db=true, extent=true - Adds raster constraints to a loaded raster table for a specific column that constrains spatial ref, scaling, blocksize, alignment, bands, band type and a flag to denote if raster column is regularly blocked. The table must be loaded with data for the constraints to be inferred. Returns true of the constraint setting was accomplished and if issues a notice.';


--
-- Name: addrasterconstraints(name, name, name, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addrasterconstraints(rastschema name, rasttable name, rastcolumn name, srid boolean DEFAULT true, scale_x boolean DEFAULT true, scale_y boolean DEFAULT true, blocksize_x boolean DEFAULT true, blocksize_y boolean DEFAULT true, same_alignment boolean DEFAULT true, regular_blocking boolean DEFAULT false, num_bands boolean DEFAULT true, pixel_types boolean DEFAULT true, nodata_values boolean DEFAULT true, out_db boolean DEFAULT true, extent boolean DEFAULT true) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		constraints text[];
	BEGIN
		IF srid IS TRUE THEN
			constraints := constraints || 'srid'::text;
		END IF;

		IF scale_x IS TRUE THEN
			constraints := constraints || 'scale_x'::text;
		END IF;

		IF scale_y IS TRUE THEN
			constraints := constraints || 'scale_y'::text;
		END IF;

		IF blocksize_x IS TRUE THEN
			constraints := constraints || 'blocksize_x'::text;
		END IF;

		IF blocksize_y IS TRUE THEN
			constraints := constraints || 'blocksize_y'::text;
		END IF;

		IF same_alignment IS TRUE THEN
			constraints := constraints || 'same_alignment'::text;
		END IF;

		IF regular_blocking IS TRUE THEN
			constraints := constraints || 'regular_blocking'::text;
		END IF;

		IF num_bands IS TRUE THEN
			constraints := constraints || 'num_bands'::text;
		END IF;

		IF pixel_types IS TRUE THEN
			constraints := constraints || 'pixel_types'::text;
		END IF;

		IF nodata_values IS TRUE THEN
			constraints := constraints || 'nodata_values'::text;
		END IF;

		IF out_db IS TRUE THEN
			constraints := constraints || 'out_db'::text;
		END IF;

		IF extent IS TRUE THEN
			constraints := constraints || 'extent'::text;
		END IF;

		RETURN AddRasterConstraints($1, $2, $3, VARIADIC constraints);
	END;
	$_$;


--
-- Name: FUNCTION addrasterconstraints(rastschema name, rasttable name, rastcolumn name, srid boolean, scale_x boolean, scale_y boolean, blocksize_x boolean, blocksize_y boolean, same_alignment boolean, regular_blocking boolean, num_bands boolean, pixel_types boolean, nodata_values boolean, out_db boolean, extent boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION addrasterconstraints(rastschema name, rasttable name, rastcolumn name, srid boolean, scale_x boolean, scale_y boolean, blocksize_x boolean, blocksize_y boolean, same_alignment boolean, regular_blocking boolean, num_bands boolean, pixel_types boolean, nodata_values boolean, out_db boolean, extent boolean) IS 'args: rastschema, rasttable, rastcolumn, srid=true, scale_x=true, scale_y=true, blocksize_x=true, blocksize_y=true, same_alignment=true, regular_blocking=true, num_bands=true, pixel_types=true, nodata_values=true, out_db=true, extent=true - Adds raster constraints to a loaded raster table for a specific column that constrains spatial ref, scaling, blocksize, alignment, bands, band type and a flag to denote if raster column is regularly blocked. The table must be loaded with data for the constraints to be inferred. Returns true of the constraint setting was accomplished and if issues a notice.';


--
-- Name: box(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box(geometry) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_to_BOX';


--
-- Name: box(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box(box3d) RETURNS box
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_to_BOX';


--
-- Name: box2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2d(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_to_BOX2D';


--
-- Name: FUNCTION box2d(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION box2d(geometry) IS 'args: geomA - Returns a BOX2D representing the maximum extents of the geometry.';


--
-- Name: box2d(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box2d(box3d) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_to_BOX2D';


--
-- Name: box3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d(geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_to_BOX3D';


--
-- Name: FUNCTION box3d(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION box3d(geometry) IS 'args: geomA - Returns a BOX3D representing the maximum extents of the geometry.';


--
-- Name: box3d(box2d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d(box2d) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX2D_to_BOX3D';


--
-- Name: box3d(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3d(raster) RETURNS box3d
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select box3d(st_convexhull($1))$_$;


--
-- Name: FUNCTION box3d(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION box3d(raster) IS 'args: rast - Returns the box 3d representation of the enclosing box of the raster.';


--
-- Name: box3dtobox(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION box3dtobox(box3d) RETURNS box
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT box($1)$_$;


--
-- Name: bytea(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION bytea(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_to_bytea';


--
-- Name: bytea(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION bytea(geography) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_to_bytea';


--
-- Name: bytea(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION bytea(raster) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_to_bytea';


--
-- Name: checkauth(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION checkauth(text, text) RETURNS integer
    LANGUAGE sql
    AS $_$ SELECT CheckAuth('', $1, $2) $_$;


--
-- Name: FUNCTION checkauth(text, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION checkauth(text, text) IS 'args: a_table_name, a_key_column_name - Creates trigger on a table to prevent/allow updates and deletes of rows based on authorization token.';


--
-- Name: checkauth(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION checkauth(text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$ 
DECLARE
	schema text;
BEGIN
	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	if ( $1 != '' ) THEN
		schema = $1;
	ELSE
		SELECT current_schema() into schema;
	END IF;

	-- TODO: check for an already existing trigger ?

	EXECUTE 'CREATE TRIGGER check_auth BEFORE UPDATE OR DELETE ON ' 
		|| quote_ident(schema) || '.' || quote_ident($2)
		||' FOR EACH ROW EXECUTE PROCEDURE CheckAuthTrigger('
		|| quote_literal($3) || ')';

	RETURN 0;
END;
$_$;


--
-- Name: FUNCTION checkauth(text, text, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION checkauth(text, text, text) IS 'args: a_schema_name, a_table_name, a_key_column_name - Creates trigger on a table to prevent/allow updates and deletes of rows based on authorization token.';


--
-- Name: checkauthtrigger(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION checkauthtrigger() RETURNS trigger
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'check_authorization';


--
-- Name: cleangeometry(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION cleangeometry(geom geometry) RETURNS geometry
    LANGUAGE plpgsql
    AS $_$DECLARE
  inGeom ALIAS for $1;
  outGeom geometry;
  tmpLinestring geometry;

Begin
  
  outGeom := NULL;
  
-- Clean Process for Polygon 
  IF (GeometryType(inGeom) = 'POLYGON' OR GeometryType(inGeom) = 'MULTIPOLYGON') THEN

-- Only process if geometry is not valid, 
-- otherwise put out without change
    if not st_isValid(inGeom) THEN
    
-- create nodes at all self-intersecting lines by union the polygon boundaries
-- with the startingpoint of the boundary.  
      tmpLinestring := st_union(st_multi(st_boundary(inGeom)),st_pointn(st_boundary(inGeom),1));
      outGeom = st_buildarea(tmpLinestring);      
      IF (GeometryType(inGeom) = 'MULTIPOLYGON') THEN      
        RETURN st_multi(outGeom);
      ELSE
        RETURN outGeom;
      END IF;
    else    
      RETURN inGeom;
    END IF;


------------------------------------------------------------------------------
-- Clean Process for LINESTRINGS, self-intersecting parts of linestrings 
-- will be divided into multiparts of the mentioned linestring 
------------------------------------------------------------------------------
  ELSIF (GeometryType(inGeom) = 'LINESTRING') THEN
    
-- create nodes at all self-intersecting lines by union the linestrings
-- with the startingpoint of the linestring.  
    outGeom := st_union(st_multi(inGeom),st_pointn(inGeom,1));
    RETURN outGeom;
  ELSIF (GeometryType(inGeom) = 'MULTILINESTRING') THEN 
    outGeom := st_multi(st_union(st_multi(inGeom),st_pointn(inGeom,1)));
    RETURN outGeom;
  ELSE 
    RAISE NOTICE 'The input type % is not supported',GeometryType(inGeom);
    RETURN inGeom;
  END IF;	  
End;$_$;


--
-- Name: crc32(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION crc32(word text) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE
    AS $$
          DECLARE tmp bigint;
          DECLARE i int;
          DECLARE j int;
          DECLARE byte_length int;
          DECLARE word_array bytea;
          BEGIN
            IF COALESCE(word, '') = '' THEN
              return 0;
            END IF;

            i = 0;
            tmp = 4294967295;
            byte_length = bit_length(word) / 8;
            word_array = decode(replace(word, E'\\', E'\\\\'), 'escape');
            LOOP
              tmp = (tmp # get_byte(word_array, i))::bigint;
              i = i + 1;
              j = 0;
              LOOP
                tmp = ((tmp >> 1) # (3988292384 * (tmp & 1)))::bigint;
                j = j + 1;
                IF j >= 8 THEN
                  EXIT;
                END IF;
              END LOOP;
              IF i >= byte_length THEN
                EXIT;
              END IF;
            END LOOP;
            return (tmp # 4294967295);
          END
        $$;


--
-- Name: disablelongtransactions(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION disablelongtransactions() RETURNS text
    LANGUAGE plpgsql
    AS $$ 
DECLARE
	rec RECORD;

BEGIN

	--
	-- Drop all triggers applied by CheckAuth()
	--
	FOR rec IN
		SELECT c.relname, t.tgname, t.tgargs FROM pg_trigger t, pg_class c, pg_proc p
		WHERE p.proname = 'checkauthtrigger' and t.tgfoid = p.oid and t.tgrelid = c.oid
	LOOP
		EXECUTE 'DROP TRIGGER ' || quote_ident(rec.tgname) ||
			' ON ' || quote_ident(rec.relname);
	END LOOP;

	--
	-- Drop the authorization_table table
	--
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorization_table' LOOP
		DROP TABLE authorization_table;
	END LOOP;

	--
	-- Drop the authorized_tables view
	--
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorized_tables' LOOP
		DROP VIEW authorized_tables;
	END LOOP;

	RETURN 'Long transactions support disabled';
END;
$$;


--
-- Name: FUNCTION disablelongtransactions(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION disablelongtransactions() IS 'Disable long transaction support. This function removes the long transaction support metadata tables, and drops all triggers attached to lock-checked tables.';


--
-- Name: dropgeometrycolumn(character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrycolumn(table_name character varying, column_name character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret text;
BEGIN
	SELECT DropGeometryColumn('','',$1,$2) into ret;
	RETURN ret;
END;
$_$;


--
-- Name: FUNCTION dropgeometrycolumn(table_name character varying, column_name character varying); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION dropgeometrycolumn(table_name character varying, column_name character varying) IS 'args: table_name, column_name - Removes a geometry column from a spatial table.';


--
-- Name: dropgeometrycolumn(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret text;
BEGIN
	SELECT DropGeometryColumn('',$1,$2,$3) into ret;
	RETURN ret;
END;
$_$;


--
-- Name: FUNCTION dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) IS 'args: schema_name, table_name, column_name - Removes a geometry column from a spatial table.';


--
-- Name: dropgeometrycolumn(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $$
DECLARE
	myrec RECORD;
	okay boolean;
	real_schema name;

BEGIN


	-- Find, check or fix schema_name
	IF ( schema_name != '' ) THEN
		okay = false;

		FOR myrec IN SELECT nspname FROM pg_namespace WHERE text(nspname) = schema_name LOOP
			okay := true;
		END LOOP;

		IF ( okay <>  true ) THEN
			RAISE NOTICE 'Invalid schema name - using current_schema()';
			SELECT current_schema() into real_schema;
		ELSE
			real_schema = schema_name;
		END IF;
	ELSE
		SELECT current_schema() into real_schema;
	END IF;

	-- Find out if the column is in the geometry_columns table
	okay = false;
	FOR myrec IN SELECT * from geometry_columns where f_table_schema = text(real_schema) and f_table_name = table_name and f_geometry_column = column_name LOOP
		okay := true;
	END LOOP;
	IF (okay <> true) THEN
		RAISE EXCEPTION 'column not found in geometry_columns table';
		RETURN false;
	END IF;

	-- Remove table column
	EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) || '.' ||
		quote_ident(table_name) || ' DROP COLUMN ' ||
		quote_ident(column_name);

	RETURN real_schema || '.' || table_name || '.' || column_name ||' effectively removed.';

END;
$$;


--
-- Name: FUNCTION dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) IS 'args: catalog_name, schema_name, table_name, column_name - Removes a geometry column from a spatial table.';


--
-- Name: dropgeometrytable(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrytable(table_name character varying) RETURNS text
    LANGUAGE sql STRICT
    AS $_$ SELECT DropGeometryTable('','',$1) $_$;


--
-- Name: FUNCTION dropgeometrytable(table_name character varying); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION dropgeometrytable(table_name character varying) IS 'args: table_name - Drops a table and all its references in geometry_columns.';


--
-- Name: dropgeometrytable(character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrytable(schema_name character varying, table_name character varying) RETURNS text
    LANGUAGE sql STRICT
    AS $_$ SELECT DropGeometryTable('',$1,$2) $_$;


--
-- Name: FUNCTION dropgeometrytable(schema_name character varying, table_name character varying); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION dropgeometrytable(schema_name character varying, table_name character varying) IS 'args: schema_name, table_name - Drops a table and all its references in geometry_columns.';


--
-- Name: dropgeometrytable(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $$
DECLARE
	real_schema name;

BEGIN

	IF ( schema_name = '' ) THEN
		SELECT current_schema() into real_schema;
	ELSE
		real_schema = schema_name;
	END IF;

	-- TODO: Should we warn if table doesn't exist probably instead just saying dropped
	-- Remove table
	EXECUTE 'DROP TABLE IF EXISTS '
		|| quote_ident(real_schema) || '.' ||
		quote_ident(table_name) || ' RESTRICT';

	RETURN
		real_schema || '.' ||
		table_name ||' dropped.';

END;
$$;


--
-- Name: FUNCTION dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) IS 'args: catalog_name, schema_name, table_name - Drops a table and all its references in geometry_columns.';


--
-- Name: dropoverviewconstraints(name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropoverviewconstraints(ovtable name, ovcolumn name) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT DropOverviewConstraints('', $1, $2) $_$;


--
-- Name: dropoverviewconstraints(name, name, name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dropoverviewconstraints(ovschema name, ovtable name, ovcolumn name) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		schema name;
		sql text;
		rtn boolean;
	BEGIN
		-- validate schema
		schema := NULL;
		IF length($1) > 0 THEN
			sql := 'SELECT nspname FROM pg_namespace '
				|| 'WHERE nspname = ' || quote_literal($1)
				|| 'LIMIT 1';
			EXECUTE sql INTO schema;

			IF schema IS NULL THEN
				RAISE EXCEPTION 'The value provided for schema is invalid';
				RETURN FALSE;
			END IF;
		END IF;

		IF schema IS NULL THEN
			sql := 'SELECT n.nspname AS schemaname '
				|| 'FROM pg_catalog.pg_class c '
				|| 'JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace '
				|| 'WHERE c.relkind = ' || quote_literal('r')
				|| ' AND n.nspname NOT IN (' || quote_literal('pg_catalog')
				|| ', ' || quote_literal('pg_toast')
				|| ') AND pg_catalog.pg_table_is_visible(c.oid)'
				|| ' AND c.relname = ' || quote_literal($2);
			EXECUTE sql INTO schema;

			IF schema IS NULL THEN
				RAISE EXCEPTION 'The table % does not occur in the search_path', quote_literal($2);
				RETURN FALSE;
			END IF;
		END IF;

		rtn := _drop_overview_constraint(schema, $2, $3);
		IF rtn IS FALSE THEN
			RAISE EXCEPTION 'Unable to drop the overview constraint .  Is the schema name, table name or column name incorrect?';
			RETURN FALSE;
		END IF;

		RETURN TRUE;
	END;
	$_$;


--
-- Name: droprasterconstraints(name, name, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION droprasterconstraints(rasttable name, rastcolumn name, VARIADIC constraints text[]) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT DropRasterConstraints('', $1, $2, VARIADIC $3) $_$;


--
-- Name: droprasterconstraints(name, name, name, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION droprasterconstraints(rastschema name, rasttable name, rastcolumn name, VARIADIC constraints text[]) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		max int;
		x int;
		schema name;
		sql text;
		kw text;
		rtn boolean;
		cnt int;
	BEGIN
		cnt := 0;
		max := array_length(constraints, 1);
		IF max < 1 THEN
			RAISE NOTICE 'No constraints indicated to be dropped.  Doing nothing';
			RETURN TRUE;
		END IF;

		-- validate schema
		schema := NULL;
		IF length($1) > 0 THEN
			sql := 'SELECT nspname FROM pg_namespace '
				|| 'WHERE nspname = ' || quote_literal($1)
				|| 'LIMIT 1';
			EXECUTE sql INTO schema;

			IF schema IS NULL THEN
				RAISE EXCEPTION 'The value provided for schema is invalid';
				RETURN FALSE;
			END IF;
		END IF;

		IF schema IS NULL THEN
			sql := 'SELECT n.nspname AS schemaname '
				|| 'FROM pg_catalog.pg_class c '
				|| 'JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace '
				|| 'WHERE c.relkind = ' || quote_literal('r')
				|| ' AND n.nspname NOT IN (' || quote_literal('pg_catalog')
				|| ', ' || quote_literal('pg_toast')
				|| ') AND pg_catalog.pg_table_is_visible(c.oid)'
				|| ' AND c.relname = ' || quote_literal($2);
			EXECUTE sql INTO schema;

			IF schema IS NULL THEN
				RAISE EXCEPTION 'The table % does not occur in the search_path', quote_literal($2);
				RETURN FALSE;
			END IF;
		END IF;

		<<kwloop>>
		FOR x in 1..max LOOP
			kw := trim(both from lower(constraints[x]));

			BEGIN
				CASE
					WHEN kw = 'srid' THEN
						RAISE NOTICE 'Dropping SRID constraint';
						rtn := _drop_raster_constraint_srid(schema, $2, $3);
					WHEN kw IN ('scale_x', 'scalex') THEN
						RAISE NOTICE 'Dropping scale-X constraint';
						rtn := _drop_raster_constraint_scale(schema, $2, $3, 'x');
					WHEN kw IN ('scale_y', 'scaley') THEN
						RAISE NOTICE 'Dropping scale-Y constraint';
						rtn := _drop_raster_constraint_scale(schema, $2, $3, 'y');
					WHEN kw = 'scale' THEN
						RAISE NOTICE 'Dropping scale-X constraint';
						rtn := _drop_raster_constraint_scale(schema, $2, $3, 'x');
						RAISE NOTICE 'Dropping scale-Y constraint';
						rtn := _drop_raster_constraint_scale(schema, $2, $3, 'y');
					WHEN kw IN ('blocksize_x', 'blocksizex', 'width') THEN
						RAISE NOTICE 'Dropping blocksize-X constraint';
						rtn := _drop_raster_constraint_blocksize(schema, $2, $3, 'width');
					WHEN kw IN ('blocksize_y', 'blocksizey', 'height') THEN
						RAISE NOTICE 'Dropping blocksize-Y constraint';
						rtn := _drop_raster_constraint_blocksize(schema, $2, $3, 'height');
					WHEN kw = 'blocksize' THEN
						RAISE NOTICE 'Dropping blocksize-X constraint';
						rtn := _drop_raster_constraint_blocksize(schema, $2, $3, 'width');
						RAISE NOTICE 'Dropping blocksize-Y constraint';
						rtn := _drop_raster_constraint_blocksize(schema, $2, $3, 'height');
					WHEN kw IN ('same_alignment', 'samealignment', 'alignment') THEN
						RAISE NOTICE 'Dropping alignment constraint';
						rtn := _drop_raster_constraint_alignment(schema, $2, $3);
					WHEN kw IN ('regular_blocking', 'regularblocking') THEN
						RAISE NOTICE 'Dropping regular blocking constraint';
						rtn := _drop_raster_constraint_regular_blocking(schema, $2, $3);
					WHEN kw IN ('num_bands', 'numbands') THEN
						RAISE NOTICE 'Dropping number of bands constraint';
						rtn := _drop_raster_constraint_num_bands(schema, $2, $3);
					WHEN kw IN ('pixel_types', 'pixeltypes') THEN
						RAISE NOTICE 'Dropping pixel type constraint';
						rtn := _drop_raster_constraint_pixel_types(schema, $2, $3);
					WHEN kw IN ('nodata_values', 'nodatavalues', 'nodata') THEN
						RAISE NOTICE 'Dropping nodata value constraint';
						rtn := _drop_raster_constraint_nodata_values(schema, $2, $3);
					WHEN kw IN ('out_db', 'outdb') THEN
						RAISE NOTICE 'Dropping out-of-database constraint';
						rtn := _drop_raster_constraint_out_db(schema, $2, $3);
					WHEN kw = 'extent' THEN
						RAISE NOTICE 'Dropping maximum extent constraint';
						rtn := _drop_raster_constraint_extent(schema, $2, $3);
					ELSE
						RAISE NOTICE 'Unknown constraint: %.  Skipping', quote_literal(constraints[x]);
						CONTINUE kwloop;
				END CASE;
			END;

			IF rtn IS FALSE THEN
				cnt := cnt + 1;
				RAISE WARNING 'Unable to drop constraint: %.  Skipping', quote_literal(constraints[x]);
			END IF;

		END LOOP kwloop;

		IF cnt = max THEN
			RAISE EXCEPTION 'None of the constraints specified could be dropped.  Is the schema name, table name or column name incorrect?';
			RETURN FALSE;
		END IF;

		RETURN TRUE;
	END;
	$_$;


--
-- Name: FUNCTION droprasterconstraints(rastschema name, rasttable name, rastcolumn name, VARIADIC constraints text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION droprasterconstraints(rastschema name, rasttable name, rastcolumn name, VARIADIC constraints text[]) IS 'args: rastschema, rasttable, rastcolumn, constraints - Drops PostGIS raster constraints that refer to a raster table column. Useful if you need to reload data or update your raster column data.';


--
-- Name: droprasterconstraints(name, name, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION droprasterconstraints(rasttable name, rastcolumn name, srid boolean DEFAULT true, scale_x boolean DEFAULT true, scale_y boolean DEFAULT true, blocksize_x boolean DEFAULT true, blocksize_y boolean DEFAULT true, same_alignment boolean DEFAULT true, regular_blocking boolean DEFAULT true, num_bands boolean DEFAULT true, pixel_types boolean DEFAULT true, nodata_values boolean DEFAULT true, out_db boolean DEFAULT true, extent boolean DEFAULT true) RETURNS boolean
    LANGUAGE sql STRICT
    AS $_$ SELECT DropRasterConstraints('', $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14) $_$;


--
-- Name: FUNCTION droprasterconstraints(rasttable name, rastcolumn name, srid boolean, scale_x boolean, scale_y boolean, blocksize_x boolean, blocksize_y boolean, same_alignment boolean, regular_blocking boolean, num_bands boolean, pixel_types boolean, nodata_values boolean, out_db boolean, extent boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION droprasterconstraints(rasttable name, rastcolumn name, srid boolean, scale_x boolean, scale_y boolean, blocksize_x boolean, blocksize_y boolean, same_alignment boolean, regular_blocking boolean, num_bands boolean, pixel_types boolean, nodata_values boolean, out_db boolean, extent boolean) IS 'args: rasttable, rastcolumn, srid, scale_x, scale_y, blocksize_x, blocksize_y, same_alignment, regular_blocking, num_bands=true, pixel_types=true, nodata_values=true, out_db=true, extent=true - Drops PostGIS raster constraints that refer to a raster table column. Useful if you need to reload data or update your raster column data.';


--
-- Name: droprasterconstraints(name, name, name, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION droprasterconstraints(rastschema name, rasttable name, rastcolumn name, srid boolean DEFAULT true, scale_x boolean DEFAULT true, scale_y boolean DEFAULT true, blocksize_x boolean DEFAULT true, blocksize_y boolean DEFAULT true, same_alignment boolean DEFAULT true, regular_blocking boolean DEFAULT true, num_bands boolean DEFAULT true, pixel_types boolean DEFAULT true, nodata_values boolean DEFAULT true, out_db boolean DEFAULT true, extent boolean DEFAULT true) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $_$
	DECLARE
		constraints text[];
	BEGIN
		IF srid IS TRUE THEN
			constraints := constraints || 'srid'::text;
		END IF;

		IF scale_x IS TRUE THEN
			constraints := constraints || 'scale_x'::text;
		END IF;

		IF scale_y IS TRUE THEN
			constraints := constraints || 'scale_y'::text;
		END IF;

		IF blocksize_x IS TRUE THEN
			constraints := constraints || 'blocksize_x'::text;
		END IF;

		IF blocksize_y IS TRUE THEN
			constraints := constraints || 'blocksize_y'::text;
		END IF;

		IF same_alignment IS TRUE THEN
			constraints := constraints || 'same_alignment'::text;
		END IF;

		IF regular_blocking IS TRUE THEN
			constraints := constraints || 'regular_blocking'::text;
		END IF;

		IF num_bands IS TRUE THEN
			constraints := constraints || 'num_bands'::text;
		END IF;

		IF pixel_types IS TRUE THEN
			constraints := constraints || 'pixel_types'::text;
		END IF;

		IF nodata_values IS TRUE THEN
			constraints := constraints || 'nodata_values'::text;
		END IF;

		IF out_db IS TRUE THEN
			constraints := constraints || 'out_db'::text;
		END IF;

		IF extent IS TRUE THEN
			constraints := constraints || 'extent'::text;
		END IF;

		RETURN DropRasterConstraints($1, $2, $3, VARIADIC constraints);
	END;
	$_$;


--
-- Name: FUNCTION droprasterconstraints(rastschema name, rasttable name, rastcolumn name, srid boolean, scale_x boolean, scale_y boolean, blocksize_x boolean, blocksize_y boolean, same_alignment boolean, regular_blocking boolean, num_bands boolean, pixel_types boolean, nodata_values boolean, out_db boolean, extent boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION droprasterconstraints(rastschema name, rasttable name, rastcolumn name, srid boolean, scale_x boolean, scale_y boolean, blocksize_x boolean, blocksize_y boolean, same_alignment boolean, regular_blocking boolean, num_bands boolean, pixel_types boolean, nodata_values boolean, out_db boolean, extent boolean) IS 'args: rastschema, rasttable, rastcolumn, srid=true, scale_x=true, scale_y=true, blocksize_x=true, blocksize_y=true, same_alignment=true, regular_blocking=true, num_bands=true, pixel_types=true, nodata_values=true, out_db=true, extent=true - Drops PostGIS raster constraints that refer to a raster table column. Useful if you need to reload data or update your raster column data.';


--
-- Name: enablelongtransactions(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION enablelongtransactions() RETURNS text
    LANGUAGE plpgsql
    AS $$ 
DECLARE
	"query" text;
	exists bool;
	rec RECORD;

BEGIN

	exists = 'f';
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorization_table'
	LOOP
		exists = 't';
	END LOOP;

	IF NOT exists
	THEN
		"query" = 'CREATE TABLE authorization_table (
			toid oid, -- table oid
			rid text, -- row id
			expires timestamp,
			authid text
		)';
		EXECUTE "query";
	END IF;

	exists = 'f';
	FOR rec IN SELECT * FROM pg_class WHERE relname = 'authorized_tables'
	LOOP
		exists = 't';
	END LOOP;

	IF NOT exists THEN
		"query" = 'CREATE VIEW authorized_tables AS ' ||
			'SELECT ' ||
			'n.nspname as schema, ' ||
			'c.relname as table, trim(' ||
			quote_literal(chr(92) || '000') ||
			' from t.tgargs) as id_column ' ||
			'FROM pg_trigger t, pg_class c, pg_proc p ' ||
			', pg_namespace n ' ||
			'WHERE p.proname = ' || quote_literal('checkauthtrigger') ||
			' AND c.relnamespace = n.oid' ||
			' AND t.tgfoid = p.oid and t.tgrelid = c.oid';
		EXECUTE "query";
	END IF;

	RETURN 'Long transactions support enabled';
END;
$$;


--
-- Name: FUNCTION enablelongtransactions(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION enablelongtransactions() IS 'Enable long transaction support. This function creates the required metadata tables, needs to be called once before using the other functions in this section. Calling it twice is harmless.';


--
-- Name: equals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION equals(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_Equals';


--
-- Name: find_srid(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION find_srid(character varying, character varying, character varying) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	schem text;
	tabl text;
	sr int4;
BEGIN
	IF $1 IS NULL THEN
	  RAISE EXCEPTION 'find_srid() - schema is NULL!';
	END IF;
	IF $2 IS NULL THEN
	  RAISE EXCEPTION 'find_srid() - table name is NULL!';
	END IF;
	IF $3 IS NULL THEN
	  RAISE EXCEPTION 'find_srid() - column name is NULL!';
	END IF;
	schem = $1;
	tabl = $2;
-- if the table contains a . and the schema is empty
-- split the table into a schema and a table
-- otherwise drop through to default behavior
	IF ( schem = '' and tabl LIKE '%.%' ) THEN
	 schem = substr(tabl,1,strpos(tabl,'.')-1);
	 tabl = substr(tabl,length(schem)+2);
	ELSE
	 schem = schem || '%';
	END IF;

	select SRID into sr from geometry_columns where f_table_schema like schem and f_table_name = tabl and f_geometry_column = $3;
	IF NOT FOUND THEN
	   RAISE EXCEPTION 'find_srid() - couldnt find the corresponding SRID - is the geometry registered in the GEOMETRY_COLUMNS table?  Is there an uppercase/lowercase missmatch?';
	END IF;
	return sr;
END;
$_$;


--
-- Name: FUNCTION find_srid(character varying, character varying, character varying); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION find_srid(character varying, character varying, character varying) IS 'args: a_schema_name, a_table_name, a_geomfield_name - The syntax is find_srid(<db/schema>, <table>, <column>) and the function returns the integer SRID of the specified column by searching through the GEOMETRY_COLUMNS table.';


--
-- Name: geography(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography(bytea) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_from_bytea';


--
-- Name: geography(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography(geometry) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_from_geometry';


--
-- Name: geography(geography, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography(geography, integer, boolean) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_enforce_typmod';


--
-- Name: geography_cmp(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_cmp(geography, geography) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_cmp';


--
-- Name: geography_eq(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_eq(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_eq';


--
-- Name: geography_ge(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_ge(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_ge';


--
-- Name: geography_gist_compress(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_compress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_compress';


--
-- Name: geography_gist_consistent(internal, geography, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_consistent(internal, geography, integer) RETURNS boolean
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_consistent';


--
-- Name: geography_gist_decompress(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_decompress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_decompress';


--
-- Name: geography_gist_join_selectivity(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_join_selectivity(internal, oid, internal, smallint) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'geography_gist_selectivity';


--
-- Name: geography_gist_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_penalty';


--
-- Name: geography_gist_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_picksplit(internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_picksplit';


--
-- Name: geography_gist_same(box2d, box2d, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_same(box2d, box2d, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_same';


--
-- Name: geography_gist_selectivity(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_selectivity(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'geography_gist_selectivity';


--
-- Name: geography_gist_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gist_union(bytea, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_union';


--
-- Name: geography_gt(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_gt(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_gt';


--
-- Name: geography_le(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_le(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_le';


--
-- Name: geography_lt(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_lt(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_lt';


--
-- Name: geography_overlaps(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geography_overlaps(geography, geography) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_overlaps';


--
-- Name: geometry(box2d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(box2d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX2D_to_LWGEOM';


--
-- Name: geometry(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(box3d) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_to_LWGEOM';


--
-- Name: geometry(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'parse_WKT_lwgeom';


--
-- Name: geometry(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_from_bytea';


--
-- Name: geometry(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(geography) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geometry_from_geography';


--
-- Name: geometry(geometry, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry(geometry, integer, boolean) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geometry_enforce_typmod';


--
-- Name: geometry_above(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_above(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_above_2d';


--
-- Name: geometry_below(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_below(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_below_2d';


--
-- Name: geometry_cmp(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_cmp(geom1 geometry, geom2 geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'lwgeom_cmp';


--
-- Name: geometry_contains(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_contains(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_contains_2d';


--
-- Name: geometry_distance_box(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_distance_box(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_distance_box_2d';


--
-- Name: geometry_distance_centroid(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_distance_centroid(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_distance_centroid_2d';


--
-- Name: geometry_eq(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_eq(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'lwgeom_eq';


--
-- Name: geometry_ge(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_ge(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'lwgeom_ge';


--
-- Name: geometry_gist_compress_2d(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_compress_2d(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_compress_2d';


--
-- Name: geometry_gist_compress_nd(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_compress_nd(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_compress';


--
-- Name: geometry_gist_consistent_2d(internal, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_consistent_2d(internal, geometry, integer) RETURNS boolean
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_consistent_2d';


--
-- Name: geometry_gist_consistent_nd(internal, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_consistent_nd(internal, geometry, integer) RETURNS boolean
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_consistent';


--
-- Name: geometry_gist_decompress_2d(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_decompress_2d(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_decompress_2d';


--
-- Name: geometry_gist_decompress_nd(internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_decompress_nd(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_decompress';


--
-- Name: geometry_gist_distance_2d(internal, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_distance_2d(internal, geometry, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_distance_2d';


--
-- Name: geometry_gist_joinsel_2d(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_joinsel_2d(internal, oid, internal, smallint) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'geometry_gist_joinsel_2d';


--
-- Name: geometry_gist_penalty_2d(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_penalty_2d(internal, internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_penalty_2d';


--
-- Name: geometry_gist_penalty_nd(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_penalty_nd(internal, internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_penalty';


--
-- Name: geometry_gist_picksplit_2d(internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_picksplit_2d(internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_picksplit_2d';


--
-- Name: geometry_gist_picksplit_nd(internal, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_picksplit_nd(internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_picksplit';


--
-- Name: geometry_gist_same_2d(geometry, geometry, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_same_2d(geom1 geometry, geom2 geometry, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_same_2d';


--
-- Name: geometry_gist_same_nd(geometry, geometry, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_same_nd(geometry, geometry, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_same';


--
-- Name: geometry_gist_sel_2d(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_sel_2d(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'geometry_gist_sel_2d';


--
-- Name: geometry_gist_union_2d(bytea, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_union_2d(bytea, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_union_2d';


--
-- Name: geometry_gist_union_nd(bytea, internal); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gist_union_nd(bytea, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'gserialized_gist_union';


--
-- Name: geometry_gt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_gt(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'lwgeom_gt';


--
-- Name: geometry_le(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_le(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'lwgeom_le';


--
-- Name: geometry_left(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_left(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_left_2d';


--
-- Name: geometry_lt(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_lt(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'lwgeom_lt';


--
-- Name: geometry_overabove(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overabove(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_overabove_2d';


--
-- Name: geometry_overbelow(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overbelow(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_overbelow_2d';


--
-- Name: geometry_overlaps(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overlaps(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_overlaps_2d';


--
-- Name: geometry_overlaps_nd(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overlaps_nd(geometry, geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_overlaps';


--
-- Name: geometry_overleft(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overleft(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_overleft_2d';


--
-- Name: geometry_overright(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_overright(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_overright_2d';


--
-- Name: geometry_raster_contain(geometry, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_raster_contain(geometry, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1 ~ $2::geometry$_$;


--
-- Name: geometry_raster_overlap(geometry, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_raster_overlap(geometry, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1 && $2::geometry$_$;


--
-- Name: geometry_right(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_right(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_right_2d';


--
-- Name: geometry_same(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_same(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_same_2d';


--
-- Name: geometry_within(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometry_within(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'gserialized_within_2d';


--
-- Name: geometrytype(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometrytype(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_getTYPE';


--
-- Name: FUNCTION geometrytype(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION geometrytype(geometry) IS 'args: geomA - Returns the type of the geometry as a string. Eg: LINESTRING, POLYGON, MULTIPOINT, etc.';


--
-- Name: geometrytype(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geometrytype(geography) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_getTYPE';


--
-- Name: geomfromewkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomfromewkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOMFromWKB';


--
-- Name: geomfromewkt(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION geomfromewkt(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'parse_WKT_lwgeom';


--
-- Name: get_proj4_from_srid(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION get_proj4_from_srid(integer) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
BEGIN
	RETURN proj4text::text FROM spatial_ref_sys WHERE srid= $1;
END;
$_$;


--
-- Name: gettransactionid(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION gettransactionid() RETURNS xid
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'getTransactionID';


--
-- Name: lockrow(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lockrow(text, text, text) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$ SELECT LockRow(current_schema(), $1, $2, $3, now()::timestamp+'1:00'); $_$;


--
-- Name: FUNCTION lockrow(text, text, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION lockrow(text, text, text) IS 'args: a_table_name, a_row_key, an_auth_token - Set lock/authorization for specific row in table';


--
-- Name: lockrow(text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lockrow(text, text, text, text) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$ SELECT LockRow($1, $2, $3, $4, now()::timestamp+'1:00'); $_$;


--
-- Name: lockrow(text, text, text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lockrow(text, text, text, timestamp without time zone) RETURNS integer
    LANGUAGE sql STRICT
    AS $_$ SELECT LockRow(current_schema(), $1, $2, $3, $4); $_$;


--
-- Name: FUNCTION lockrow(text, text, text, timestamp without time zone); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION lockrow(text, text, text, timestamp without time zone) IS 'args: a_table_name, a_row_key, an_auth_token, expire_dt - Set lock/authorization for specific row in table';


--
-- Name: lockrow(text, text, text, text, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lockrow(text, text, text, text, timestamp without time zone) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$ 
DECLARE
	myschema alias for $1;
	mytable alias for $2;
	myrid   alias for $3;
	authid alias for $4;
	expires alias for $5;
	ret int;
	mytoid oid;
	myrec RECORD;
	
BEGIN

	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	EXECUTE 'DELETE FROM authorization_table WHERE expires < now()'; 

	SELECT c.oid INTO mytoid FROM pg_class c, pg_namespace n
		WHERE c.relname = mytable
		AND c.relnamespace = n.oid
		AND n.nspname = myschema;

	-- RAISE NOTICE 'toid: %', mytoid;

	FOR myrec IN SELECT * FROM authorization_table WHERE 
		toid = mytoid AND rid = myrid
	LOOP
		IF myrec.authid != authid THEN
			RETURN 0;
		ELSE
			RETURN 1;
		END IF;
	END LOOP;

	EXECUTE 'INSERT INTO authorization_table VALUES ('||
		quote_literal(mytoid::text)||','||quote_literal(myrid)||
		','||quote_literal(expires::text)||
		','||quote_literal(authid) ||')';

	GET DIAGNOSTICS ret = ROW_COUNT;

	RETURN ret;
END;
$_$;


--
-- Name: FUNCTION lockrow(text, text, text, text, timestamp without time zone); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION lockrow(text, text, text, text, timestamp without time zone) IS 'args: a_schema_name, a_table_name, a_row_key, an_auth_token, expire_dt - Set lock/authorization for specific row in table';


--
-- Name: longtransactionsenabled(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION longtransactionsenabled() RETURNS boolean
    LANGUAGE plpgsql
    AS $$ 
DECLARE
	rec RECORD;
BEGIN
	FOR rec IN SELECT oid FROM pg_class WHERE relname = 'authorized_tables'
	LOOP
		return 't';
	END LOOP;
	return 'f';
END;
$$;


--
-- Name: pgis_geometry_accum_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_accum_finalfn(pgis_abs) RETURNS geometry[]
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'pgis_geometry_accum_finalfn';


--
-- Name: pgis_geometry_accum_transfn(pgis_abs, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_accum_transfn(pgis_abs, geometry) RETURNS pgis_abs
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'pgis_geometry_accum_transfn';


--
-- Name: pgis_geometry_collect_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_collect_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'pgis_geometry_collect_finalfn';


--
-- Name: pgis_geometry_makeline_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_makeline_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'pgis_geometry_makeline_finalfn';


--
-- Name: pgis_geometry_polygonize_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_polygonize_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'pgis_geometry_polygonize_finalfn';


--
-- Name: pgis_geometry_union_finalfn(pgis_abs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pgis_geometry_union_finalfn(pgis_abs) RETURNS geometry
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'pgis_geometry_union_finalfn';


--
-- Name: populate_geometry_columns(boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION populate_geometry_columns(use_typmod boolean DEFAULT true) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	inserted    integer;
	oldcount    integer;
	probed      integer;
	stale       integer;
	gcs         RECORD;
	gc          RECORD;
	gsrid       integer;
	gndims      integer;
	gtype       text;
	query       text;
	gc_is_valid boolean;

BEGIN
	SELECT count(*) INTO oldcount FROM geometry_columns;
	inserted := 0;

	-- Count the number of geometry columns in all tables and views
	SELECT count(DISTINCT c.oid) INTO probed
	FROM pg_class c,
		 pg_attribute a,
		 pg_type t,
		 pg_namespace n
	WHERE (c.relkind = 'r' OR c.relkind = 'v')
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND n.nspname NOT ILIKE 'pg_temp%' AND c.relname != 'raster_columns' ;

	-- Iterate through all non-dropped geometry columns
	RAISE DEBUG 'Processing Tables.....';

	FOR gcs IN
	SELECT DISTINCT ON (c.oid) c.oid, n.nspname, c.relname
		FROM pg_class c,
			 pg_attribute a,
			 pg_type t,
			 pg_namespace n
		WHERE c.relkind = 'r'
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND n.nspname NOT ILIKE 'pg_temp%' AND c.relname != 'raster_columns' 
	LOOP

		inserted := inserted + populate_geometry_columns(gcs.oid, use_typmod);
	END LOOP;

	IF oldcount > inserted THEN
	    stale = oldcount-inserted;
	ELSE
	    stale = 0;
	END IF;

	RETURN 'probed:' ||probed|| ' inserted:'||inserted;
END

$$;


--
-- Name: FUNCTION populate_geometry_columns(use_typmod boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION populate_geometry_columns(use_typmod boolean) IS 'args: use_typmod=true - Ensures geometry columns are defined with type modifiers or have appropriate spatial constraints This ensures they will be registered correctly in geometry_columns view. By default will convert all geometry columns with no type modifier to ones with type modifiers. To get old behavior set use_typmod=false';


--
-- Name: populate_geometry_columns(oid, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION populate_geometry_columns(tbl_oid oid, use_typmod boolean DEFAULT true) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	gcs         RECORD;
	gc          RECORD;
	gc_old      RECORD;
	gsrid       integer;
	gndims      integer;
	gtype       text;
	query       text;
	gc_is_valid boolean;
	inserted    integer;
	constraint_successful boolean := false;

BEGIN
	inserted := 0;

	-- Iterate through all geometry columns in this table
	FOR gcs IN
	SELECT n.nspname, c.relname, a.attname
		FROM pg_class c,
			 pg_attribute a,
			 pg_type t,
			 pg_namespace n
		WHERE c.relkind = 'r'
		AND t.typname = 'geometry'
		AND a.attisdropped = false
		AND a.atttypid = t.oid
		AND a.attrelid = c.oid
		AND c.relnamespace = n.oid
		AND n.nspname NOT ILIKE 'pg_temp%'
		AND c.oid = tbl_oid
	LOOP

        RAISE DEBUG 'Processing table %.%.%', gcs.nspname, gcs.relname, gcs.attname;
    
        gc_is_valid := true;
        -- Find the srid, coord_dimension, and type of current geometry
        -- in geometry_columns -- which is now a view
        
        SELECT type, srid, coord_dimension INTO gc_old 
            FROM geometry_columns 
            WHERE f_table_schema = gcs.nspname AND f_table_name = gcs.relname AND f_geometry_column = gcs.attname; 
            
        IF upper(gc_old.type) = 'GEOMETRY' THEN
        -- This is an unconstrained geometry we need to do something
        -- We need to figure out what to set the type by inspecting the data
            EXECUTE 'SELECT st_srid(' || quote_ident(gcs.attname) || ') As srid, GeometryType(' || quote_ident(gcs.attname) || ') As type, ST_NDims(' || quote_ident(gcs.attname) || ') As dims ' ||
                     ' FROM ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || 
                     ' WHERE ' || quote_ident(gcs.attname) || ' IS NOT NULL LIMIT 1;'
                INTO gc;
            IF gc IS NULL THEN -- there is no data so we can not determine geometry type
            	RAISE WARNING 'No data in table %.%, so no information to determine geometry type and srid', gcs.nspname, gcs.relname;
            	RETURN 0;
            END IF;
            gsrid := gc.srid; gtype := gc.type; gndims := gc.dims;
            	
            IF use_typmod THEN
                BEGIN
                    EXECUTE 'ALTER TABLE ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || ' ALTER COLUMN ' || quote_ident(gcs.attname) || 
                        ' TYPE geometry(' || postgis_type_name(gtype, gndims, true) || ', ' || gsrid::text  || ') ';
                    inserted := inserted + 1;
                EXCEPTION
                        WHEN invalid_parameter_value THEN
                        RAISE WARNING 'Could not convert ''%'' in ''%.%'' to use typmod with srid %, type: % ', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname), gsrid, postgis_type_name(gtype, gndims, true);
                            gc_is_valid := false;
                END;
                
            ELSE
                -- Try to apply srid check to column
            	constraint_successful = false;
                IF (gsrid > 0 AND postgis_constraint_srid(gcs.nspname, gcs.relname,gcs.attname) IS NULL ) THEN
                    BEGIN
                        EXECUTE 'ALTER TABLE ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || 
                                 ' ADD CONSTRAINT ' || quote_ident('enforce_srid_' || gcs.attname) || 
                                 ' CHECK (st_srid(' || quote_ident(gcs.attname) || ') = ' || gsrid || ')';
                        constraint_successful := true;
                    EXCEPTION
                        WHEN check_violation THEN
                            RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not apply constraint CHECK (st_srid(%) = %)', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname), quote_ident(gcs.attname), gsrid;
                            gc_is_valid := false;
                    END;
                END IF;
                
                -- Try to apply ndims check to column
                IF (gndims IS NOT NULL AND postgis_constraint_dims(gcs.nspname, gcs.relname,gcs.attname) IS NULL ) THEN
                    BEGIN
                        EXECUTE 'ALTER TABLE ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
                                 ADD CONSTRAINT ' || quote_ident('enforce_dims_' || gcs.attname) || '
                                 CHECK (st_ndims(' || quote_ident(gcs.attname) || ') = '||gndims||')';
                        constraint_successful := true;
                    EXCEPTION
                        WHEN check_violation THEN
                            RAISE WARNING 'Not inserting ''%'' in ''%.%'' into geometry_columns: could not apply constraint CHECK (st_ndims(%) = %)', quote_ident(gcs.attname), quote_ident(gcs.nspname), quote_ident(gcs.relname), quote_ident(gcs.attname), gndims;
                            gc_is_valid := false;
                    END;
                END IF;
    
                -- Try to apply geometrytype check to column
                IF (gtype IS NOT NULL AND postgis_constraint_type(gcs.nspname, gcs.relname,gcs.attname) IS NULL ) THEN
                    BEGIN
                        EXECUTE 'ALTER TABLE ONLY ' || quote_ident(gcs.nspname) || '.' || quote_ident(gcs.relname) || '
                        ADD CONSTRAINT ' || quote_ident('enforce_geotype_' || gcs.attname) || '
                        CHECK ((geometrytype(' || quote_ident(gcs.attname) || ') = ' || quote_literal(gtype) || ') OR (' || quote_ident(gcs.attname) || ' IS NULL))';
                        constraint_successful := true;
                    EXCEPTION
                        WHEN check_violation THEN
                            -- No geometry check can be applied. This column contains a number of geometry types.
                            RAISE WARNING 'Could not add geometry type check (%) to table column: %.%.%', gtype, quote_ident(gcs.nspname),quote_ident(gcs.relname),quote_ident(gcs.attname);
                    END;
                END IF;
                 --only count if we were successful in applying at least one constraint
                IF constraint_successful THEN
                	inserted := inserted + 1;
                END IF;
            END IF;	        
	    END IF;

	END LOOP;

	RETURN inserted;
END

$$;


--
-- Name: FUNCTION populate_geometry_columns(tbl_oid oid, use_typmod boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION populate_geometry_columns(tbl_oid oid, use_typmod boolean) IS 'args: relation_oid, use_typmod=true - Ensures geometry columns are defined with type modifiers or have appropriate spatial constraints This ensures they will be registered correctly in geometry_columns view. By default will convert all geometry columns with no type modifier to ones with type modifiers. To get old behavior set use_typmod=false';


--
-- Name: postgis_addbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_addbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_addBBOX';


--
-- Name: FUNCTION postgis_addbbox(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_addbbox(geometry) IS 'args: geomA - Add bounding box to the geometry.';


--
-- Name: postgis_cache_bbox(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_cache_bbox() RETURNS trigger
    LANGUAGE c
    AS '$libdir/postgis-2.0', 'cache_bbox';


--
-- Name: postgis_constraint_dims(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text) RETURNS integer
    LANGUAGE sql STABLE STRICT
    AS $_$
SELECT  replace(split_part(s.consrc, ' = ', 2), ')', '')::integer
		 FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
		 WHERE n.nspname = $1
		 AND c.relname = $2
		 AND a.attname = $3
		 AND a.attrelid = c.oid
		 AND s.connamespace = n.oid
		 AND s.conrelid = c.oid
		 AND a.attnum = ANY (s.conkey)
		 AND s.consrc LIKE '%ndims(% = %';
$_$;


--
-- Name: postgis_constraint_srid(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text) RETURNS integer
    LANGUAGE sql STABLE STRICT
    AS $_$
SELECT replace(replace(split_part(s.consrc, ' = ', 2), ')', ''), '(', '')::integer
		 FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
		 WHERE n.nspname = $1
		 AND c.relname = $2
		 AND a.attname = $3
		 AND a.attrelid = c.oid
		 AND s.connamespace = n.oid
		 AND s.conrelid = c.oid
		 AND a.attnum = ANY (s.conkey)
		 AND s.consrc LIKE '%srid(% = %';
$_$;


--
-- Name: postgis_constraint_type(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_constraint_type(geomschema text, geomtable text, geomcolumn text) RETURNS character varying
    LANGUAGE sql STABLE STRICT
    AS $_$
SELECT  replace(split_part(s.consrc, '''', 2), ')', '')::varchar		
		 FROM pg_class c, pg_namespace n, pg_attribute a, pg_constraint s
		 WHERE n.nspname = $1
		 AND c.relname = $2
		 AND a.attname = $3
		 AND a.attrelid = c.oid
		 AND s.connamespace = n.oid
		 AND s.conrelid = c.oid
		 AND a.attnum = ANY (s.conkey)
		 AND s.consrc LIKE '%geometrytype(% = %';
$_$;


--
-- Name: postgis_dropbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_dropbbox(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_dropBBOX';


--
-- Name: FUNCTION postgis_dropbbox(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_dropbbox(geometry) IS 'args: geomA - Drop the bounding box cache from the geometry.';


--
-- Name: postgis_full_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_full_version() RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
	libver text;
	svnver text;
	projver text;
	geosver text;
	gdalver text;
	libxmlver text;
	dbproc text;
	relproc text;
	fullver text;
	rast_lib_ver text;
	rast_scr_ver text;
	topo_scr_ver text;
	json_lib_ver text;
BEGIN
	SELECT postgis_lib_version() INTO libver;
	SELECT postgis_proj_version() INTO projver;
	SELECT postgis_geos_version() INTO geosver;
	SELECT postgis_libjson_version() INTO json_lib_ver;
	BEGIN
		SELECT postgis_gdal_version() INTO gdalver;
	EXCEPTION
		WHEN undefined_function THEN
			gdalver := NULL;
			RAISE NOTICE 'Function postgis_gdal_version() not found.  Is raster support enabled and rtpostgis.sql installed?';
	END;
	SELECT postgis_libxml_version() INTO libxmlver;
	SELECT postgis_scripts_installed() INTO dbproc;
	SELECT postgis_scripts_released() INTO relproc;
	select postgis_svn_version() INTO svnver;
	BEGIN
		SELECT postgis_topology_scripts_installed() INTO topo_scr_ver;
	EXCEPTION
		WHEN undefined_function THEN
			topo_scr_ver := NULL;
			RAISE NOTICE 'Function postgis_topology_scripts_installed() not found. Is topology support enabled and topology.sql installed?';
	END;

	BEGIN
		SELECT postgis_raster_scripts_installed() INTO rast_scr_ver;
	EXCEPTION
		WHEN undefined_function THEN
			rast_scr_ver := NULL;
			RAISE NOTICE 'Function postgis_raster_scripts_installed() not found. Is raster support enabled and rtpostgis.sql installed?';
	END;

	BEGIN
		SELECT postgis_raster_lib_version() INTO rast_lib_ver;
	EXCEPTION
		WHEN undefined_function THEN
			rast_lib_ver := NULL;
			RAISE NOTICE 'Function postgis_raster_lib_version() not found. Is raster support enabled and rtpostgis.sql installed?';
	END;

	fullver = 'POSTGIS="' || libver;

	IF  svnver IS NOT NULL THEN
		fullver = fullver || ' r' || svnver;
	END IF;

	fullver = fullver || '"';

	IF  geosver IS NOT NULL THEN
		fullver = fullver || ' GEOS="' || geosver || '"';
	END IF;

	IF  projver IS NOT NULL THEN
		fullver = fullver || ' PROJ="' || projver || '"';
	END IF;

	IF  gdalver IS NOT NULL THEN
		fullver = fullver || ' GDAL="' || gdalver || '"';
	END IF;

	IF  libxmlver IS NOT NULL THEN
		fullver = fullver || ' LIBXML="' || libxmlver || '"';
	END IF;

	IF json_lib_ver IS NOT NULL THEN
		fullver = fullver || ' LIBJSON="' || json_lib_ver || '"';
	END IF;

	-- fullver = fullver || ' DBPROC="' || dbproc || '"';
	-- fullver = fullver || ' RELPROC="' || relproc || '"';

	IF dbproc != relproc THEN
		fullver = fullver || ' (core procs from "' || dbproc || '" need upgrade)';
	END IF;

	IF topo_scr_ver IS NOT NULL THEN
		fullver = fullver || ' TOPOLOGY';
		IF topo_scr_ver != relproc THEN
			fullver = fullver || ' (topology procs from "' || topo_scr_ver || '" need upgrade)';
		END IF;
	END IF;

	IF rast_lib_ver IS NOT NULL THEN
		fullver = fullver || ' RASTER';
		IF rast_lib_ver != relproc THEN
			fullver = fullver || ' (raster lib from "' || rast_lib_ver || '" need upgrade)';
		END IF;
	END IF;

	IF rast_scr_ver IS NOT NULL AND rast_scr_ver != relproc THEN
		fullver = fullver || ' (raster procs from "' || rast_scr_ver || '" need upgrade)';
	END IF;

	RETURN fullver;
END
$$;


--
-- Name: FUNCTION postgis_full_version(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_full_version() IS 'Reports full postgis version and build configuration infos.';


--
-- Name: postgis_gdal_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_gdal_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_gdal_version';


--
-- Name: postgis_geos_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_geos_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'postgis_geos_version';


--
-- Name: FUNCTION postgis_geos_version(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_geos_version() IS 'Returns the version number of the GEOS library.';


--
-- Name: postgis_getbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_getbbox(geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_to_BOX2D';


--
-- Name: postgis_hasbbox(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_hasbbox(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_hasBBOX';


--
-- Name: FUNCTION postgis_hasbbox(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_hasbbox(geometry) IS 'args: geomA - Returns TRUE if the bbox of this geometry is cached, FALSE otherwise.';


--
-- Name: postgis_lib_build_date(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_lib_build_date() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'postgis_lib_build_date';


--
-- Name: FUNCTION postgis_lib_build_date(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_lib_build_date() IS 'Returns build date of the PostGIS library.';


--
-- Name: postgis_lib_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_lib_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'postgis_lib_version';


--
-- Name: FUNCTION postgis_lib_version(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_lib_version() IS 'Returns the version number of the PostGIS library.';


--
-- Name: postgis_libjson_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_libjson_version() RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'postgis_libjson_version';


--
-- Name: postgis_libxml_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_libxml_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'postgis_libxml_version';


--
-- Name: FUNCTION postgis_libxml_version(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_libxml_version() IS 'Returns the version number of the libxml2 library.';


--
-- Name: postgis_noop(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_noop(geometry) RETURNS geometry
    LANGUAGE c STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_noop';


--
-- Name: postgis_proj_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_proj_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'postgis_proj_version';


--
-- Name: FUNCTION postgis_proj_version(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_proj_version() IS 'Returns the version number of the PROJ4 library.';


--
-- Name: postgis_raster_lib_build_date(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_raster_lib_build_date() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_lib_build_date';


--
-- Name: FUNCTION postgis_raster_lib_build_date(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_raster_lib_build_date() IS 'Reports full raster library build date.';


--
-- Name: postgis_raster_lib_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_raster_lib_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_lib_version';


--
-- Name: FUNCTION postgis_raster_lib_version(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_raster_lib_version() IS 'Reports full raster version and build configuration infos.';


--
-- Name: postgis_raster_scripts_installed(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_raster_scripts_installed() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$ SELECT '2.0.1'::text || ' r' || 9979::text AS version $$;


--
-- Name: postgis_scripts_build_date(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_scripts_build_date() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '2012-07-20 06:58:54'::text AS version$$;


--
-- Name: FUNCTION postgis_scripts_build_date(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_scripts_build_date() IS 'Returns build date of the PostGIS scripts.';


--
-- Name: postgis_scripts_installed(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_scripts_installed() RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$ SELECT '2.0.1'::text || ' r' || 9979::text AS version $$;


--
-- Name: FUNCTION postgis_scripts_installed(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_scripts_installed() IS 'Returns version of the postgis scripts installed in this database.';


--
-- Name: postgis_scripts_released(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_scripts_released() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'postgis_scripts_released';


--
-- Name: FUNCTION postgis_scripts_released(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_scripts_released() IS 'Returns the version number of the postgis.sql script released with the installed postgis lib.';


--
-- Name: postgis_svn_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_svn_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'postgis_svn_version';


--
-- Name: postgis_transform_geometry(geometry, text, text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_transform_geometry(geometry, text, text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'transform_geom';


--
-- Name: postgis_type_name(character varying, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean DEFAULT true) RETURNS character varying
    LANGUAGE sql IMMUTABLE STRICT COST 200
    AS $_$
 SELECT CASE WHEN $3 THEN new_name ELSE old_name END As geomname
 	FROM 
 	( VALUES
 		 ('GEOMETRY', 'Geometry', 2) ,
 		 	('GEOMETRY', 'GeometryZ', 3) ,
 		 	('GEOMETRY', 'GeometryZM', 4) ,
			('GEOMETRYCOLLECTION', 'GeometryCollection', 2) ,
			('GEOMETRYCOLLECTION', 'GeometryCollectionZ', 3) ,
			('GEOMETRYCOLLECTIONM', 'GeometryCollectionM', 3) ,
			('GEOMETRYCOLLECTION', 'GeometryCollectionZM', 4) ,
			
			('POINT', 'Point',2) ,
			('POINTM','PointM',3) ,
			('POINT', 'PointZ',3) ,
			('POINT', 'PointZM',4) ,
			
			('MULTIPOINT','MultiPoint',2) ,
			('MULTIPOINT','MultiPointZ',3) ,
			('MULTIPOINTM','MultiPointM',3) ,
			('MULTIPOINT','MultiPointZM',4) ,
			
			('POLYGON', 'Polygon',2) ,
			('POLYGON', 'PolygonZ',3) ,
			('POLYGONM', 'PolygonM',3) ,
			('POLYGON', 'PolygonZM',4) ,
			
			('MULTIPOLYGON', 'MultiPolygon',2) ,
			('MULTIPOLYGON', 'MultiPolygonZ',3) ,
			('MULTIPOLYGONM', 'MultiPolygonM',3) ,
			('MULTIPOLYGON', 'MultiPolygonZM',4) ,
			
			('MULTILINESTRING', 'MultiLineString',2) ,
			('MULTILINESTRING', 'MultiLineStringZ',3) ,
			('MULTILINESTRINGM', 'MultiLineStringM',3) ,
			('MULTILINESTRING', 'MultiLineStringZM',4) ,
			
			('LINESTRING', 'LineString',2) ,
			('LINESTRING', 'LineStringZ',3) ,
			('LINESTRINGM', 'LineStringM',3) ,
			('LINESTRING', 'LineStringZM',4) ,
			
			('CIRCULARSTRING', 'CircularString',2) ,
			('CIRCULARSTRING', 'CircularStringZ',3) ,
			('CIRCULARSTRINGM', 'CircularStringM',3) ,
			('CIRCULARSTRING', 'CircularStringZM',4) ,
			
			('COMPOUNDCURVE', 'CompoundCurve',2) ,
			('COMPOUNDCURVE', 'CompoundCurveZ',3) ,
			('COMPOUNDCURVEM', 'CompoundCurveM',3) ,
			('COMPOUNDCURVE', 'CompoundCurveZM',4) ,
			
			('CURVEPOLYGON', 'CurvePolygon',2) ,
			('CURVEPOLYGON', 'CurvePolygonZ',3) ,
			('CURVEPOLYGONM', 'CurvePolygonM',3) ,
			('CURVEPOLYGON', 'CurvePolygonZM',4) ,
			
			('MULTICURVE', 'MultiCurve',2 ) ,
			('MULTICURVE', 'MultiCurveZ',3 ) ,
			('MULTICURVEM', 'MultiCurveM',3 ) ,
			('MULTICURVE', 'MultiCurveZM',4 ) ,
			
			('MULTISURFACE', 'MultiSurface', 2) ,
			('MULTISURFACE', 'MultiSurfaceZ', 3) ,
			('MULTISURFACEM', 'MultiSurfaceM', 3) ,
			('MULTISURFACE', 'MultiSurfaceZM', 4) ,
			
			('POLYHEDRALSURFACE', 'PolyhedralSurface',2) ,
			('POLYHEDRALSURFACE', 'PolyhedralSurfaceZ',3) ,
			('POLYHEDRALSURFACEM', 'PolyhedralSurfaceM',3) ,
			('POLYHEDRALSURFACE', 'PolyhedralSurfaceZM',4) ,
			
			('TRIANGLE', 'Triangle',2) ,
			('TRIANGLE', 'TriangleZ',3) ,
			('TRIANGLEM', 'TriangleM',3) ,
			('TRIANGLE', 'TriangleZM',4) ,

			('TIN', 'Tin', 2),
			('TIN', 'TinZ', 3),
			('TIN', 'TinM', 3),
			('TIN', 'TinZM', 4) )
			 As g(old_name, new_name, coord_dimension)
		WHERE (upper(old_name) = upper($1) OR upper(new_name) = upper($1))
			AND coord_dimension = $2;
$_$;


--
-- Name: postgis_typmod_dims(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_typmod_dims(integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'postgis_typmod_dims';


--
-- Name: postgis_typmod_srid(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_typmod_srid(integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'postgis_typmod_srid';


--
-- Name: postgis_typmod_type(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_typmod_type(integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'postgis_typmod_type';


--
-- Name: postgis_version(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION postgis_version() RETURNS text
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'postgis_version';


--
-- Name: FUNCTION postgis_version(); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION postgis_version() IS 'Returns PostGIS version number and compile-time options.';


--
-- Name: raster_above(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_above(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry |>> $2::geometry$_$;


--
-- Name: raster_below(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_below(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry <<| $2::geometry$_$;


--
-- Name: raster_contain(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_contain(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry ~ $2::geometry$_$;


--
-- Name: raster_contained(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_contained(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry @ $2::geometry$_$;


--
-- Name: raster_geometry_contain(raster, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_geometry_contain(raster, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry ~ $2$_$;


--
-- Name: raster_geometry_overlap(raster, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_geometry_overlap(raster, geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry && $2$_$;


--
-- Name: raster_left(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_left(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry << $2::geometry$_$;


--
-- Name: raster_overabove(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_overabove(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry |&> $2::geometry$_$;


--
-- Name: raster_overbelow(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_overbelow(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry &<| $2::geometry$_$;


--
-- Name: raster_overlap(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_overlap(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry && $2::geometry$_$;


--
-- Name: raster_overleft(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_overleft(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry &< $2::geometry$_$;


--
-- Name: raster_overright(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_overright(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry &> $2::geometry$_$;


--
-- Name: raster_right(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_right(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry >> $2::geometry$_$;


--
-- Name: raster_same(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION raster_same(raster, raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1::geometry ~= $2::geometry$_$;


--
-- Name: st_3dclosestpoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3dclosestpoint(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_closestpoint3d';


--
-- Name: FUNCTION st_3dclosestpoint(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3dclosestpoint(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns the 3-dimensional point on g1 that is closest to g2. This is the first point of the 3D shortest line.';


--
-- Name: st_3ddfullywithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3ddfullywithin(geom1 geometry, geom2 geometry, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && ST_Expand($2,$3) AND $2 && ST_Expand($1,$3) AND _ST_3DDFullyWithin($1, $2, $3)$_$;


--
-- Name: FUNCTION st_3ddfullywithin(geom1 geometry, geom2 geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3ddfullywithin(geom1 geometry, geom2 geometry, double precision) IS 'args: g1, g2, distance - Returns true if all of the 3D geometries are within the specified distance of one another.';


--
-- Name: st_3ddistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3ddistance(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_mindistance3d';


--
-- Name: FUNCTION st_3ddistance(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3ddistance(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - For geometry type Returns the 3-dimensional cartesian minimum distance (based on spatial ref) between two geometries in projected units.';


--
-- Name: st_3ddwithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3ddwithin(geom1 geometry, geom2 geometry, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && ST_Expand($2,$3) AND $2 && ST_Expand($1,$3) AND _ST_3DDWithin($1, $2, $3)$_$;


--
-- Name: FUNCTION st_3ddwithin(geom1 geometry, geom2 geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3ddwithin(geom1 geometry, geom2 geometry, double precision) IS 'args: g1, g2, distance_of_srid - For 3d (z) geometry type Returns true if two geometries 3d distance is within number of units.';


--
-- Name: st_3dintersects(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3dintersects(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_3DDWithin($1, $2, 0.0)$_$;


--
-- Name: FUNCTION st_3dintersects(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3dintersects(geom1 geometry, geom2 geometry) IS 'args: geomA, geomB - Returns TRUE if the Geometries "spatially intersect" in 3d - only for points and linestrings';


--
-- Name: st_3dlength(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3dlength(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_length_linestring';


--
-- Name: FUNCTION st_3dlength(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3dlength(geometry) IS 'args: a_3dlinestring - Returns the 3-dimensional or 2-dimensional length of the geometry if it is a linestring or multi-linestring.';


--
-- Name: st_3dlength_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3dlength_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_length_ellipsoid_linestring';


--
-- Name: FUNCTION st_3dlength_spheroid(geometry, spheroid); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3dlength_spheroid(geometry, spheroid) IS 'args: a_linestring, a_spheroid - Calculates the length of a geometry on an ellipsoid, taking the elevation into account. This is just an alias for ST_Length_Spheroid.';


--
-- Name: st_3dlongestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3dlongestline(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_longestline3d';


--
-- Name: FUNCTION st_3dlongestline(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3dlongestline(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns the 3-dimensional longest line between two geometries';


--
-- Name: st_3dmakebox(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3dmakebox(geom1 geometry, geom2 geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_construct';


--
-- Name: FUNCTION st_3dmakebox(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3dmakebox(geom1 geometry, geom2 geometry) IS 'args: point3DLowLeftBottom, point3DUpRightTop - Creates a BOX3D defined by the given 3d point geometries.';


--
-- Name: st_3dmaxdistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3dmaxdistance(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_maxdistance3d';


--
-- Name: FUNCTION st_3dmaxdistance(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3dmaxdistance(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - For geometry type Returns the 3-dimensional cartesian maximum distance (based on spatial ref) between two geometries in projected units.';


--
-- Name: st_3dperimeter(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3dperimeter(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_perimeter_poly';


--
-- Name: FUNCTION st_3dperimeter(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3dperimeter(geometry) IS 'args: geomA - Returns the 3-dimensional perimeter of the geometry, if it is a polygon or multi-polygon.';


--
-- Name: st_3dshortestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_3dshortestline(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_shortestline3d';


--
-- Name: FUNCTION st_3dshortestline(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_3dshortestline(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns the 3-dimensional shortest line between two geometries';


--
-- Name: st_addband(raster, raster[], integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_addband(torast raster, fromrasts raster[], fromband integer DEFAULT 1) RETURNS raster
    LANGUAGE plpgsql
    AS $$
	DECLARE var_result raster := torast;
		var_num integer := array_upper(fromrasts,1);
		var_i integer := 1; 
	BEGIN 
		IF torast IS NULL AND var_num > 0 THEN
			var_result := ST_Band(fromrasts[1],fromband); 
			var_i := 2;
		END IF;
		WHILE var_i <= var_num LOOP
			var_result := ST_AddBand(var_result, fromrasts[var_i], 1);
			var_i := var_i + 1;
		END LOOP;
		
		RETURN var_result;
	END;
$$;


--
-- Name: FUNCTION st_addband(torast raster, fromrasts raster[], fromband integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_addband(torast raster, fromrasts raster[], fromband integer) IS 'args: torast, fromrasts, fromband=1 - Returns a raster with the new band(s) of given type added with given initial value in the given index location. If no index is specified, the band is added to the end.';


--
-- Name: st_addband(raster, text, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_addband(rast raster, pixeltype text, initialvalue double precision DEFAULT 0::numeric, nodataval double precision DEFAULT NULL::double precision) RETURNS raster
    LANGUAGE sql IMMUTABLE
    AS $_$select st_addband($1, NULL, $2, $3, $4)$_$;


--
-- Name: FUNCTION st_addband(rast raster, pixeltype text, initialvalue double precision, nodataval double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_addband(rast raster, pixeltype text, initialvalue double precision, nodataval double precision) IS 'args: rast, pixeltype, initialvalue=0, nodataval=NULL - Returns a raster with the new band(s) of given type added with given initial value in the given index location. If no index is specified, the band is added to the end.';


--
-- Name: st_addband(raster, raster, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_addband(torast raster, fromrast raster, fromband integer DEFAULT 1, torastindex integer DEFAULT NULL::integer) RETURNS raster
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_copyband';


--
-- Name: FUNCTION st_addband(torast raster, fromrast raster, fromband integer, torastindex integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_addband(torast raster, fromrast raster, fromband integer, torastindex integer) IS 'args: torast, fromrast, fromband=1, torastindex=at_end - Returns a raster with the new band(s) of given type added with given initial value in the given index location. If no index is specified, the band is added to the end.';


--
-- Name: st_addband(raster, integer, text, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_addband(rast raster, index integer, pixeltype text, initialvalue double precision DEFAULT 0::numeric, nodataval double precision DEFAULT NULL::double precision) RETURNS raster
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_addband';


--
-- Name: FUNCTION st_addband(rast raster, index integer, pixeltype text, initialvalue double precision, nodataval double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_addband(rast raster, index integer, pixeltype text, initialvalue double precision, nodataval double precision) IS 'args: rast, index, pixeltype, initialvalue=0, nodataval=NULL - Returns a raster with the new band(s) of given type added with given initial value in the given index location. If no index is specified, the band is added to the end.';


--
-- Name: st_addmeasure(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_addmeasure(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_AddMeasure';


--
-- Name: FUNCTION st_addmeasure(geometry, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_addmeasure(geometry, double precision, double precision) IS 'args: geom_mline, measure_start, measure_end - Return a derived geometry with measure elements linearly interpolated between the start and end points. If the geometry has no measure dimension, one is added. If the geometry has a measure dimension, it is over-written with new values. Only LINESTRINGS and MULTILINESTRINGS are supported.';


--
-- Name: st_addpoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_addpoint(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_addpoint';


--
-- Name: FUNCTION st_addpoint(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_addpoint(geom1 geometry, geom2 geometry) IS 'args: linestring, point - Adds a point to a LineString before point <position> (0-based index).';


--
-- Name: st_addpoint(geometry, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_addpoint(geom1 geometry, geom2 geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_addpoint';


--
-- Name: FUNCTION st_addpoint(geom1 geometry, geom2 geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_addpoint(geom1 geometry, geom2 geometry, integer) IS 'args: linestring, point, position - Adds a point to a LineString before point <position> (0-based index).';


--
-- Name: st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Affine($1,  $2, $3, 0,  $4, $5, 0,  0, 0, 1,  $6, $7, 0)$_$;


--
-- Name: FUNCTION st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision) IS 'args: geomA, a, b, d, e, xoff, yoff - Applies a 3d affine transformation to the geometry to do things like translate, rotate, scale in one step.';


--
-- Name: st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_affine';


--
-- Name: FUNCTION st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_affine(geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) IS 'args: geomA, a, b, c, d, e, f, g, h, i, xoff, yoff, zoff - Applies a 3d affine transformation to the geometry to do things like translate, rotate, scale in one step.';


--
-- Name: st_approxcount(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxcount(rast raster, sample_percent double precision) RETURNS bigint
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_count($1, 1, TRUE, $2) $_$;


--
-- Name: st_approxcount(raster, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxcount(rast raster, nband integer, sample_percent double precision) RETURNS bigint
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_count($1, $2, TRUE, $3) $_$;


--
-- Name: st_approxcount(raster, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxcount(rast raster, exclude_nodata_value boolean, sample_percent double precision DEFAULT 0.1) RETURNS bigint
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_count($1, 1, $2, $3) $_$;


--
-- Name: st_approxcount(text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxcount(rastertable text, rastercolumn text, sample_percent double precision) RETURNS bigint
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_count($1, $2, 1, TRUE, $3) $_$;


--
-- Name: st_approxcount(raster, integer, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxcount(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 0.1) RETURNS bigint
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_count($1, $2, $3, $4) $_$;


--
-- Name: st_approxcount(text, text, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxcount(rastertable text, rastercolumn text, nband integer, sample_percent double precision) RETURNS bigint
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_count($1, $2, $3, TRUE, $4) $_$;


--
-- Name: st_approxcount(text, text, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxcount(rastertable text, rastercolumn text, exclude_nodata_value boolean, sample_percent double precision DEFAULT 0.1) RETURNS bigint
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_count($1, $2, 1, $3, $4) $_$;


--
-- Name: st_approxcount(text, text, integer, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxcount(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 0.1) RETURNS bigint
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_count($1, $2, $3, $4, $5) $_$;


--
-- Name: st_approxhistogram(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rast raster, sample_percent double precision) RETURNS SETOF histogram
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT min, max, count, percent FROM _st_histogram($1, 1, TRUE, $2, 0, NULL, FALSE) $_$;


--
-- Name: st_approxhistogram(raster, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rast raster, nband integer, sample_percent double precision) RETURNS SETOF histogram
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT min, max, count, percent FROM _st_histogram($1, $2, TRUE, $3, 0, NULL, FALSE) $_$;


--
-- Name: st_approxhistogram(text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rastertable text, rastercolumn text, sample_percent double precision) RETURNS SETOF histogram
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_histogram($1, $2, 1, TRUE, $3, 0, NULL, FALSE) $_$;


--
-- Name: st_approxhistogram(text, text, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rastertable text, rastercolumn text, nband integer, sample_percent double precision) RETURNS SETOF histogram
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_histogram($1, $2, $3, TRUE, $4, 0, NULL, FALSE) $_$;


--
-- Name: st_approxhistogram(raster, integer, double precision, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rast raster, nband integer, sample_percent double precision, bins integer, "right" boolean) RETURNS SETOF histogram
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT min, max, count, percent FROM _st_histogram($1, $2, TRUE, $3, $4, NULL, $5) $_$;


--
-- Name: st_approxhistogram(raster, integer, boolean, double precision, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rast raster, nband integer, exclude_nodata_value boolean, sample_percent double precision, bins integer, "right" boolean) RETURNS SETOF histogram
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT min, max, count, percent FROM _st_histogram($1, $2, $3, $4, $5, NULL, $6) $_$;


--
-- Name: st_approxhistogram(raster, integer, double precision, integer, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rast raster, nband integer, sample_percent double precision, bins integer, width double precision[] DEFAULT NULL::double precision[], "right" boolean DEFAULT false) RETURNS SETOF histogram
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT min, max, count, percent FROM _st_histogram($1, $2, TRUE, $3, $4, $5, $6) $_$;


--
-- Name: st_approxhistogram(text, text, integer, double precision, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rastertable text, rastercolumn text, nband integer, sample_percent double precision, bins integer, "right" boolean) RETURNS SETOF histogram
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_histogram($1, $2, $3, TRUE, $4, $5, NULL, $6) $_$;


--
-- Name: st_approxhistogram(raster, integer, boolean, double precision, integer, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 0.1, bins integer DEFAULT 0, width double precision[] DEFAULT NULL::double precision[], "right" boolean DEFAULT false) RETURNS SETOF histogram
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT min, max, count, percent FROM _st_histogram($1, $2, $3, $4, $5, $6, $7) $_$;


--
-- Name: st_approxhistogram(text, text, integer, boolean, double precision, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, sample_percent double precision, bins integer, "right" boolean) RETURNS SETOF histogram
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_histogram($1, $2, $3, $4, $5, $6, NULL, $7) $_$;


--
-- Name: st_approxhistogram(text, text, integer, double precision, integer, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rastertable text, rastercolumn text, nband integer, sample_percent double precision, bins integer, width double precision[] DEFAULT NULL::double precision[], "right" boolean DEFAULT false) RETURNS SETOF histogram
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_histogram($1, $2, $3, TRUE, $4, $5, $6, $7) $_$;


--
-- Name: st_approxhistogram(text, text, integer, boolean, double precision, integer, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxhistogram(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 0.1, bins integer DEFAULT 0, width double precision[] DEFAULT NULL::double precision[], "right" boolean DEFAULT false) RETURNS SETOF histogram
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_histogram($1, $2, $3, $4, $5, $6, $7, $8) $_$;


--
-- Name: st_approxquantile(raster, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rast raster, quantiles double precision[]) RETURNS SETOF quantile
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_quantile($1, 1, TRUE, 0.1, $2) $_$;


--
-- Name: st_approxquantile(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rast raster, quantile double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT (_st_quantile($1, 1, TRUE, 0.1, ARRAY[$2]::double precision[])).value $_$;


--
-- Name: st_approxquantile(raster, double precision, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rast raster, sample_percent double precision, quantiles double precision[] DEFAULT NULL::double precision[]) RETURNS SETOF quantile
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT _st_quantile($1, 1, TRUE, $2, $3) $_$;


--
-- Name: st_approxquantile(raster, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rast raster, sample_percent double precision, quantile double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_quantile($1, 1, TRUE, $2, ARRAY[$3]::double precision[])).value $_$;


--
-- Name: st_approxquantile(raster, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rast raster, exclude_nodata_value boolean, quantile double precision DEFAULT NULL::double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT (_st_quantile($1, 1, $2, 0.1, ARRAY[$3]::double precision[])).value $_$;


--
-- Name: st_approxquantile(text, text, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rastertable text, rastercolumn text, quantiles double precision[]) RETURNS SETOF quantile
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_quantile($1, $2, 1, TRUE, 0.1, $3) $_$;


--
-- Name: st_approxquantile(text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rastertable text, rastercolumn text, quantile double precision) RETURNS double precision
    LANGUAGE sql STABLE
    AS $_$ SELECT (_st_quantile($1, $2, 1, TRUE, 0.1, ARRAY[$3]::double precision[])).value $_$;


--
-- Name: st_approxquantile(raster, integer, double precision, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rast raster, nband integer, sample_percent double precision, quantiles double precision[] DEFAULT NULL::double precision[]) RETURNS SETOF quantile
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT _st_quantile($1, $2, TRUE, $3, $4) $_$;


--
-- Name: st_approxquantile(raster, integer, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rast raster, nband integer, sample_percent double precision, quantile double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_quantile($1, $2, TRUE, $3, ARRAY[$4]::double precision[])).value $_$;


--
-- Name: st_approxquantile(text, text, double precision, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rastertable text, rastercolumn text, sample_percent double precision, quantiles double precision[] DEFAULT NULL::double precision[]) RETURNS SETOF quantile
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_quantile($1, $2, 1, TRUE, $3, $4) $_$;


--
-- Name: st_approxquantile(text, text, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rastertable text, rastercolumn text, sample_percent double precision, quantile double precision) RETURNS double precision
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_quantile($1, $2, 1, TRUE, $3, ARRAY[$4]::double precision[])).value $_$;


--
-- Name: st_approxquantile(text, text, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rastertable text, rastercolumn text, exclude_nodata_value boolean, quantile double precision DEFAULT NULL::double precision) RETURNS double precision
    LANGUAGE sql STABLE
    AS $_$ SELECT (_st_quantile($1, $2, 1, $3, 0.1, ARRAY[$4]::double precision[])).value $_$;


--
-- Name: st_approxquantile(raster, integer, boolean, double precision, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 0.1, quantiles double precision[] DEFAULT NULL::double precision[]) RETURNS SETOF quantile
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT _st_quantile($1, $2, $3, $4, $5) $_$;


--
-- Name: st_approxquantile(raster, integer, boolean, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rast raster, nband integer, exclude_nodata_value boolean, sample_percent double precision, quantile double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_quantile($1, $2, $3, $4, ARRAY[$5]::double precision[])).value $_$;


--
-- Name: st_approxquantile(text, text, integer, double precision, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rastertable text, rastercolumn text, nband integer, sample_percent double precision, quantiles double precision[] DEFAULT NULL::double precision[]) RETURNS SETOF quantile
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_quantile($1, $2, $3, TRUE, $4, $5) $_$;


--
-- Name: st_approxquantile(text, text, integer, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rastertable text, rastercolumn text, nband integer, sample_percent double precision, quantile double precision) RETURNS double precision
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_quantile($1, $2, $3, TRUE, $4, ARRAY[$5]::double precision[])).value $_$;


--
-- Name: st_approxquantile(text, text, integer, boolean, double precision, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 0.1, quantiles double precision[] DEFAULT NULL::double precision[]) RETURNS SETOF quantile
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_quantile($1, $2, $3, $4, $5, $6) $_$;


--
-- Name: st_approxquantile(text, text, integer, boolean, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxquantile(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, sample_percent double precision, quantile double precision) RETURNS double precision
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_quantile($1, $2, $3, $4, $5, ARRAY[$6]::double precision[])).value $_$;


--
-- Name: st_approxsummarystats(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxsummarystats(rast raster, sample_percent double precision) RETURNS summarystats
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_summarystats($1, 1, TRUE, $2) $_$;


--
-- Name: st_approxsummarystats(raster, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxsummarystats(rast raster, nband integer, sample_percent double precision) RETURNS summarystats
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_summarystats($1, $2, TRUE, $3) $_$;


--
-- Name: st_approxsummarystats(raster, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxsummarystats(rast raster, exclude_nodata_value boolean, sample_percent double precision DEFAULT 0.1) RETURNS summarystats
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_summarystats($1, 1, $2, $3) $_$;


--
-- Name: st_approxsummarystats(text, text, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxsummarystats(rastertable text, rastercolumn text, exclude_nodata_value boolean) RETURNS summarystats
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_summarystats($1, $2, 1, $3, 0.1) $_$;


--
-- Name: st_approxsummarystats(text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxsummarystats(rastertable text, rastercolumn text, sample_percent double precision) RETURNS summarystats
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_summarystats($1, $2, 1, TRUE, $3) $_$;


--
-- Name: st_approxsummarystats(raster, integer, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxsummarystats(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 0.1) RETURNS summarystats
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_summarystats($1, $2, $3, $4) $_$;


--
-- Name: st_approxsummarystats(text, text, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxsummarystats(rastertable text, rastercolumn text, nband integer, sample_percent double precision) RETURNS summarystats
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_summarystats($1, $2, $3, TRUE, $4) $_$;


--
-- Name: st_approxsummarystats(text, text, integer, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_approxsummarystats(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, sample_percent double precision DEFAULT 0.1) RETURNS summarystats
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_summarystats($1, $2, $3, $4, $5) $_$;


--
-- Name: st_area(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_area(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_area_polygon';


--
-- Name: FUNCTION st_area(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_area(geometry) IS 'args: g1 - Returns the area of the surface if it is a polygon or multi-polygon. For "geometry" type area is in SRID units. For "geography" area is in square meters.';


--
-- Name: st_area(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_area(text) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Area($1::geometry);  $_$;


--
-- Name: st_area(geography, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_area(geog geography, use_spheroid boolean DEFAULT true) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'geography_area';


--
-- Name: FUNCTION st_area(geog geography, use_spheroid boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_area(geog geography, use_spheroid boolean) IS 'args: geog, use_spheroid=true - Returns the area of the surface if it is a polygon or multi-polygon. For "geometry" type area is in SRID units. For "geography" area is in square meters.';


--
-- Name: st_area2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_area2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_area_polygon';


--
-- Name: st_asbinary(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asbinary(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asBinary';


--
-- Name: FUNCTION st_asbinary(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asbinary(geometry) IS 'args: g1 - Return the Well-Known Binary (WKB) representation of the geometry/geography without SRID meta data.';


--
-- Name: st_asbinary(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asbinary(geography) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asBinary';


--
-- Name: FUNCTION st_asbinary(geography); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asbinary(geography) IS 'args: g1 - Return the Well-Known Binary (WKB) representation of the geometry/geography without SRID meta data.';


--
-- Name: st_asbinary(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asbinary(raster) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_to_binary';


--
-- Name: FUNCTION st_asbinary(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asbinary(raster) IS 'args: rast - Return the Well-Known Binary (WKB) representation of the raster without SRID meta data.';


--
-- Name: st_asbinary(geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asbinary(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asBinary';


--
-- Name: FUNCTION st_asbinary(geometry, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asbinary(geometry, text) IS 'args: g1, NDR_or_XDR - Return the Well-Known Binary (WKB) representation of the geometry/geography without SRID meta data.';


--
-- Name: st_asbinary(geography, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asbinary(geography, text) RETURNS bytea
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsBinary($1::geometry, $2);  $_$;


--
-- Name: FUNCTION st_asbinary(geography, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asbinary(geography, text) IS 'args: g1, NDR_or_XDR - Return the Well-Known Binary (WKB) representation of the geometry/geography without SRID meta data.';


--
-- Name: st_asewkb(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asewkb(geometry) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'WKBFromLWGEOM';


--
-- Name: FUNCTION st_asewkb(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asewkb(geometry) IS 'args: g1 - Return the Well-Known Binary (WKB) representation of the geometry with SRID meta data.';


--
-- Name: st_asewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asewkb(geometry, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'WKBFromLWGEOM';


--
-- Name: FUNCTION st_asewkb(geometry, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asewkb(geometry, text) IS 'args: g1, NDR_or_XDR - Return the Well-Known Binary (WKB) representation of the geometry with SRID meta data.';


--
-- Name: st_asewkt(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asewkt(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asEWKT';


--
-- Name: FUNCTION st_asewkt(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asewkt(geometry) IS 'args: g1 - Return the Well-Known Text (WKT) representation of the geometry with SRID meta data.';


--
-- Name: st_asewkt(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asewkt(geography) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asEWKT';


--
-- Name: FUNCTION st_asewkt(geography); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asewkt(geography) IS 'args: g1 - Return the Well-Known Text (WKT) representation of the geometry with SRID meta data.';


--
-- Name: st_asewkt(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asewkt(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsEWKT($1::geometry);  $_$;


--
-- Name: st_asgdalraster(raster, text, text[], integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgdalraster(rast raster, format text, options text[] DEFAULT NULL::text[], srid integer DEFAULT NULL::integer) RETURNS bytea
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_asGDALRaster';


--
-- Name: FUNCTION st_asgdalraster(rast raster, format text, options text[], srid integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asgdalraster(rast raster, format text, options text[], srid integer) IS 'args: rast, format, options=NULL, srid=sameassource - Return the raster tile in the designated GDAL Raster format. Raster formats are one of those supported by your compiled library. Use ST_GDALRasters() to get a list of formats supported by your library.';


--
-- Name: st_asgeojson(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_AsGeoJson(1, $1::geometry,15,0);  $_$;


--
-- Name: st_asgeojson(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(geom geometry, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_AsGeoJson(1, $1, $2, $3); $_$;


--
-- Name: FUNCTION st_asgeojson(geom geometry, maxdecimaldigits integer, options integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asgeojson(geom geometry, maxdecimaldigits integer, options integer) IS 'args: geom, maxdecimaldigits=15, options=0 - Return the geometry as a GeoJSON element.';


--
-- Name: st_asgeojson(geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(geog geography, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_AsGeoJson(1, $1, $2, $3); $_$;


--
-- Name: FUNCTION st_asgeojson(geog geography, maxdecimaldigits integer, options integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asgeojson(geog geography, maxdecimaldigits integer, options integer) IS 'args: geog, maxdecimaldigits=15, options=0 - Return the geometry as a GeoJSON element.';


--
-- Name: st_asgeojson(integer, geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(gj_version integer, geom geometry, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_AsGeoJson($1, $2, $3, $4); $_$;


--
-- Name: FUNCTION st_asgeojson(gj_version integer, geom geometry, maxdecimaldigits integer, options integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asgeojson(gj_version integer, geom geometry, maxdecimaldigits integer, options integer) IS 'args: gj_version, geom, maxdecimaldigits=15, options=0 - Return the geometry as a GeoJSON element.';


--
-- Name: st_asgeojson(integer, geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgeojson(gj_version integer, geog geography, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_AsGeoJson($1, $2, $3, $4); $_$;


--
-- Name: FUNCTION st_asgeojson(gj_version integer, geog geography, maxdecimaldigits integer, options integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asgeojson(gj_version integer, geog geography, maxdecimaldigits integer, options integer) IS 'args: gj_version, geog, maxdecimaldigits=15, options=0 - Return the geometry as a GeoJSON element.';


--
-- Name: st_asgml(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_AsGML(2,$1::geometry,15,0, NULL);  $_$;


--
-- Name: st_asgml(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(geom geometry, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_AsGML(2, $1, $2, $3, null); $_$;


--
-- Name: FUNCTION st_asgml(geom geometry, maxdecimaldigits integer, options integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asgml(geom geometry, maxdecimaldigits integer, options integer) IS 'args: geom, maxdecimaldigits=15, options=0 - Return the geometry as a GML version 2 or 3 element.';


--
-- Name: st_asgml(geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(geog geography, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsGML(2, $1, $2, $3, null)$_$;


--
-- Name: FUNCTION st_asgml(geog geography, maxdecimaldigits integer, options integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asgml(geog geography, maxdecimaldigits integer, options integer) IS 'args: geog, maxdecimaldigits=15, options=0 - Return the geometry as a GML version 2 or 3 element.';


--
-- Name: st_asgml(integer, geometry, integer, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(version integer, geom geometry, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0, nprefix text DEFAULT NULL::text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT _ST_AsGML($1, $2, $3, $4,$5); $_$;


--
-- Name: FUNCTION st_asgml(version integer, geom geometry, maxdecimaldigits integer, options integer, nprefix text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asgml(version integer, geom geometry, maxdecimaldigits integer, options integer, nprefix text) IS 'args: version, geom, maxdecimaldigits=15, options=0, nprefix=null - Return the geometry as a GML version 2 or 3 element.';


--
-- Name: st_asgml(integer, geography, integer, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asgml(version integer, geog geography, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0, nprefix text DEFAULT NULL::text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT _ST_AsGML($1, $2, $3, $4, $5);$_$;


--
-- Name: FUNCTION st_asgml(version integer, geog geography, maxdecimaldigits integer, options integer, nprefix text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asgml(version integer, geog geography, maxdecimaldigits integer, options integer, nprefix text) IS 'args: version, geog, maxdecimaldigits=15, options=0, nprefix=null - Return the geometry as a GML version 2 or 3 element.';


--
-- Name: st_ashexewkb(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_ashexewkb(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asHEXEWKB';


--
-- Name: FUNCTION st_ashexewkb(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_ashexewkb(geometry) IS 'args: g1 - Returns a Geometry in HEXEWKB format (as text) using either little-endian (NDR) or big-endian (XDR) encoding.';


--
-- Name: st_ashexewkb(geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_ashexewkb(geometry, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asHEXEWKB';


--
-- Name: FUNCTION st_ashexewkb(geometry, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_ashexewkb(geometry, text) IS 'args: g1, NDRorXDR - Returns a Geometry in HEXEWKB format (as text) using either little-endian (NDR) or big-endian (XDR) encoding.';


--
-- Name: st_asjpeg(raster, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asjpeg(rast raster, options text[] DEFAULT NULL::text[]) RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
	DECLARE
		rast2 raster;
		num_bands int;
		i int;
	BEGIN
		num_bands := st_numbands($1);

		-- JPEG allows 1 or 3 bands
		IF num_bands <> 1 AND num_bands <> 3 THEN
			RAISE NOTICE 'The JPEG format only permits one or three bands.  The first band will be used.';
			rast2 := st_band(rast, ARRAY[1]);
			num_bands := st_numbands(rast);
		ELSE
			rast2 := rast;
		END IF;

		-- JPEG only supports 8BUI pixeltype
		FOR i IN 1..num_bands LOOP
			IF st_bandpixeltype(rast, i) != '8BUI' THEN
				RAISE EXCEPTION 'The pixel type of band % in the raster is not 8BUI.  The JPEG format can only be used with the 8BUI pixel type.', i;
			END IF;
		END LOOP;

		RETURN st_asgdalraster(rast2, 'JPEG', $2, NULL);
	END;
	$_$;


--
-- Name: FUNCTION st_asjpeg(rast raster, options text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asjpeg(rast raster, options text[]) IS 'args: rast, options=NULL - Return the raster tile selected bands as a single Joint Photographic Exports Group (JPEG) image (byte array). If no band is specified and 1 or more than 3 bands, then only the first band is used. If only 3 bands then all 3 bands are used and mapped to RGB.';


--
-- Name: st_asjpeg(raster, integer[], text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asjpeg(rast raster, nbands integer[], options text[] DEFAULT NULL::text[]) RETURNS bytea
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT st_asjpeg(st_band($1, $2), $3) $_$;


--
-- Name: FUNCTION st_asjpeg(rast raster, nbands integer[], options text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asjpeg(rast raster, nbands integer[], options text[]) IS 'args: rast, nbands, options=NULL - Return the raster tile selected bands as a single Joint Photographic Exports Group (JPEG) image (byte array). If no band is specified and 1 or more than 3 bands, then only the first band is used. If only 3 bands then all 3 bands are used and mapped to RGB.';


--
-- Name: st_asjpeg(raster, integer[], integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asjpeg(rast raster, nbands integer[], quality integer) RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
	DECLARE
		quality2 int;
		options text[];
	BEGIN
		IF quality IS NOT NULL THEN
			IF quality > 100 THEN
				quality2 := 100;
			ELSEIF quality < 10 THEN
				quality2 := 10;
			ELSE
				quality2 := quality;
			END IF;

			options := array_append(options, 'QUALITY=' || quality2);
		END IF;

		RETURN st_asjpeg(st_band($1, $2), options);
	END;
	$_$;


--
-- Name: FUNCTION st_asjpeg(rast raster, nbands integer[], quality integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asjpeg(rast raster, nbands integer[], quality integer) IS 'args: rast, nbands, quality - Return the raster tile selected bands as a single Joint Photographic Exports Group (JPEG) image (byte array). If no band is specified and 1 or more than 3 bands, then only the first band is used. If only 3 bands then all 3 bands are used and mapped to RGB.';


--
-- Name: st_asjpeg(raster, integer, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asjpeg(rast raster, nband integer, options text[] DEFAULT NULL::text[]) RETURNS bytea
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT st_asjpeg(st_band($1, $2), $3) $_$;


--
-- Name: FUNCTION st_asjpeg(rast raster, nband integer, options text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asjpeg(rast raster, nband integer, options text[]) IS 'args: rast, nband, options=NULL - Return the raster tile selected bands as a single Joint Photographic Exports Group (JPEG) image (byte array). If no band is specified and 1 or more than 3 bands, then only the first band is used. If only 3 bands then all 3 bands are used and mapped to RGB.';


--
-- Name: st_asjpeg(raster, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asjpeg(rast raster, nband integer, quality integer) RETURNS bytea
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT st_asjpeg($1, ARRAY[$2], $3) $_$;


--
-- Name: FUNCTION st_asjpeg(rast raster, nband integer, quality integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asjpeg(rast raster, nband integer, quality integer) IS 'args: rast, nband, quality - Return the raster tile selected bands as a single Joint Photographic Exports Group (JPEG) image (byte array). If no band is specified and 1 or more than 3 bands, then only the first band is used. If only 3 bands then all 3 bands are used and mapped to RGB.';


--
-- Name: st_askml(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_AsKML(2, $1::geometry, 15, null);  $_$;


--
-- Name: st_askml(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(geom geometry, maxdecimaldigits integer DEFAULT 15) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_AsKML(2, ST_Transform($1,4326), $2, null); $_$;


--
-- Name: FUNCTION st_askml(geom geometry, maxdecimaldigits integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_askml(geom geometry, maxdecimaldigits integer) IS 'args: geom, maxdecimaldigits=15 - Return the geometry as a KML element. Several variants. Default version=2, default precision=15';


--
-- Name: st_askml(geography, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(geog geography, maxdecimaldigits integer DEFAULT 15) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_AsKML(2, $1, $2, null)$_$;


--
-- Name: FUNCTION st_askml(geog geography, maxdecimaldigits integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_askml(geog geography, maxdecimaldigits integer) IS 'args: geog, maxdecimaldigits=15 - Return the geometry as a KML element. Several variants. Default version=2, default precision=15';


--
-- Name: st_askml(integer, geometry, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(version integer, geom geometry, maxdecimaldigits integer DEFAULT 15, nprefix text DEFAULT NULL::text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT _ST_AsKML($1, ST_Transform($2,4326), $3, $4); $_$;


--
-- Name: FUNCTION st_askml(version integer, geom geometry, maxdecimaldigits integer, nprefix text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_askml(version integer, geom geometry, maxdecimaldigits integer, nprefix text) IS 'args: version, geom, maxdecimaldigits=15, nprefix=NULL - Return the geometry as a KML element. Several variants. Default version=2, default precision=15';


--
-- Name: st_askml(integer, geography, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_askml(version integer, geog geography, maxdecimaldigits integer DEFAULT 15, nprefix text DEFAULT NULL::text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT _ST_AsKML($1, $2, $3, $4)$_$;


--
-- Name: FUNCTION st_askml(version integer, geog geography, maxdecimaldigits integer, nprefix text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_askml(version integer, geog geography, maxdecimaldigits integer, nprefix text) IS 'args: version, geog, maxdecimaldigits=15, nprefix=NULL - Return the geometry as a KML element. Several variants. Default version=2, default precision=15';


--
-- Name: st_aslatlontext(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_aslatlontext(geometry) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsLatLonText($1, '') $_$;


--
-- Name: FUNCTION st_aslatlontext(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_aslatlontext(geometry) IS 'args: pt - Return the Degrees, Minutes, Seconds representation of the given point.';


--
-- Name: st_aslatlontext(geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_aslatlontext(geometry, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_to_latlon';


--
-- Name: FUNCTION st_aslatlontext(geometry, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_aslatlontext(geometry, text) IS 'args: pt, format - Return the Degrees, Minutes, Seconds representation of the given point.';


--
-- Name: st_aspect(raster, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_aspect(rast raster, band integer, pixeltype text) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_mapalgebrafctngb($1, $2, $3, 1, 1, '_st_aspect4ma(float[][], text, text[])'::regprocedure, 'value', st_pixelwidth($1)::text, st_pixelheight($1)::text) $_$;


--
-- Name: FUNCTION st_aspect(rast raster, band integer, pixeltype text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_aspect(rast raster, band integer, pixeltype text) IS 'args: rast, band, pixeltype - Returns the surface aspect of an elevation raster band. Useful for analyzing terrain.';


--
-- Name: st_aspng(raster, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_aspng(rast raster, options text[] DEFAULT NULL::text[]) RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
	DECLARE
		rast2 raster;
		num_bands int;
		i int;
		pt text;
	BEGIN
		num_bands := st_numbands($1);

		-- PNG allows 1, 3 or 4 bands
		IF num_bands <> 1 AND num_bands <> 3 AND num_bands <> 4 THEN
			RAISE NOTICE 'The PNG format only permits one, three or four bands.  The first band will be used.';
			rast2 := st_band($1, ARRAY[1]);
			num_bands := st_numbands(rast2);
		ELSE
			rast2 := rast;
		END IF;

		-- PNG only supports 8BUI and 16BUI pixeltype
		FOR i IN 1..num_bands LOOP
			pt = st_bandpixeltype(rast, i);
			IF pt != '8BUI' AND pt != '16BUI' THEN
				RAISE EXCEPTION 'The pixel type of band % in the raster is not 8BUI or 16BUI.  The PNG format can only be used with 8BUI and 16BUI pixel types.', i;
			END IF;
		END LOOP;

		RETURN st_asgdalraster(rast2, 'PNG', $2, NULL);
	END;
	$_$;


--
-- Name: FUNCTION st_aspng(rast raster, options text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_aspng(rast raster, options text[]) IS 'args: rast, options=NULL - Return the raster tile selected bands as a single portable network graphics (PNG) image (byte array). If 1, 3, or 4 bands in raster and no bands are specified, then all bands are used. If more 2 or more than 4 bands and no bands specified, then only band 1 is used. Bands are mapped to RGB or RGBA space.';


--
-- Name: st_aspng(raster, integer[], text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_aspng(rast raster, nbands integer[], options text[] DEFAULT NULL::text[]) RETURNS bytea
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT st_aspng(st_band($1, $2), $3) $_$;


--
-- Name: FUNCTION st_aspng(rast raster, nbands integer[], options text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_aspng(rast raster, nbands integer[], options text[]) IS 'args: rast, nbands, options=NULL - Return the raster tile selected bands as a single portable network graphics (PNG) image (byte array). If 1, 3, or 4 bands in raster and no bands are specified, then all bands are used. If more 2 or more than 4 bands and no bands specified, then only band 1 is used. Bands are mapped to RGB or RGBA space.';


--
-- Name: st_aspng(raster, integer[], integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_aspng(rast raster, nbands integer[], compression integer) RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
	DECLARE
		compression2 int;
		options text[];
	BEGIN
		IF compression IS NOT NULL THEN
			IF compression > 9 THEN
				compression2 := 9;
			ELSEIF compression < 1 THEN
				compression2 := 1;
			ELSE
				compression2 := compression;
			END IF;

			options := array_append(options, 'ZLEVEL=' || compression2);
		END IF;

		RETURN st_aspng(st_band($1, $2), options);
	END;
	$_$;


--
-- Name: FUNCTION st_aspng(rast raster, nbands integer[], compression integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_aspng(rast raster, nbands integer[], compression integer) IS 'args: rast, nbands, compression - Return the raster tile selected bands as a single portable network graphics (PNG) image (byte array). If 1, 3, or 4 bands in raster and no bands are specified, then all bands are used. If more 2 or more than 4 bands and no bands specified, then only band 1 is used. Bands are mapped to RGB or RGBA space.';


--
-- Name: st_aspng(raster, integer, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_aspng(rast raster, nband integer, options text[] DEFAULT NULL::text[]) RETURNS bytea
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT st_aspng(st_band($1, $2), $3) $_$;


--
-- Name: FUNCTION st_aspng(rast raster, nband integer, options text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_aspng(rast raster, nband integer, options text[]) IS 'args: rast, nband, options=NULL - Return the raster tile selected bands as a single portable network graphics (PNG) image (byte array). If 1, 3, or 4 bands in raster and no bands are specified, then all bands are used. If more 2 or more than 4 bands and no bands specified, then only band 1 is used. Bands are mapped to RGB or RGBA space.';


--
-- Name: st_aspng(raster, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_aspng(rast raster, nband integer, compression integer) RETURNS bytea
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT st_aspng($1, ARRAY[$2], $3) $_$;


--
-- Name: FUNCTION st_aspng(rast raster, nband integer, compression integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_aspng(rast raster, nband integer, compression integer) IS 'args: rast, nband, compression - Return the raster tile selected bands as a single portable network graphics (PNG) image (byte array). If 1, 3, or 4 bands in raster and no bands are specified, then all bands are used. If more 2 or more than 4 bands and no bands specified, then only band 1 is used. Bands are mapped to RGB or RGBA space.';


--
-- Name: st_asraster(geometry, raster, text[], double precision[], double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asraster(geom geometry, ref raster, pixeltype text[] DEFAULT ARRAY['8BUI'::text], value double precision[] DEFAULT ARRAY[(1)::double precision], nodataval double precision[] DEFAULT ARRAY[(0)::double precision], touched boolean DEFAULT false) RETURNS raster
    LANGUAGE plpgsql STABLE
    AS $_$
	DECLARE
		g geometry;
		g_srid integer;

		ul_x double precision;
		ul_y double precision;
		scale_x double precision;
		scale_y double precision;
		skew_x double precision;
		skew_y double precision;
		sr_id integer;
	BEGIN
		SELECT upperleftx, upperlefty, scalex, scaley, skewx, skewy, srid INTO ul_x, ul_y, scale_x, scale_y, skew_x, skew_y, sr_id FROM ST_Metadata(ref);
		--RAISE NOTICE '%, %, %, %, %, %, %', ul_x, ul_y, scale_x, scale_y, skew_x, skew_y, sr_id;

		-- geometry and raster has different SRID
		g_srid := ST_SRID(geom);
		IF g_srid != sr_id THEN
			RAISE NOTICE 'The geometry''s SRID (%) is not the same as the raster''s SRID (%).  The geometry will be transformed to the raster''s projection', g_srid, sr_id;
			g := ST_Transform(geom, sr_id);
		ELSE
			g := geom;
		END IF;

		RETURN _st_asraster(g, scale_x, scale_y, NULL, NULL, $3, $4, $5, NULL, NULL, ul_x, ul_y, skew_x, skew_y, $6);
	END;
	$_$;


--
-- Name: FUNCTION st_asraster(geom geometry, ref raster, pixeltype text[], value double precision[], nodataval double precision[], touched boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asraster(geom geometry, ref raster, pixeltype text[], value double precision[], nodataval double precision[], touched boolean) IS 'args: geom, ref, pixeltype=ARRAY[''8BUI''], value=ARRAY[1], nodataval=ARRAY[0], touched=false - Converts a PostGIS geometry to a PostGIS raster.';


--
-- Name: st_asraster(geometry, raster, text, double precision, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asraster(geom geometry, ref raster, pixeltype text, value double precision DEFAULT 1, nodataval double precision DEFAULT 0, touched boolean DEFAULT false) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_asraster($1, $2, ARRAY[$3]::text[], ARRAY[$4]::double precision[], ARRAY[$5]::double precision[], $6) $_$;


--
-- Name: FUNCTION st_asraster(geom geometry, ref raster, pixeltype text, value double precision, nodataval double precision, touched boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asraster(geom geometry, ref raster, pixeltype text, value double precision, nodataval double precision, touched boolean) IS 'args: geom, ref, pixeltype, value=1, nodataval=0, touched=false - Converts a PostGIS geometry to a PostGIS raster.';


--
-- Name: st_asraster(geometry, double precision, double precision, double precision, double precision, text[], double precision[], double precision[], double precision, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, gridx double precision DEFAULT NULL::double precision, gridy double precision DEFAULT NULL::double precision, pixeltype text[] DEFAULT ARRAY['8BUI'::text], value double precision[] DEFAULT ARRAY[(1)::double precision], nodataval double precision[] DEFAULT ARRAY[(0)::double precision], skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, touched boolean DEFAULT false) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_asraster($1, $2, $3, NULL, NULL, $6, $7, $8, NULL, NULL, $4, $5, $9, $10, $11) $_$;


--
-- Name: FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, gridx double precision, gridy double precision, pixeltype text[], value double precision[], nodataval double precision[], skewx double precision, skewy double precision, touched boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, gridx double precision, gridy double precision, pixeltype text[], value double precision[], nodataval double precision[], skewx double precision, skewy double precision, touched boolean) IS 'args: geom, scalex, scaley, gridx=NULL, gridy=NULL, pixeltype=ARRAY[''8BUI''], value=ARRAY[1], nodataval=ARRAY[0], skewx=0, skewy=0, touched=false - Converts a PostGIS geometry to a PostGIS raster.';


--
-- Name: st_asraster(geometry, double precision, double precision, text[], double precision[], double precision[], double precision, double precision, double precision, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, pixeltype text[], value double precision[] DEFAULT ARRAY[(1)::double precision], nodataval double precision[] DEFAULT ARRAY[(0)::double precision], upperleftx double precision DEFAULT NULL::double precision, upperlefty double precision DEFAULT NULL::double precision, skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, touched boolean DEFAULT false) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_asraster($1, $2, $3, NULL, NULL, $4, $5, $6, $7, $8, NULL, NULL,	$9, $10, $11) $_$;


--
-- Name: FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, pixeltype text[], value double precision[], nodataval double precision[], upperleftx double precision, upperlefty double precision, skewx double precision, skewy double precision, touched boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, pixeltype text[], value double precision[], nodataval double precision[], upperleftx double precision, upperlefty double precision, skewx double precision, skewy double precision, touched boolean) IS 'args: geom, scalex, scaley, pixeltype, value=ARRAY[1], nodataval=ARRAY[0], upperleftx=NULL, upperlefty=NULL, skewx=0, skewy=0, touched=false - Converts a PostGIS geometry to a PostGIS raster.';


--
-- Name: st_asraster(geometry, integer, integer, double precision, double precision, text[], double precision[], double precision[], double precision, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asraster(geom geometry, width integer, height integer, gridx double precision DEFAULT NULL::double precision, gridy double precision DEFAULT NULL::double precision, pixeltype text[] DEFAULT ARRAY['8BUI'::text], value double precision[] DEFAULT ARRAY[(1)::double precision], nodataval double precision[] DEFAULT ARRAY[(0)::double precision], skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, touched boolean DEFAULT false) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_asraster($1, NULL, NULL, $2, $3, $6, $7, $8, NULL, NULL, $4, $5, $9, $10, $11) $_$;


--
-- Name: FUNCTION st_asraster(geom geometry, width integer, height integer, gridx double precision, gridy double precision, pixeltype text[], value double precision[], nodataval double precision[], skewx double precision, skewy double precision, touched boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asraster(geom geometry, width integer, height integer, gridx double precision, gridy double precision, pixeltype text[], value double precision[], nodataval double precision[], skewx double precision, skewy double precision, touched boolean) IS 'args: geom, width, height, gridx=NULL, gridy=NULL, pixeltype=ARRAY[''8BUI''], value=ARRAY[1], nodataval=ARRAY[0], skewx=0, skewy=0, touched=false - Converts a PostGIS geometry to a PostGIS raster.';


--
-- Name: st_asraster(geometry, integer, integer, text[], double precision[], double precision[], double precision, double precision, double precision, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asraster(geom geometry, width integer, height integer, pixeltype text[], value double precision[] DEFAULT ARRAY[(1)::double precision], nodataval double precision[] DEFAULT ARRAY[(0)::double precision], upperleftx double precision DEFAULT NULL::double precision, upperlefty double precision DEFAULT NULL::double precision, skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, touched boolean DEFAULT false) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_asraster($1, NULL, NULL, $2, $3, $4, $5, $6, $7, $8, NULL, NULL,	$9, $10, $11) $_$;


--
-- Name: FUNCTION st_asraster(geom geometry, width integer, height integer, pixeltype text[], value double precision[], nodataval double precision[], upperleftx double precision, upperlefty double precision, skewx double precision, skewy double precision, touched boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asraster(geom geometry, width integer, height integer, pixeltype text[], value double precision[], nodataval double precision[], upperleftx double precision, upperlefty double precision, skewx double precision, skewy double precision, touched boolean) IS 'args: geom, width, height, pixeltype, value=ARRAY[1], nodataval=ARRAY[0], upperleftx=NULL, upperlefty=NULL, skewx=0, skewy=0, touched=false - Converts a PostGIS geometry to a PostGIS raster.';


--
-- Name: st_asraster(geometry, double precision, double precision, double precision, double precision, text, double precision, double precision, double precision, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, gridx double precision, gridy double precision, pixeltype text, value double precision DEFAULT 1, nodataval double precision DEFAULT 0, skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, touched boolean DEFAULT false) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_asraster($1, $2, $3, NULL, NULL, ARRAY[$6]::text[], ARRAY[$7]::double precision[], ARRAY[$8]::double precision[], NULL, NULL, $4, $5, $9, $10, $11) $_$;


--
-- Name: FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, gridx double precision, gridy double precision, pixeltype text, value double precision, nodataval double precision, skewx double precision, skewy double precision, touched boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, gridx double precision, gridy double precision, pixeltype text, value double precision, nodataval double precision, skewx double precision, skewy double precision, touched boolean) IS 'args: geom, scalex, scaley, gridx, gridy, pixeltype, value=1, nodataval=0, skewx=0, skewy=0, touched=false - Converts a PostGIS geometry to a PostGIS raster.';


--
-- Name: st_asraster(geometry, double precision, double precision, text, double precision, double precision, double precision, double precision, double precision, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, pixeltype text, value double precision DEFAULT 1, nodataval double precision DEFAULT 0, upperleftx double precision DEFAULT NULL::double precision, upperlefty double precision DEFAULT NULL::double precision, skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, touched boolean DEFAULT false) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_asraster($1, $2, $3, NULL, NULL, ARRAY[$4]::text[], ARRAY[$5]::double precision[], ARRAY[$6]::double precision[], $7, $8, NULL, NULL, $9, $10, $11) $_$;


--
-- Name: FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, pixeltype text, value double precision, nodataval double precision, upperleftx double precision, upperlefty double precision, skewx double precision, skewy double precision, touched boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asraster(geom geometry, scalex double precision, scaley double precision, pixeltype text, value double precision, nodataval double precision, upperleftx double precision, upperlefty double precision, skewx double precision, skewy double precision, touched boolean) IS 'args: geom, scalex, scaley, pixeltype, value=1, nodataval=0, upperleftx=NULL, upperlefty=NULL, skewx=0, skewy=0, touched=false - Converts a PostGIS geometry to a PostGIS raster.';


--
-- Name: st_asraster(geometry, integer, integer, double precision, double precision, text, double precision, double precision, double precision, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asraster(geom geometry, width integer, height integer, gridx double precision, gridy double precision, pixeltype text, value double precision DEFAULT 1, nodataval double precision DEFAULT 0, skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, touched boolean DEFAULT false) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_asraster($1, NULL, NULL, $2, $3, ARRAY[$6]::text[], ARRAY[$7]::double precision[], ARRAY[$8]::double precision[], NULL, NULL, $4, $5, $9, $10, $11) $_$;


--
-- Name: FUNCTION st_asraster(geom geometry, width integer, height integer, gridx double precision, gridy double precision, pixeltype text, value double precision, nodataval double precision, skewx double precision, skewy double precision, touched boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asraster(geom geometry, width integer, height integer, gridx double precision, gridy double precision, pixeltype text, value double precision, nodataval double precision, skewx double precision, skewy double precision, touched boolean) IS 'args: geom, width, height, gridx, gridy, pixeltype, value=1, nodataval=0, skewx=0, skewy=0, touched=false - Converts a PostGIS geometry to a PostGIS raster.';


--
-- Name: st_asraster(geometry, integer, integer, text, double precision, double precision, double precision, double precision, double precision, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asraster(geom geometry, width integer, height integer, pixeltype text, value double precision DEFAULT 1, nodataval double precision DEFAULT 0, upperleftx double precision DEFAULT NULL::double precision, upperlefty double precision DEFAULT NULL::double precision, skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, touched boolean DEFAULT false) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_asraster($1, NULL, NULL, $2, $3, ARRAY[$4]::text[], ARRAY[$5]::double precision[], ARRAY[$6]::double precision[], $7, $8, NULL, NULL,$9, $10, $11) $_$;


--
-- Name: FUNCTION st_asraster(geom geometry, width integer, height integer, pixeltype text, value double precision, nodataval double precision, upperleftx double precision, upperlefty double precision, skewx double precision, skewy double precision, touched boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asraster(geom geometry, width integer, height integer, pixeltype text, value double precision, nodataval double precision, upperleftx double precision, upperlefty double precision, skewx double precision, skewy double precision, touched boolean) IS 'args: geom, width, height, pixeltype, value=1, nodataval=0, upperleftx=NULL, upperlefty=NULL, skewx=0, skewy=0, touched=false - Converts a PostGIS geometry to a PostGIS raster.';


--
-- Name: st_assvg(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_assvg(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsSVG($1::geometry,0,15);  $_$;


--
-- Name: st_assvg(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_assvg(geom geometry, rel integer DEFAULT 0, maxdecimaldigits integer DEFAULT 15) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asSVG';


--
-- Name: FUNCTION st_assvg(geom geometry, rel integer, maxdecimaldigits integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_assvg(geom geometry, rel integer, maxdecimaldigits integer) IS 'args: geom, rel=0, maxdecimaldigits=15 - Returns a Geometry in SVG path data given a geometry or geography object.';


--
-- Name: st_assvg(geography, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_assvg(geog geography, rel integer DEFAULT 0, maxdecimaldigits integer DEFAULT 15) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_as_svg';


--
-- Name: FUNCTION st_assvg(geog geography, rel integer, maxdecimaldigits integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_assvg(geog geography, rel integer, maxdecimaldigits integer) IS 'args: geog, rel=0, maxdecimaldigits=15 - Returns a Geometry in SVG path data given a geometry or geography object.';


--
-- Name: st_astext(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_astext(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asText';


--
-- Name: FUNCTION st_astext(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_astext(geometry) IS 'args: g1 - Return the Well-Known Text (WKT) representation of the geometry/geography without SRID metadata.';


--
-- Name: st_astext(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_astext(geography) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_asText';


--
-- Name: FUNCTION st_astext(geography); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_astext(geography) IS 'args: g1 - Return the Well-Known Text (WKT) representation of the geometry/geography without SRID metadata.';


--
-- Name: st_astext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_astext(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_AsText($1::geometry);  $_$;


--
-- Name: st_astiff(raster, text[], integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_astiff(rast raster, options text[] DEFAULT NULL::text[], srid integer DEFAULT NULL::integer) RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
	DECLARE
		i int;
		num_bands int;
		nodata double precision;
		last_nodata double precision;
	BEGIN
		num_bands := st_numbands($1);

		-- TIFF only allows one NODATA value for ALL bands
		FOR i IN 1..num_bands LOOP
			nodata := st_bandnodatavalue($1, i);
			IF last_nodata IS NULL THEN
				last_nodata := nodata;
			ELSEIF nodata != last_nodata THEN
				RAISE NOTICE 'The TIFF format only permits one NODATA value for all bands.  The value used will be the last band with a NODATA value.';
			END IF;
		END LOOP;

		RETURN st_asgdalraster($1, 'GTiff', $2, $3);
	END;
	$_$;


--
-- Name: FUNCTION st_astiff(rast raster, options text[], srid integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_astiff(rast raster, options text[], srid integer) IS 'args: rast, options='', srid=sameassource - Return the raster selected bands as a single TIFF image (byte array). If no band is specified, then will try to use all bands.';


--
-- Name: st_astiff(raster, text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_astiff(rast raster, compression text, srid integer DEFAULT NULL::integer) RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
	DECLARE
		compression2 text;
		c_type text;
		c_level int;
		i int;
		num_bands int;
		options text[];
	BEGIN
		compression2 := trim(both from upper(compression));

		IF length(compression2) > 0 THEN
			-- JPEG
			IF position('JPEG' in compression2) != 0 THEN
				c_type := 'JPEG';
				c_level := substring(compression2 from '[0-9]+$');

				IF c_level IS NOT NULL THEN
					IF c_level > 100 THEN
						c_level := 100;
					ELSEIF c_level < 1 THEN
						c_level := 1;
					END IF;

					options := array_append(options, 'JPEG_QUALITY=' || c_level);
				END IF;

				-- per band pixel type check
				num_bands := st_numbands($1);
				FOR i IN 1..num_bands LOOP
					IF st_bandpixeltype($1, i) != '8BUI' THEN
						RAISE EXCEPTION 'The pixel type of band % in the raster is not 8BUI.  JPEG compression can only be used with the 8BUI pixel type.', i;
					END IF;
				END LOOP;

			-- DEFLATE
			ELSEIF position('DEFLATE' in compression2) != 0 THEN
				c_type := 'DEFLATE';
				c_level := substring(compression2 from '[0-9]+$');

				IF c_level IS NOT NULL THEN
					IF c_level > 9 THEN
						c_level := 9;
					ELSEIF c_level < 1 THEN
						c_level := 1;
					END IF;

					options := array_append(options, 'ZLEVEL=' || c_level);
				END IF;

			ELSE
				c_type := compression2;

				-- CCITT
				IF position('CCITT' in compression2) THEN
					-- per band pixel type check
					num_bands := st_numbands($1);
					FOR i IN 1..num_bands LOOP
						IF st_bandpixeltype($1, i) != '1BB' THEN
							RAISE EXCEPTION 'The pixel type of band % in the raster is not 1BB.  CCITT compression can only be used with the 1BB pixel type.', i;
						END IF;
					END LOOP;
				END IF;

			END IF;

			-- compression type check
			IF ARRAY[c_type] <@ ARRAY['JPEG', 'LZW', 'PACKBITS', 'DEFLATE', 'CCITTRLE', 'CCITTFAX3', 'CCITTFAX4', 'NONE'] THEN
				options := array_append(options, 'COMPRESS=' || c_type);
			ELSE
				RAISE NOTICE 'Unknown compression type: %.  The outputted TIFF will not be COMPRESSED.', c_type;
			END IF;
		END IF;

		RETURN st_astiff($1, options, $3);
	END;
	$_$;


--
-- Name: FUNCTION st_astiff(rast raster, compression text, srid integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_astiff(rast raster, compression text, srid integer) IS 'args: rast, compression='', srid=sameassource - Return the raster selected bands as a single TIFF image (byte array). If no band is specified, then will try to use all bands.';


--
-- Name: st_astiff(raster, integer[], text[], integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_astiff(rast raster, nbands integer[], options text[] DEFAULT NULL::text[], srid integer DEFAULT NULL::integer) RETURNS bytea
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT st_astiff(st_band($1, $2), $3, $4) $_$;


--
-- Name: FUNCTION st_astiff(rast raster, nbands integer[], options text[], srid integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_astiff(rast raster, nbands integer[], options text[], srid integer) IS 'args: rast, nbands, options, srid=sameassource - Return the raster selected bands as a single TIFF image (byte array). If no band is specified, then will try to use all bands.';


--
-- Name: st_astiff(raster, integer[], text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_astiff(rast raster, nbands integer[], compression text, srid integer DEFAULT NULL::integer) RETURNS bytea
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT st_astiff(st_band($1, $2), $3, $4) $_$;


--
-- Name: FUNCTION st_astiff(rast raster, nbands integer[], compression text, srid integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_astiff(rast raster, nbands integer[], compression text, srid integer) IS 'args: rast, nbands, compression='', srid=sameassource - Return the raster selected bands as a single TIFF image (byte array). If no band is specified, then will try to use all bands.';


--
-- Name: st_asx3d(geometry, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_asx3d(geom geometry, maxdecimaldigits integer DEFAULT 15, options integer DEFAULT 0) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT _ST_AsX3D(3,$1,$2,$3,'');$_$;


--
-- Name: FUNCTION st_asx3d(geom geometry, maxdecimaldigits integer, options integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_asx3d(geom geometry, maxdecimaldigits integer, options integer) IS 'args: g1, maxdecimaldigits=15, options=0 - Returns a Geometry in X3D xml node element format: ISO-IEC-19776-1.2-X3DEncodings-XML';


--
-- Name: st_azimuth(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_azimuth(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_azimuth';


--
-- Name: FUNCTION st_azimuth(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_azimuth(geom1 geometry, geom2 geometry) IS 'args: pointA, pointB - Returns the angle in radians from the horizontal of the vector defined by pointA and pointB. Angle is computed clockwise from down-to-up: on the clock: 12=0; 3=PI/2; 6=PI; 9=3PI/2.';


--
-- Name: st_azimuth(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_azimuth(geog1 geography, geog2 geography) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'geography_azimuth';


--
-- Name: FUNCTION st_azimuth(geog1 geography, geog2 geography); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_azimuth(geog1 geography, geog2 geography) IS 'args: pointA, pointB - Returns the angle in radians from the horizontal of the vector defined by pointA and pointB. Angle is computed clockwise from down-to-up: on the clock: 12=0; 3=PI/2; 6=PI; 9=3PI/2.';


--
-- Name: st_band(raster, integer[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_band(rast raster, nbands integer[] DEFAULT ARRAY[1]) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_band';


--
-- Name: FUNCTION st_band(rast raster, nbands integer[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_band(rast raster, nbands integer[]) IS 'args: rast, nbands = ARRAY[1] - Returns one or more bands of an existing raster as a new raster. Useful for building new rasters from existing rasters.';


--
-- Name: st_band(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_band(rast raster, nband integer) RETURNS raster
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT st_band($1, ARRAY[$2]) $_$;


--
-- Name: FUNCTION st_band(rast raster, nband integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_band(rast raster, nband integer) IS 'args: rast, nband - Returns one or more bands of an existing raster as a new raster. Useful for building new rasters from existing rasters.';


--
-- Name: st_band(raster, text, character); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_band(rast raster, nbands text, delimiter character DEFAULT ','::bpchar) RETURNS raster
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT st_band($1, regexp_split_to_array(regexp_replace($2, '[[:space:]]', '', 'g'), $3)::int[]) $_$;


--
-- Name: FUNCTION st_band(rast raster, nbands text, delimiter character); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_band(rast raster, nbands text, delimiter character) IS 'args: rast, nbands, delimiter=, - Returns one or more bands of an existing raster as a new raster. Useful for building new rasters from existing rasters.';


--
-- Name: st_bandisnodata(raster, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bandisnodata(rast raster, forcechecking boolean) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT st_bandisnodata($1, 1, $2) $_$;


--
-- Name: FUNCTION st_bandisnodata(rast raster, forcechecking boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_bandisnodata(rast raster, forcechecking boolean) IS 'args: rast, forceChecking=true - Returns true if the band is filled with only nodata values.';


--
-- Name: st_bandisnodata(raster, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bandisnodata(rast raster, band integer DEFAULT 1, forcechecking boolean DEFAULT false) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_bandIsNoData';


--
-- Name: FUNCTION st_bandisnodata(rast raster, band integer, forcechecking boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_bandisnodata(rast raster, band integer, forcechecking boolean) IS 'args: rast, band, forceChecking=true - Returns true if the band is filled with only nodata values.';


--
-- Name: st_bandmetadata(raster, integer[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bandmetadata(rast raster, band integer[], OUT bandnum integer, OUT pixeltype text, OUT nodatavalue double precision, OUT isoutdb boolean, OUT path text) RETURNS record
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_bandmetadata';


--
-- Name: st_bandmetadata(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bandmetadata(rast raster, band integer DEFAULT 1, OUT pixeltype text, OUT nodatavalue double precision, OUT isoutdb boolean, OUT path text) RETURNS record
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT pixeltype, nodatavalue, isoutdb, path FROM st_bandmetadata($1, ARRAY[$2]::int[]) LIMIT 1 $_$;


--
-- Name: FUNCTION st_bandmetadata(rast raster, band integer, OUT pixeltype text, OUT nodatavalue double precision, OUT isoutdb boolean, OUT path text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_bandmetadata(rast raster, band integer, OUT pixeltype text, OUT nodatavalue double precision, OUT isoutdb boolean, OUT path text) IS 'args: rast, bandnum=1 - Returns basic meta data for a specific raster band. band num 1 is assumed if none-specified.';


--
-- Name: st_bandnodatavalue(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bandnodatavalue(rast raster, band integer DEFAULT 1) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getBandNoDataValue';


--
-- Name: FUNCTION st_bandnodatavalue(rast raster, band integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_bandnodatavalue(rast raster, band integer) IS 'args: rast, bandnum=1 - Returns the value in a given band that represents no data. If no band num 1 is assumed.';


--
-- Name: st_bandpath(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bandpath(rast raster, band integer DEFAULT 1) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getBandPath';


--
-- Name: FUNCTION st_bandpath(rast raster, band integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_bandpath(rast raster, band integer) IS 'args: rast, bandnum=1 - Returns system file path to a band stored in file system. If no bandnum specified, 1 is assumed.';


--
-- Name: st_bandpixeltype(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bandpixeltype(rast raster, band integer DEFAULT 1) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getBandPixelTypeName';


--
-- Name: FUNCTION st_bandpixeltype(rast raster, band integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_bandpixeltype(rast raster, band integer) IS 'args: rast, bandnum=1 - Returns the type of pixel for given band. If no bandnum specified, 1 is assumed.';


--
-- Name: st_bdmpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bdmpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := ST_MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := ST_Multi(ST_BuildArea(mline));

	RETURN geom;
END;
$_$;


--
-- Name: FUNCTION st_bdmpolyfromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_bdmpolyfromtext(text, integer) IS 'args: WKT, srid - Construct a MultiPolygon given an arbitrary collection of closed linestrings as a MultiLineString text representation Well-Known text representation.';


--
-- Name: st_bdpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_bdpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	geomtext alias for $1;
	srid alias for $2;
	mline geometry;
	geom geometry;
BEGIN
	mline := ST_MultiLineStringFromText(geomtext, srid);

	IF mline IS NULL
	THEN
		RAISE EXCEPTION 'Input is not a MultiLinestring';
	END IF;

	geom := ST_BuildArea(mline);

	IF GeometryType(geom) != 'POLYGON'
	THEN
		RAISE EXCEPTION 'Input returns more then a single polygon, try using BdMPolyFromText instead';
	END IF;

	RETURN geom;
END;
$_$;


--
-- Name: FUNCTION st_bdpolyfromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_bdpolyfromtext(text, integer) IS 'args: WKT, srid - Construct a Polygon given an arbitrary collection of closed linestrings as a MultiLineString Well-Known text representation.';


--
-- Name: st_boundary(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_boundary(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'boundary';


--
-- Name: FUNCTION st_boundary(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_boundary(geometry) IS 'args: geomA - Returns the closure of the combinatorial boundary of this Geometry.';


--
-- Name: st_buffer(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buffer(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'buffer';


--
-- Name: FUNCTION st_buffer(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_buffer(geometry, double precision) IS 'args: g1, radius_of_buffer - (T) For geometry: Returns a geometry that represents all points whose distance from this Geometry is less than or equal to distance. Calculations are in the Spatial Reference System of this Geometry. For geography: Uses a planar transform wrapper. Introduced in 1.5 support for different end cap and mitre settings to control shape. buffer_style options: quad_segs=#,endcap=round|flat|square,join=round|mitre|bevel,mitre_limit=#.#';


--
-- Name: st_buffer(geography, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buffer(geography, double precision) RETURNS geography
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT geography(ST_Transform(ST_Buffer(ST_Transform(geometry($1), _ST_BestSRID($1)), $2), 4326))$_$;


--
-- Name: FUNCTION st_buffer(geography, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_buffer(geography, double precision) IS 'args: g1, radius_of_buffer_in_meters - (T) For geometry: Returns a geometry that represents all points whose distance from this Geometry is less than or equal to distance. Calculations are in the Spatial Reference System of this Geometry. For geography: Uses a planar transform wrapper. Introduced in 1.5 support for different end cap and mitre settings to control shape. buffer_style options: quad_segs=#,endcap=round|flat|square,join=round|mitre|bevel,mitre_limit=#.#';


--
-- Name: st_buffer(text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buffer(text, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Buffer($1::geometry, $2);  $_$;


--
-- Name: st_buffer(geometry, double precision, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buffer(geometry, double precision, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_Buffer($1, $2,
		CAST('quad_segs='||CAST($3 AS text) as cstring))
	   $_$;


--
-- Name: FUNCTION st_buffer(geometry, double precision, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_buffer(geometry, double precision, integer) IS 'args: g1, radius_of_buffer, num_seg_quarter_circle - (T) For geometry: Returns a geometry that represents all points whose distance from this Geometry is less than or equal to distance. Calculations are in the Spatial Reference System of this Geometry. For geography: Uses a planar transform wrapper. Introduced in 1.5 support for different end cap and mitre settings to control shape. buffer_style options: quad_segs=#,endcap=round|flat|square,join=round|mitre|bevel,mitre_limit=#.#';


--
-- Name: st_buffer(geometry, double precision, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buffer(geometry, double precision, text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _ST_Buffer($1, $2,
		CAST( regexp_replace($3, '^[0123456789]+$',
			'quad_segs='||$3) AS cstring)
		)
	   $_$;


--
-- Name: FUNCTION st_buffer(geometry, double precision, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_buffer(geometry, double precision, text) IS 'args: g1, radius_of_buffer, buffer_style_parameters - (T) For geometry: Returns a geometry that represents all points whose distance from this Geometry is less than or equal to distance. Calculations are in the Spatial Reference System of this Geometry. For geography: Uses a planar transform wrapper. Introduced in 1.5 support for different end cap and mitre settings to control shape. buffer_style options: quad_segs=#,endcap=round|flat|square,join=round|mitre|bevel,mitre_limit=#.#';


--
-- Name: st_buildarea(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_buildarea(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_BuildArea';


--
-- Name: FUNCTION st_buildarea(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_buildarea(geometry) IS 'args: A - Creates an areal geometry formed by the constituent linework of given geometry';


--
-- Name: st_centroid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_centroid(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'centroid';


--
-- Name: FUNCTION st_centroid(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_centroid(geometry) IS 'args: g1 - Returns the geometric center of a geometry.';


--
-- Name: st_cleangeometry(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_cleangeometry(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_CleanGeometry';


--
-- Name: st_clip(raster, geometry, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_clip(rast raster, geom geometry, crop boolean) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT ST_Clip($1, NULL, $2, null::float8[], $3) $_$;


--
-- Name: FUNCTION st_clip(rast raster, geom geometry, crop boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_clip(rast raster, geom geometry, crop boolean) IS 'args: rast, geom, crop - Returns the raster clipped by the input geometry. If no band is specified all bands are returned. If crop is not specified, true is assumed meaning the output raster is cropped.';


--
-- Name: st_clip(raster, integer, geometry, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_clip(rast raster, band integer, geom geometry, crop boolean) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT ST_Clip($1, $2, $3, null::float8[], $4) $_$;


--
-- Name: FUNCTION st_clip(rast raster, band integer, geom geometry, crop boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_clip(rast raster, band integer, geom geometry, crop boolean) IS 'args: rast, band, geom, crop - Returns the raster clipped by the input geometry. If no band is specified all bands are returned. If crop is not specified, true is assumed meaning the output raster is cropped.';


--
-- Name: st_clip(raster, geometry, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_clip(rast raster, geom geometry, nodataval double precision[] DEFAULT NULL::double precision[], crop boolean DEFAULT true) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT ST_Clip($1, NULL, $2, $3, $4) $_$;


--
-- Name: FUNCTION st_clip(rast raster, geom geometry, nodataval double precision[], crop boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_clip(rast raster, geom geometry, nodataval double precision[], crop boolean) IS 'args: rast, geom, nodataval=NULL, crop=true - Returns the raster clipped by the input geometry. If no band is specified all bands are returned. If crop is not specified, true is assumed meaning the output raster is cropped.';


--
-- Name: st_clip(raster, geometry, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_clip(rast raster, geom geometry, nodataval double precision, crop boolean DEFAULT true) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT ST_Clip($1, NULL, $2, ARRAY[$3], $4) $_$;


--
-- Name: st_clip(raster, integer, geometry, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_clip(rast raster, band integer, geom geometry, nodataval double precision[] DEFAULT NULL::double precision[], crop boolean DEFAULT true) RETURNS raster
    LANGUAGE plpgsql STABLE
    AS $$
	DECLARE
		newrast raster;
		geomrast raster;
		numband int;
		bandstart int;
		bandend int;
		newextent text;
		newnodataval double precision;
		newpixtype text;
		bandi int;
	BEGIN
		IF rast IS NULL THEN
			RETURN NULL;
		END IF;
		IF geom IS NULL THEN
			RETURN rast;
		END IF;
		numband := ST_Numbands(rast);
		IF band IS NULL THEN
			bandstart := 1;
			bandend := numband;
		ELSEIF ST_HasNoBand(rast, band) THEN
			RAISE NOTICE 'Raster do not have band %. Returning null', band;
			RETURN NULL;
		ELSE
			bandstart := band;
			bandend := band;
		END IF;

		newpixtype := ST_BandPixelType(rast, bandstart);
		newnodataval := coalesce(nodataval[1], ST_BandNodataValue(rast, bandstart), ST_MinPossibleValue(newpixtype));
		newextent := CASE WHEN crop THEN 'INTERSECTION' ELSE 'FIRST' END;

		-- Convert the geometry to a raster
		geomrast := ST_AsRaster(geom, rast, ST_BandPixelType(rast, band), 1, newnodataval);

		-- Compute the first raster band
		newrast := ST_MapAlgebraExpr(rast, bandstart, geomrast, 1, '[rast1.val]', newpixtype, newextent, newnodataval::text, newnodataval::text, newnodataval);
		-- Set the newnodataval
		newrast := ST_SetBandNodataValue(newrast, bandstart, newnodataval);

		FOR bandi IN bandstart+1..bandend LOOP
			-- for each band we must determine the nodata value
			newpixtype := ST_BandPixelType(rast, bandi);
			newnodataval := coalesce(nodataval[bandi], nodataval[array_upper(nodataval, 1)], ST_BandNodataValue(rast, bandi), ST_MinPossibleValue(newpixtype));
			newrast := ST_AddBand(newrast, ST_MapAlgebraExpr(rast, bandi, geomrast, 1, '[rast1.val]', newpixtype, newextent, newnodataval::text, newnodataval::text, newnodataval));
			newrast := ST_SetBandNodataValue(newrast, bandi, newnodataval);
		END LOOP;

		RETURN newrast;
	END;
	$$;


--
-- Name: st_clip(raster, integer, geometry, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_clip(rast raster, band integer, geom geometry, nodataval double precision, crop boolean DEFAULT true) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT ST_Clip($1, $2, $3, ARRAY[$4], $5) $_$;


--
-- Name: st_closestpoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_closestpoint(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_closestpoint';


--
-- Name: FUNCTION st_closestpoint(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_closestpoint(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns the 2-dimensional point on g1 that is closest to g2. This is the first point of the shortest line.';


--
-- Name: st_collect(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_collect(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_collect_garray';


--
-- Name: FUNCTION st_collect(geometry[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_collect(geometry[]) IS 'args: g1_array - Return a specified ST_Geometry value from a collection of other geometries.';


--
-- Name: st_collect(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_collect(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'LWGEOM_collect';


--
-- Name: FUNCTION st_collect(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_collect(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Return a specified ST_Geometry value from a collection of other geometries.';


--
-- Name: st_collectionextract(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_collectionextract(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_CollectionExtract';


--
-- Name: FUNCTION st_collectionextract(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_collectionextract(geometry, integer) IS 'args: collection, type - Given a (multi)geometry, returns a (multi)geometry consisting only of elements of the specified type.';


--
-- Name: st_collectionhomogenize(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_collectionhomogenize(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_CollectionHomogenize';


--
-- Name: FUNCTION st_collectionhomogenize(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_collectionhomogenize(geometry) IS 'args: collection - Given a geometry collection, returns the "simplest" representation of the contents.';


--
-- Name: st_combine_bbox(box2d, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_combine_bbox(box2d, geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'BOX2D_combine';


--
-- Name: st_combine_bbox(box3d, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_combine_bbox(box3d, geometry) RETURNS box3d
    LANGUAGE c IMMUTABLE
    AS '$libdir/postgis-2.0', 'BOX3D_combine';


--
-- Name: st_concavehull(geometry, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_concavehull(param_geom geometry, param_pctconvex double precision, param_allow_holes boolean DEFAULT false) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
	DECLARE
		var_convhull geometry := ST_ConvexHull(param_geom);
		var_param_geom geometry := param_geom;
		var_initarea float := ST_Area(var_convhull);
		var_newarea float := var_initarea;
		var_div integer := 6; 
		var_tempgeom geometry;
		var_tempgeom2 geometry;
		var_cent geometry;
		var_geoms geometry[4]; 
		var_enline geometry;
		var_resultgeom geometry;
		var_atempgeoms geometry[];
		var_buf float := 1; 
	BEGIN
		-- We start with convex hull as our base
		var_resultgeom := var_convhull;
		
		IF param_pctconvex = 1 THEN
			return var_resultgeom;
		ELSIF ST_GeometryType(var_param_geom) = 'ST_Polygon' THEN -- it is as concave as it is going to get
			IF param_allow_holes THEN -- leave the holes
				RETURN var_param_geom;
			ELSE -- remove the holes
				var_resultgeom := ST_MakePolygon(ST_ExteriorRing(var_param_geom));
				RETURN var_resultgeom;
			END IF;
		END IF;
		IF ST_Dimension(var_resultgeom) > 1 AND param_pctconvex BETWEEN 0 and 0.98 THEN
		-- get linestring that forms envelope of geometry
			var_enline := ST_Boundary(ST_Envelope(var_param_geom));
			var_buf := ST_Length(var_enline)/1000.0;
			IF ST_GeometryType(var_param_geom) = 'ST_MultiPoint' AND ST_NumGeometries(var_param_geom) BETWEEN 4 and 200 THEN
			-- we make polygons out of points since they are easier to cave in. 
			-- Note we limit to between 4 and 200 points because this process is slow and gets quadratically slow
				var_buf := sqrt(ST_Area(var_convhull)*0.8/(ST_NumGeometries(var_param_geom)*ST_NumGeometries(var_param_geom)));
				var_atempgeoms := ARRAY(SELECT geom FROM ST_DumpPoints(var_param_geom));
				-- 5 and 10 and just fudge factors
				var_tempgeom := ST_Union(ARRAY(SELECT geom
						FROM (
						-- fuse near neighbors together
						SELECT DISTINCT ON (i) i,  ST_Distance(var_atempgeoms[i],var_atempgeoms[j]), ST_Buffer(ST_MakeLine(var_atempgeoms[i], var_atempgeoms[j]) , var_buf*5, 'quad_segs=3') As geom
								FROM generate_series(1,array_upper(var_atempgeoms, 1)) As i
									INNER JOIN generate_series(1,array_upper(var_atempgeoms, 1)) As j 
										ON (
								 NOT ST_Intersects(var_atempgeoms[i],var_atempgeoms[j])
									AND ST_DWithin(var_atempgeoms[i],var_atempgeoms[j], var_buf*10)
									)
								UNION ALL
						-- catch the ones with no near neighbors
								SELECT i, 0, ST_Buffer(var_atempgeoms[i] , var_buf*10, 'quad_segs=3') As geom
								FROM generate_series(1,array_upper(var_atempgeoms, 1)) As i
									LEFT JOIN generate_series(ceiling(array_upper(var_atempgeoms,1)/2)::integer,array_upper(var_atempgeoms, 1)) As j 
										ON (
								 NOT ST_Intersects(var_atempgeoms[i],var_atempgeoms[j])
									AND ST_DWithin(var_atempgeoms[i],var_atempgeoms[j], var_buf*10) 
									)
									WHERE j IS NULL
								ORDER BY 1, 2
							) As foo	) );
				IF ST_IsValid(var_tempgeom) AND ST_GeometryType(var_tempgeom) = 'ST_Polygon' THEN
					var_tempgeom := ST_Intersection(var_tempgeom, var_convhull);
					IF param_allow_holes THEN
						var_param_geom := var_tempgeom;
					ELSE
						var_param_geom := ST_MakePolygon(ST_ExteriorRing(var_tempgeom));
					END IF;
					return var_param_geom;
				ELSIF ST_IsValid(var_tempgeom) THEN
					var_param_geom := ST_Intersection(var_tempgeom, var_convhull);	
				END IF;
			END IF;

			IF ST_GeometryType(var_param_geom) = 'ST_Polygon' THEN
				IF NOT param_allow_holes THEN
					var_param_geom := ST_MakePolygon(ST_ExteriorRing(var_param_geom));
				END IF;
				return var_param_geom;
			END IF;
            var_cent := ST_Centroid(var_param_geom);
            IF (ST_XMax(var_enline) - ST_XMin(var_enline) ) > var_buf AND (ST_YMax(var_enline) - ST_YMin(var_enline) ) > var_buf THEN
                    IF ST_Dwithin(ST_Centroid(var_convhull) , ST_Centroid(ST_Envelope(var_param_geom)), var_buf/2) THEN
                -- If the geometric dimension is > 1 and the object is symettric (cutting at centroid will not work -- offset a bit)
                        var_cent := ST_Translate(var_cent, (ST_XMax(var_enline) - ST_XMin(var_enline))/1000,  (ST_YMAX(var_enline) - ST_YMin(var_enline))/1000);
                    ELSE
                        -- uses closest point on geometry to centroid. I can't explain why we are doing this
                        var_cent := ST_ClosestPoint(var_param_geom,var_cent);
                    END IF;
                    IF ST_DWithin(var_cent, var_enline,var_buf) THEN
                        var_cent := ST_centroid(ST_Envelope(var_param_geom));
                    END IF;
                    -- break envelope into 4 triangles about the centroid of the geometry and returned the clipped geometry in each quadrant
                    FOR i in 1 .. 4 LOOP
                       var_geoms[i] := ST_MakePolygon(ST_MakeLine(ARRAY[ST_PointN(var_enline,i), ST_PointN(var_enline,i+1), var_cent, ST_PointN(var_enline,i)]));
                       var_geoms[i] := ST_Intersection(var_param_geom, ST_Buffer(var_geoms[i],var_buf));
                       IF ST_IsValid(var_geoms[i]) THEN 
                            
                       ELSE
                            var_geoms[i] := ST_BuildArea(ST_MakeLine(ARRAY[ST_PointN(var_enline,i), ST_PointN(var_enline,i+1), var_cent, ST_PointN(var_enline,i)]));
                       END IF; 
                    END LOOP;
                    var_tempgeom := ST_Union(ARRAY[ST_ConvexHull(var_geoms[1]), ST_ConvexHull(var_geoms[2]) , ST_ConvexHull(var_geoms[3]), ST_ConvexHull(var_geoms[4])]); 
                    --RAISE NOTICE 'Curr vex % ', ST_AsText(var_tempgeom);
                    IF ST_Area(var_tempgeom) <= var_newarea AND ST_IsValid(var_tempgeom)  THEN --AND ST_GeometryType(var_tempgeom) ILIKE '%Polygon'
                        
                        var_tempgeom := ST_Buffer(ST_ConcaveHull(var_geoms[1],least(param_pctconvex + param_pctconvex/var_div),true),var_buf, 'quad_segs=2');
                        FOR i IN 1 .. 4 LOOP
                            var_geoms[i] := ST_Buffer(ST_ConcaveHull(var_geoms[i],least(param_pctconvex + param_pctconvex/var_div),true), var_buf, 'quad_segs=2');
                            IF ST_IsValid(var_geoms[i]) Then
                                var_tempgeom := ST_Union(var_tempgeom, var_geoms[i]);
                            ELSE
                                RAISE NOTICE 'Not valid % %', i, ST_AsText(var_tempgeom);
                                var_tempgeom := ST_Union(var_tempgeom, ST_ConvexHull(var_geoms[i]));
                            END IF; 
                        END LOOP;

                        --RAISE NOTICE 'Curr concave % ', ST_AsText(var_tempgeom);
                        IF ST_IsValid(var_tempgeom) THEN
                            var_resultgeom := var_tempgeom;
                        END IF;
                        var_newarea := ST_Area(var_resultgeom);
                    ELSIF ST_IsValid(var_tempgeom) THEN
                        var_resultgeom := var_tempgeom;
                    END IF;

                    IF ST_NumGeometries(var_resultgeom) > 1  THEN
                        var_tempgeom := _ST_ConcaveHull(var_resultgeom);
                        IF ST_IsValid(var_tempgeom) AND ST_GeometryType(var_tempgeom) ILIKE 'ST_Polygon' THEN
                            var_resultgeom := var_tempgeom;
                        ELSE
                            var_resultgeom := ST_Buffer(var_tempgeom,var_buf, 'quad_segs=2');
                        END IF;
                    END IF;
                    IF param_allow_holes = false THEN 
                    -- only keep exterior ring since we do not want holes
                        var_resultgeom := ST_MakePolygon(ST_ExteriorRing(var_resultgeom));
                    END IF;
                ELSE
                    var_resultgeom := ST_Buffer(var_resultgeom,var_buf);
                END IF;
                var_resultgeom := ST_Intersection(var_resultgeom, ST_ConvexHull(var_param_geom));
            ELSE
                -- dimensions are too small to cut
                var_resultgeom := _ST_ConcaveHull(var_param_geom);
            END IF;
            RETURN var_resultgeom;
	END;
$$;


--
-- Name: FUNCTION st_concavehull(param_geom geometry, param_pctconvex double precision, param_allow_holes boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_concavehull(param_geom geometry, param_pctconvex double precision, param_allow_holes boolean) IS 'args: geomA, target_percent, allow_holes=false - The concave hull of a geometry represents a possibly concave geometry that encloses all geometries within the set. You can think of it as shrink wrapping.';


--
-- Name: st_contains(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_contains(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Contains($1,$2)$_$;


--
-- Name: FUNCTION st_contains(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_contains(geom1 geometry, geom2 geometry) IS 'args: geomA, geomB - Returns true if and only if no points of B lie in the exterior of A, and at least one point of the interior of B lies in the interior of A.';


--
-- Name: st_containsproperly(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_containsproperly(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_ContainsProperly($1,$2)$_$;


--
-- Name: FUNCTION st_containsproperly(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_containsproperly(geom1 geometry, geom2 geometry) IS 'args: geomA, geomB - Returns true if B intersects the interior of A but not the boundary (or exterior). A does not contain properly itself, but does contain itself.';


--
-- Name: st_convexhull(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_convexhull(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'convexhull';


--
-- Name: FUNCTION st_convexhull(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_convexhull(geometry) IS 'args: geomA - The convex hull of a geometry represents the minimum convex geometry that encloses all geometries within the set.';


--
-- Name: st_convexhull(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_convexhull(raster) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_convex_hull';


--
-- Name: FUNCTION st_convexhull(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_convexhull(raster) IS 'args: rast - Return the convex hull geometry of the raster including pixel values equal to BandNoDataValue. For regular shaped and non-skewed rasters, this gives the same result as ST_Envelope so only useful for irregularly shaped or skewed rasters.';


--
-- Name: st_coorddim(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_coorddim(geometry geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_ndims';


--
-- Name: FUNCTION st_coorddim(geometry geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_coorddim(geometry geometry) IS 'args: geomA - Return the coordinate dimension of the ST_Geometry value.';


--
-- Name: st_count(raster, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_count(rast raster, exclude_nodata_value boolean) RETURNS bigint
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_count($1, 1, $2, 1) $_$;


--
-- Name: FUNCTION st_count(rast raster, exclude_nodata_value boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_count(rast raster, exclude_nodata_value boolean) IS 'args: rast, exclude_nodata_value - Returns the number of pixels in a given band of a raster or raster coverage. If no band is specified defaults to band 1. If exclude_nodata_value is set to true, will only count pixels that are not equal to the nodata value.';


--
-- Name: st_count(raster, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_count(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true) RETURNS bigint
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_count($1, $2, $3, 1) $_$;


--
-- Name: FUNCTION st_count(rast raster, nband integer, exclude_nodata_value boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_count(rast raster, nband integer, exclude_nodata_value boolean) IS 'args: rast, nband=1, exclude_nodata_value=true - Returns the number of pixels in a given band of a raster or raster coverage. If no band is specified defaults to band 1. If exclude_nodata_value is set to true, will only count pixels that are not equal to the nodata value.';


--
-- Name: st_count(text, text, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_count(rastertable text, rastercolumn text, exclude_nodata_value boolean) RETURNS bigint
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_count($1, $2, 1, $3, 1) $_$;


--
-- Name: FUNCTION st_count(rastertable text, rastercolumn text, exclude_nodata_value boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_count(rastertable text, rastercolumn text, exclude_nodata_value boolean) IS 'args: rastertable, rastercolumn, exclude_nodata_value - Returns the number of pixels in a given band of a raster or raster coverage. If no band is specified defaults to band 1. If exclude_nodata_value is set to true, will only count pixels that are not equal to the nodata value.';


--
-- Name: st_count(text, text, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_count(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true) RETURNS bigint
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_count($1, $2, $3, $4, 1) $_$;


--
-- Name: FUNCTION st_count(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_count(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean) IS 'args: rastertable, rastercolumn, nband=1, exclude_nodata_value=true - Returns the number of pixels in a given band of a raster or raster coverage. If no band is specified defaults to band 1. If exclude_nodata_value is set to true, will only count pixels that are not equal to the nodata value.';


--
-- Name: st_coveredby(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_coveredby(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_CoveredBy($1,$2)$_$;


--
-- Name: FUNCTION st_coveredby(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_coveredby(geom1 geometry, geom2 geometry) IS 'args: geomA, geomB - Returns 1 (TRUE) if no point in Geometry/Geography A is outside Geometry/Geography B';


--
-- Name: st_coveredby(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_coveredby(geography, geography) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Covers($2, $1)$_$;


--
-- Name: FUNCTION st_coveredby(geography, geography); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_coveredby(geography, geography) IS 'args: geogA, geogB - Returns 1 (TRUE) if no point in Geometry/Geography A is outside Geometry/Geography B';


--
-- Name: st_coveredby(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_coveredby(text, text) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_CoveredBy($1::geometry, $2::geometry);  $_$;


--
-- Name: st_covers(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_covers(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Covers($1,$2)$_$;


--
-- Name: FUNCTION st_covers(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_covers(geom1 geometry, geom2 geometry) IS 'args: geomA, geomB - Returns 1 (TRUE) if no point in Geometry B is outside Geometry A';


--
-- Name: st_covers(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_covers(geography, geography) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Covers($1, $2)$_$;


--
-- Name: FUNCTION st_covers(geography, geography); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_covers(geography, geography) IS 'args: geogpolyA, geogpointB - Returns 1 (TRUE) if no point in Geometry B is outside Geometry A';


--
-- Name: st_covers(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_covers(text, text) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_Covers($1::geometry, $2::geometry);  $_$;


--
-- Name: st_crosses(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_crosses(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Crosses($1,$2)$_$;


--
-- Name: FUNCTION st_crosses(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_crosses(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns TRUE if the supplied geometries have some, but not all, interior points in common.';


--
-- Name: st_curvetoline(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_curvetoline(geometry) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_CurveToLine($1, 32)$_$;


--
-- Name: FUNCTION st_curvetoline(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_curvetoline(geometry) IS 'args: curveGeom - Converts a CIRCULARSTRING/CURVEDPOLYGON to a LINESTRING/POLYGON';


--
-- Name: st_curvetoline(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_curvetoline(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_curve_segmentize';


--
-- Name: FUNCTION st_curvetoline(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_curvetoline(geometry, integer) IS 'args: curveGeom, segments_per_qtr_circle - Converts a CIRCULARSTRING/CURVEDPOLYGON to a LINESTRING/POLYGON';


--
-- Name: st_dfullywithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dfullywithin(geom1 geometry, geom2 geometry, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && ST_Expand($2,$3) AND $2 && ST_Expand($1,$3) AND _ST_DFullyWithin(ST_ConvexHull($1), ST_ConvexHull($2), $3)$_$;


--
-- Name: FUNCTION st_dfullywithin(geom1 geometry, geom2 geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_dfullywithin(geom1 geometry, geom2 geometry, double precision) IS 'args: g1, g2, distance - Returns true if all of the geometries are within the specified distance of one another';


--
-- Name: st_difference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_difference(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'difference';


--
-- Name: FUNCTION st_difference(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_difference(geom1 geometry, geom2 geometry) IS 'args: geomA, geomB - Returns a geometry that represents that part of geometry A that does not intersect with geometry B.';


--
-- Name: st_dimension(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dimension(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_dimension';


--
-- Name: FUNCTION st_dimension(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_dimension(geometry) IS 'args: g - The inherent dimension of this Geometry object, which must be less than or equal to the coordinate dimension.';


--
-- Name: st_disjoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_disjoint(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'disjoint';


--
-- Name: FUNCTION st_disjoint(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_disjoint(geom1 geometry, geom2 geometry) IS 'args: A, B - Returns TRUE if the Geometries do not "spatially intersect" - if they do not share any space together.';


--
-- Name: st_distance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_mindistance2d';


--
-- Name: FUNCTION st_distance(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_distance(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - For geometry type Returns the 2-dimensional cartesian minimum distance (based on spatial ref) between two geometries in projected units. For geography type defaults to return spheroidal minimum distance between two geographies in meters.';


--
-- Name: st_distance(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance(geography, geography) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_Distance($1, $2, 0.0, true)$_$;


--
-- Name: FUNCTION st_distance(geography, geography); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_distance(geography, geography) IS 'args: gg1, gg2 - For geometry type Returns the 2-dimensional cartesian minimum distance (based on spatial ref) between two geometries in projected units. For geography type defaults to return spheroidal minimum distance between two geographies in meters.';


--
-- Name: st_distance(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance(text, text) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Distance($1::geometry, $2::geometry);  $_$;


--
-- Name: st_distance(geography, geography, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance(geography, geography, boolean) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_Distance($1, $2, 0.0, $3)$_$;


--
-- Name: FUNCTION st_distance(geography, geography, boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_distance(geography, geography, boolean) IS 'args: gg1, gg2, use_spheroid - For geometry type Returns the 2-dimensional cartesian minimum distance (based on spatial ref) between two geometries in projected units. For geography type defaults to return spheroidal minimum distance between two geographies in meters.';


--
-- Name: st_distance_sphere(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance_sphere(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT COST 300
    AS $_$
	select st_distance(geography($1),geography($2),false)
	$_$;


--
-- Name: FUNCTION st_distance_sphere(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_distance_sphere(geom1 geometry, geom2 geometry) IS 'args: geomlonlatA, geomlonlatB - Returns minimum distance in meters between two lon/lat geometries. Uses a spherical earth and radius of 6370986 meters. Faster than ST_Distance_Spheroid , but less accurate. PostGIS versions prior to 1.5 only implemented for points.';


--
-- Name: st_distance_spheroid(geometry, geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distance_spheroid(geom1 geometry, geom2 geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_distance_ellipsoid';


--
-- Name: FUNCTION st_distance_spheroid(geom1 geometry, geom2 geometry, spheroid); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_distance_spheroid(geom1 geometry, geom2 geometry, spheroid) IS 'args: geomlonlatA, geomlonlatB, measurement_spheroid - Returns the minimum distance between two lon/lat geometries given a particular spheroid. PostGIS versions prior to 1.5 only support points.';


--
-- Name: st_distinct4ma(double precision[], text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_distinct4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT COUNT(DISTINCT unnest)::float FROM unnest($1) $_$;


--
-- Name: FUNCTION st_distinct4ma(matrix double precision[], nodatamode text, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_distinct4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) IS 'args: matrix, nodatamode, VARIADIC args - Raster processing function that calculates the number of unique pixel values in a neighborhood.';


--
-- Name: st_dump(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dump(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_dump';


--
-- Name: FUNCTION st_dump(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_dump(geometry) IS 'args: g1 - Returns a set of geometry_dump (geom,path) rows, that make up a geometry g1.';


--
-- Name: st_dumpaspolygons(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dumpaspolygons(rast raster, band integer DEFAULT 1) RETURNS SETOF geomval
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_dumpAsPolygons';


--
-- Name: FUNCTION st_dumpaspolygons(rast raster, band integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_dumpaspolygons(rast raster, band integer) IS 'args: rast, band_num=1 - Returns a set of geomval (geom,val) rows, from a given raster band. If no band number is specified, band num defaults to 1.';


--
-- Name: st_dumppoints(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dumppoints(geometry) RETURNS SETOF geometry_dump
    LANGUAGE sql STRICT
    AS $_$
  SELECT * FROM _ST_DumpPoints($1, NULL);
$_$;


--
-- Name: FUNCTION st_dumppoints(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_dumppoints(geometry) IS 'args: geom - Returns a set of geometry_dump (geom,path) rows of all points that make up a geometry.';


--
-- Name: st_dumprings(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dumprings(geometry) RETURNS SETOF geometry_dump
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_dump_rings';


--
-- Name: FUNCTION st_dumprings(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_dumprings(geometry) IS 'args: a_polygon - Returns a set of geometry_dump rows, representing the exterior and interior rings of a polygon.';


--
-- Name: st_dwithin(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dwithin(geom1 geometry, geom2 geometry, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && ST_Expand($2,$3) AND $2 && ST_Expand($1,$3) AND _ST_DWithin($1, $2, $3)$_$;


--
-- Name: FUNCTION st_dwithin(geom1 geometry, geom2 geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_dwithin(geom1 geometry, geom2 geometry, double precision) IS 'args: g1, g2, distance_of_srid - Returns true if the geometries are within the specified distance of one another. For geometry units are in those of spatial reference and For geography units are in meters and measurement is defaulted to use_spheroid=true (measure around spheroid), for faster check, use_spheroid=false to measure along sphere.';


--
-- Name: st_dwithin(geography, geography, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dwithin(geography, geography, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && _ST_Expand($2,$3) AND $2 && _ST_Expand($1,$3) AND _ST_DWithin($1, $2, $3, true)$_$;


--
-- Name: FUNCTION st_dwithin(geography, geography, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_dwithin(geography, geography, double precision) IS 'args: gg1, gg2, distance_meters - Returns true if the geometries are within the specified distance of one another. For geometry units are in those of spatial reference and For geography units are in meters and measurement is defaulted to use_spheroid=true (measure around spheroid), for faster check, use_spheroid=false to measure along sphere.';


--
-- Name: st_dwithin(text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dwithin(text, text, double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_DWithin($1::geometry, $2::geometry, $3);  $_$;


--
-- Name: st_dwithin(geography, geography, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_dwithin(geography, geography, double precision, boolean) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && _ST_Expand($2,$3) AND $2 && _ST_Expand($1,$3) AND _ST_DWithin($1, $2, $3, $4)$_$;


--
-- Name: FUNCTION st_dwithin(geography, geography, double precision, boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_dwithin(geography, geography, double precision, boolean) IS 'args: gg1, gg2, distance_meters, use_spheroid - Returns true if the geometries are within the specified distance of one another. For geometry units are in those of spatial reference and For geography units are in meters and measurement is defaulted to use_spheroid=true (measure around spheroid), for faster check, use_spheroid=false to measure along sphere.';


--
-- Name: st_endpoint(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_endpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_endpoint_linestring';


--
-- Name: FUNCTION st_endpoint(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_endpoint(geometry) IS 'args: g - Returns the last point of a LINESTRING geometry as a POINT.';


--
-- Name: st_envelope(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_envelope(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_envelope';


--
-- Name: FUNCTION st_envelope(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_envelope(geometry) IS 'args: g1 - Returns a geometry representing the double precision (float8) bounding box of the supplied geometry.';


--
-- Name: st_envelope(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_envelope(raster) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select st_envelope(st_convexhull($1))$_$;


--
-- Name: FUNCTION st_envelope(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_envelope(raster) IS 'args: rast - Returns the polygon representation of the extent of the raster.';


--
-- Name: st_equals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_equals(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 ~= $2 AND _ST_Equals($1,$2)$_$;


--
-- Name: FUNCTION st_equals(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_equals(geom1 geometry, geom2 geometry) IS 'args: A, B - Returns true if the given geometries represent the same geometry. Directionality is ignored.';


--
-- Name: st_estimated_extent(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_estimated_extent(text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-2.0', 'geometry_estimated_extent';


--
-- Name: FUNCTION st_estimated_extent(text, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_estimated_extent(text, text) IS 'args: table_name, geocolumn_name - Return the estimated extent of the given spatial table. The estimated is taken from the geometry columns statistics. The current schema will be used if not specified.';


--
-- Name: st_estimated_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_estimated_extent(text, text, text) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT SECURITY DEFINER
    AS '$libdir/postgis-2.0', 'geometry_estimated_extent';


--
-- Name: FUNCTION st_estimated_extent(text, text, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_estimated_extent(text, text, text) IS 'args: schema_name, table_name, geocolumn_name - Return the estimated extent of the given spatial table. The estimated is taken from the geometry columns statistics. The current schema will be used if not specified.';


--
-- Name: st_expand(box2d, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_expand(box2d, double precision) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX2D_expand';


--
-- Name: FUNCTION st_expand(box2d, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_expand(box2d, double precision) IS 'args: g1, units_to_expand - Returns bounding box expanded in all directions from the bounding box of the input geometry. Uses double-precision';


--
-- Name: st_expand(box3d, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_expand(box3d, double precision) RETURNS box3d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_expand';


--
-- Name: FUNCTION st_expand(box3d, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_expand(box3d, double precision) IS 'args: g1, units_to_expand - Returns bounding box expanded in all directions from the bounding box of the input geometry. Uses double-precision';


--
-- Name: st_expand(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_expand(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_expand';


--
-- Name: FUNCTION st_expand(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_expand(geometry, double precision) IS 'args: g1, units_to_expand - Returns bounding box expanded in all directions from the bounding box of the input geometry. Uses double-precision';


--
-- Name: st_exteriorring(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_exteriorring(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_exteriorring_polygon';


--
-- Name: FUNCTION st_exteriorring(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_exteriorring(geometry) IS 'args: a_polygon - Returns a line string representing the exterior ring of the POLYGON geometry. Return NULL if the geometry is not a polygon. Will not work with MULTIPOLYGON';


--
-- Name: st_find_extent(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_find_extent(text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	tablename alias for $1;
	columnname alias for $2;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT ST_Extent("' || columnname || '") As extent FROM "' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


--
-- Name: st_find_extent(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_find_extent(text, text, text) RETURNS box2d
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
DECLARE
	schemaname alias for $1;
	tablename alias for $2;
	columnname alias for $3;
	myrec RECORD;

BEGIN
	FOR myrec IN EXECUTE 'SELECT ST_Extent("' || columnname || '") As extent FROM "' || schemaname || '"."' || tablename || '"' LOOP
		return myrec.extent;
	END LOOP;
END;
$_$;


--
-- Name: st_flipcoordinates(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_flipcoordinates(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_FlipCoordinates';


--
-- Name: FUNCTION st_flipcoordinates(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_flipcoordinates(geometry) IS 'args: geom - Returns a version of the given geometry with X and Y axis flipped. Useful for people who have built latitude/longitude features and need to fix them.';


--
-- Name: st_force_2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_2d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_force_2d';


--
-- Name: FUNCTION st_force_2d(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_force_2d(geometry) IS 'args: geomA - Forces the geometries into a "2-dimensional mode" so that all output representations will only have the X and Y coordinates.';


--
-- Name: st_force_3d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_3d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_force_3dz';


--
-- Name: FUNCTION st_force_3d(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_force_3d(geometry) IS 'args: geomA - Forces the geometries into XYZ mode. This is an alias for ST_Force_3DZ.';


--
-- Name: st_force_3dm(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_3dm(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_force_3dm';


--
-- Name: FUNCTION st_force_3dm(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_force_3dm(geometry) IS 'args: geomA - Forces the geometries into XYM mode.';


--
-- Name: st_force_3dz(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_3dz(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_force_3dz';


--
-- Name: FUNCTION st_force_3dz(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_force_3dz(geometry) IS 'args: geomA - Forces the geometries into XYZ mode. This is a synonym for ST_Force_3D.';


--
-- Name: st_force_4d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_4d(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_force_4d';


--
-- Name: FUNCTION st_force_4d(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_force_4d(geometry) IS 'args: geomA - Forces the geometries into XYZM mode.';


--
-- Name: st_force_collection(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_force_collection(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_force_collection';


--
-- Name: FUNCTION st_force_collection(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_force_collection(geometry) IS 'args: geomA - Converts the geometry into a GEOMETRYCOLLECTION.';


--
-- Name: st_forcerhr(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_forcerhr(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_force_clockwise_poly';


--
-- Name: FUNCTION st_forcerhr(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_forcerhr(geometry) IS 'args: g - Forces the orientation of the vertices in a polygon to follow the Right-Hand-Rule.';


--
-- Name: st_gdaldrivers(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_gdaldrivers(OUT idx integer, OUT short_name text, OUT long_name text, OUT create_options text) RETURNS SETOF record
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getGDALDrivers';


--
-- Name: FUNCTION st_gdaldrivers(OUT idx integer, OUT short_name text, OUT long_name text, OUT create_options text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_gdaldrivers(OUT idx integer, OUT short_name text, OUT long_name text, OUT create_options text) IS 'args: OUT idx, OUT short_name, OUT long_name, OUT create_options - Returns a list of raster formats supported by your lib gdal. These are the formats you can output your raster using ST_AsGDALRaster.';


--
-- Name: st_geogfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geogfromtext(text) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_from_text';


--
-- Name: FUNCTION st_geogfromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geogfromtext(text) IS 'args: EWKT - Return a specified geography value from Well-Known Text representation or extended (WKT).';


--
-- Name: st_geogfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geogfromwkb(bytea) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_from_binary';


--
-- Name: FUNCTION st_geogfromwkb(bytea); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geogfromwkb(bytea) IS 'args: geom - Creates a geography instance from a Well-Known Binary geometry representation (WKB) or extended Well Known Binary (EWKB).';


--
-- Name: st_geographyfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geographyfromtext(text) RETURNS geography
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geography_from_text';


--
-- Name: FUNCTION st_geographyfromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geographyfromtext(text) IS 'args: EWKT - Return a specified geography value from Well-Known Text representation or extended (WKT).';


--
-- Name: st_geohash(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geohash(geom geometry, maxchars integer DEFAULT 0) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_GeoHash';


--
-- Name: FUNCTION st_geohash(geom geometry, maxchars integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geohash(geom geometry, maxchars integer) IS 'args: geom, maxchars=full_precision_of_point - Return a GeoHash representation (geohash.org) of the geometry.';


--
-- Name: st_geomcollfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomcollfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromText($1)) = 'GEOMETRYCOLLECTION'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_geomcollfromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomcollfromtext(text) IS 'args: WKT - Makes a collection Geometry from collection WKT with the given SRID. If SRID is not give, it defaults to -1.';


--
-- Name: st_geomcollfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomcollfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromText($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN ST_GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_geomcollfromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomcollfromtext(text, integer) IS 'args: WKT, srid - Makes a collection Geometry from collection WKT with the given SRID. If SRID is not give, it defaults to -1.';


--
-- Name: st_geomcollfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomcollfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromWKB($1)) = 'GEOMETRYCOLLECTION'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: st_geomcollfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomcollfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'GEOMETRYCOLLECTION'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: st_geometryfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometryfromtext(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_from_text';


--
-- Name: FUNCTION st_geometryfromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geometryfromtext(text) IS 'args: WKT - Return a specified ST_Geometry value from Well-Known Text representation (WKT). This is an alias name for ST_GeomFromText';


--
-- Name: st_geometryfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometryfromtext(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_from_text';


--
-- Name: FUNCTION st_geometryfromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geometryfromtext(text, integer) IS 'args: WKT, srid - Return a specified ST_Geometry value from Well-Known Text representation (WKT). This is an alias name for ST_GeomFromText';


--
-- Name: st_geometryn(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometryn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_geometryn_collection';


--
-- Name: FUNCTION st_geometryn(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geometryn(geometry, integer) IS 'args: geomA, n - Return the 1-based Nth geometry if the geometry is a GEOMETRYCOLLECTION, (MULTI)POINT, (MULTI)LINESTRING, MULTICURVE or (MULTI)POLYGON, POLYHEDRALSURFACE Otherwise, return NULL.';


--
-- Name: st_geometrytype(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geometrytype(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geometry_geometrytype';


--
-- Name: FUNCTION st_geometrytype(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geometrytype(geometry) IS 'args: g1 - Return the geometry type of the ST_Geometry value.';


--
-- Name: st_geomfromewkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromewkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOMFromWKB';


--
-- Name: FUNCTION st_geomfromewkb(bytea); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomfromewkb(bytea) IS 'args: EWKB - Return a specified ST_Geometry value from Extended Well-Known Binary representation (EWKB).';


--
-- Name: st_geomfromewkt(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromewkt(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'parse_WKT_lwgeom';


--
-- Name: FUNCTION st_geomfromewkt(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomfromewkt(text) IS 'args: EWKT - Return a specified ST_Geometry value from Extended Well-Known Text representation (EWKT).';


--
-- Name: st_geomfromgeojson(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromgeojson(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geom_from_geojson';


--
-- Name: FUNCTION st_geomfromgeojson(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomfromgeojson(text) IS 'args: geomjson - Takes as input a geojson representation of a geometry and outputs a PostGIS geometry object';


--
-- Name: st_geomfromgml(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromgml(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_GeomFromGML($1, 0)$_$;


--
-- Name: FUNCTION st_geomfromgml(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomfromgml(text) IS 'args: geomgml - Takes as input GML representation of geometry and outputs a PostGIS geometry object';


--
-- Name: st_geomfromgml(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromgml(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geom_from_gml';


--
-- Name: FUNCTION st_geomfromgml(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomfromgml(text, integer) IS 'args: geomgml, srid - Takes as input GML representation of geometry and outputs a PostGIS geometry object';


--
-- Name: st_geomfromkml(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromkml(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geom_from_kml';


--
-- Name: FUNCTION st_geomfromkml(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomfromkml(text) IS 'args: geomkml - Takes as input KML representation of geometry and outputs a PostGIS geometry object';


--
-- Name: st_geomfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromtext(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_from_text';


--
-- Name: FUNCTION st_geomfromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomfromtext(text) IS 'args: WKT - Return a specified ST_Geometry value from Well-Known Text representation (WKT).';


--
-- Name: st_geomfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromtext(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_from_text';


--
-- Name: FUNCTION st_geomfromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomfromtext(text, integer) IS 'args: WKT, srid - Return a specified ST_Geometry value from Well-Known Text representation (WKT).';


--
-- Name: st_geomfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromwkb(bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_from_WKB';


--
-- Name: FUNCTION st_geomfromwkb(bytea); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomfromwkb(bytea) IS 'args: geom - Makes a geometry from WKB with the given SRID';


--
-- Name: st_geomfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geomfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SetSRID(ST_GeomFromWKB($1), $2)$_$;


--
-- Name: FUNCTION st_geomfromwkb(bytea, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_geomfromwkb(bytea, integer) IS 'args: geom, srid - Makes a geometry from WKB with the given SRID';


--
-- Name: st_georeference(raster, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_georeference(rast raster, format text DEFAULT 'GDAL'::text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
    DECLARE
				scale_x numeric;
				scale_y numeric;
				skew_x numeric;
				skew_y numeric;
				ul_x numeric;
				ul_y numeric;

        result text;
    BEGIN
			SELECT scalex::numeric, scaley::numeric, skewx::numeric, skewy::numeric, upperleftx::numeric, upperlefty::numeric
				INTO scale_x, scale_y, skew_x, skew_y, ul_x, ul_y FROM ST_Metadata(rast);

						-- scale x
            result := trunc(scale_x, 10) || E'\n';

						-- skew y
            result := result || trunc(skew_y, 10) || E'\n';

						-- skew x
            result := result || trunc(skew_x, 10) || E'\n';

						-- scale y
            result := result || trunc(scale_y, 10) || E'\n';

        IF format = 'ESRI' THEN
						-- upper left x
            result := result || trunc((ul_x + scale_x * 0.5), 10) || E'\n';

						-- upper left y
            result = result || trunc((ul_y + scale_y * 0.5), 10) || E'\n';
        ELSE -- IF format = 'GDAL' THEN
						-- upper left x
            result := result || trunc(ul_x, 10) || E'\n';

						-- upper left y
            result := result || trunc(ul_y, 10) || E'\n';
        END IF;

        RETURN result;
    END;
    $$;


--
-- Name: FUNCTION st_georeference(rast raster, format text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_georeference(rast raster, format text) IS 'args: rast, format=GDAL - Returns the georeference meta data in GDAL or ESRI format as commonly seen in a world file. Default is GDAL.';


--
-- Name: st_geotransform(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_geotransform(raster, OUT imag double precision, OUT jmag double precision, OUT theta_i double precision, OUT theta_ij double precision, OUT xoffset double precision, OUT yoffset double precision) RETURNS record
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_getGeotransform';


--
-- Name: st_gmltosql(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_gmltosql(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_GeomFromGML($1, 0)$_$;


--
-- Name: FUNCTION st_gmltosql(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_gmltosql(text) IS 'args: geomgml - Return a specified ST_Geometry value from GML representation. This is an alias name for ST_GeomFromGML';


--
-- Name: st_gmltosql(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_gmltosql(text, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geom_from_gml';


--
-- Name: FUNCTION st_gmltosql(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_gmltosql(text, integer) IS 'args: geomgml, srid - Return a specified ST_Geometry value from GML representation. This is an alias name for ST_GeomFromGML';


--
-- Name: st_hasarc(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_hasarc(geometry geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_has_arc';


--
-- Name: FUNCTION st_hasarc(geometry geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_hasarc(geometry geometry) IS 'args: geomA - Returns true if a geometry or geometry collection contains a circular string';


--
-- Name: st_hasnoband(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_hasnoband(rast raster, nband integer DEFAULT 1) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_hasNoBand';


--
-- Name: FUNCTION st_hasnoband(rast raster, nband integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_hasnoband(rast raster, nband integer) IS 'args: rast, bandnum=1 - Returns true if there is no band with given band number. If no band number is specified, then band number 1 is assumed.';


--
-- Name: st_hausdorffdistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_hausdorffdistance(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'hausdorffdistance';


--
-- Name: FUNCTION st_hausdorffdistance(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_hausdorffdistance(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns the Hausdorff distance between two geometries. Basically a measure of how similar or dissimilar 2 geometries are. Units are in the units of the spatial reference system of the geometries.';


--
-- Name: st_hausdorffdistance(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_hausdorffdistance(geom1 geometry, geom2 geometry, double precision) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'hausdorffdistancedensify';


--
-- Name: FUNCTION st_hausdorffdistance(geom1 geometry, geom2 geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_hausdorffdistance(geom1 geometry, geom2 geometry, double precision) IS 'args: g1, g2, densifyFrac - Returns the Hausdorff distance between two geometries. Basically a measure of how similar or dissimilar 2 geometries are. Units are in the units of the spatial reference system of the geometries.';


--
-- Name: st_height(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_height(raster) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getHeight';


--
-- Name: FUNCTION st_height(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_height(raster) IS 'args: rast - Returns the height of the raster in pixels.';


--
-- Name: st_hillshade(raster, integer, text, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_hillshade(rast raster, band integer, pixeltype text, azimuth double precision, altitude double precision, max_bright double precision DEFAULT 255.0, elevation_scale double precision DEFAULT 1.0) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_mapalgebrafctngb($1, $2, $3, 1, 1, '_st_hillshade4ma(float[][], text, text[])'::regprocedure, 'value', st_pixelwidth($1)::text, st_pixelheight($1)::text, $4::text, $5::text, $6::text, $7::text) $_$;


--
-- Name: FUNCTION st_hillshade(rast raster, band integer, pixeltype text, azimuth double precision, altitude double precision, max_bright double precision, elevation_scale double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_hillshade(rast raster, band integer, pixeltype text, azimuth double precision, altitude double precision, max_bright double precision, elevation_scale double precision) IS 'args: rast, band, pixeltype, azimuth, altitude, max_bright=255, elevation_scale=1 - Returns the hypothetical illumination of an elevation raster band using provided azimuth, altitude, brightness and elevation scale inputs. Useful for visualizing terrain.';


--
-- Name: st_histogram(raster, integer, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_histogram(rast raster, nband integer, bins integer, "right" boolean) RETURNS SETOF histogram
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT min, max, count, percent FROM _st_histogram($1, $2, TRUE, 1, $3, NULL, $4) $_$;


--
-- Name: FUNCTION st_histogram(rast raster, nband integer, bins integer, "right" boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_histogram(rast raster, nband integer, bins integer, "right" boolean) IS 'args: rast, nband, bins, right - Returns a set of histogram summarizing a raster or raster coverage data distribution separate bin ranges. Number of bins are autocomputed if not specified.';


--
-- Name: st_histogram(raster, integer, boolean, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_histogram(rast raster, nband integer, exclude_nodata_value boolean, bins integer, "right" boolean) RETURNS SETOF histogram
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT min, max, count, percent FROM _st_histogram($1, $2, $3, 1, $4, NULL, $5) $_$;


--
-- Name: FUNCTION st_histogram(rast raster, nband integer, exclude_nodata_value boolean, bins integer, "right" boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_histogram(rast raster, nband integer, exclude_nodata_value boolean, bins integer, "right" boolean) IS 'args: rast, nband, exclude_nodata_value, bins, right - Returns a set of histogram summarizing a raster or raster coverage data distribution separate bin ranges. Number of bins are autocomputed if not specified.';


--
-- Name: st_histogram(raster, integer, integer, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_histogram(rast raster, nband integer, bins integer, width double precision[] DEFAULT NULL::double precision[], "right" boolean DEFAULT false) RETURNS SETOF histogram
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT min, max, count, percent FROM _st_histogram($1, $2, TRUE, 1, $3, $4, $5) $_$;


--
-- Name: FUNCTION st_histogram(rast raster, nband integer, bins integer, width double precision[], "right" boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_histogram(rast raster, nband integer, bins integer, width double precision[], "right" boolean) IS 'args: rast, nband, bins, width=NULL, right=false - Returns a set of histogram summarizing a raster or raster coverage data distribution separate bin ranges. Number of bins are autocomputed if not specified.';


--
-- Name: st_histogram(text, text, integer, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, bins integer, "right" boolean) RETURNS SETOF histogram
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_histogram($1, $2, $3, TRUE, 1, $4, NULL, $5) $_$;


--
-- Name: FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, bins integer, "right" boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, bins integer, "right" boolean) IS 'args: rastertable, rastercolumn, nband, bins, right - Returns a set of histogram summarizing a raster or raster coverage data distribution separate bin ranges. Number of bins are autocomputed if not specified.';


--
-- Name: st_histogram(raster, integer, boolean, integer, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_histogram(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, bins integer DEFAULT 0, width double precision[] DEFAULT NULL::double precision[], "right" boolean DEFAULT false) RETURNS SETOF histogram
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT min, max, count, percent FROM _st_histogram($1, $2, $3, 1, $4, $5, $6) $_$;


--
-- Name: FUNCTION st_histogram(rast raster, nband integer, exclude_nodata_value boolean, bins integer, width double precision[], "right" boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_histogram(rast raster, nband integer, exclude_nodata_value boolean, bins integer, width double precision[], "right" boolean) IS 'args: rast, nband=1, exclude_nodata_value=true, bins=autocomputed, width=NULL, right=false - Returns a set of histogram summarizing a raster or raster coverage data distribution separate bin ranges. Number of bins are autocomputed if not specified.';


--
-- Name: st_histogram(text, text, integer, boolean, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, bins integer, "right" boolean) RETURNS SETOF histogram
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_histogram($1, $2, $3, $4, 1, $5, NULL, $6) $_$;


--
-- Name: FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, bins integer, "right" boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, bins integer, "right" boolean) IS 'args: rastertable, rastercolumn, nband, exclude_nodata_value, bins, right - Returns a set of histogram summarizing a raster or raster coverage data distribution separate bin ranges. Number of bins are autocomputed if not specified.';


--
-- Name: st_histogram(text, text, integer, integer, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, bins integer, width double precision[] DEFAULT NULL::double precision[], "right" boolean DEFAULT false) RETURNS SETOF histogram
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_histogram($1, $2, $3, TRUE, 1, $4, $5, $6) $_$;


--
-- Name: FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, bins integer, width double precision[], "right" boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, bins integer, width double precision[], "right" boolean) IS 'args: rastertable, rastercolumn, nband=1, bins, width=NULL, right=false - Returns a set of histogram summarizing a raster or raster coverage data distribution separate bin ranges. Number of bins are autocomputed if not specified.';


--
-- Name: st_histogram(text, text, integer, boolean, integer, double precision[], boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, bins integer DEFAULT 0, width double precision[] DEFAULT NULL::double precision[], "right" boolean DEFAULT false) RETURNS SETOF histogram
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_histogram($1, $2, $3, $4, 1, $5, $6, $7) $_$;


--
-- Name: FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, bins integer, width double precision[], "right" boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_histogram(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, bins integer, width double precision[], "right" boolean) IS 'args: rastertable, rastercolumn, nband=1, exclude_nodata_value=true, bins=autocomputed, width=NULL, right=false - Returns a set of histogram summarizing a raster or raster coverage data distribution separate bin ranges. Number of bins are autocomputed if not specified.';


--
-- Name: st_interiorringn(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_interiorringn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_interiorringn_polygon';


--
-- Name: FUNCTION st_interiorringn(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_interiorringn(geometry, integer) IS 'args: a_polygon, n - Return the Nth interior linestring ring of the polygon geometry. Return NULL if the geometry is not a polygon or the given N is out of range.';


--
-- Name: st_interpolatepoint(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_interpolatepoint(line geometry, point geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_InterpolatePoint';


--
-- Name: FUNCTION st_interpolatepoint(line geometry, point geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_interpolatepoint(line geometry, point geometry) IS 'args: line, point - Return the value of the measure dimension of a geometry at the point closed to the provided point.';


--
-- Name: st_intersection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'intersection';


--
-- Name: FUNCTION st_intersection(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersection(geom1 geometry, geom2 geometry) IS 'args: geomA, geomB - (T) Returns a geometry that represents the shared portion of geomA and geomB. The geography implementation does a transform to geometry to do the intersection and then transform back to WGS84.';


--
-- Name: st_intersection(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(geography, geography) RETURNS geography
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT geography(ST_Transform(ST_Intersection(ST_Transform(geometry($1), _ST_BestSRID($1, $2)), ST_Transform(geometry($2), _ST_BestSRID($1, $2))), 4326))$_$;


--
-- Name: FUNCTION st_intersection(geography, geography); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersection(geography, geography) IS 'args: geogA, geogB - (T) Returns a geometry that represents the shared portion of geomA and geomB. The geography implementation does a transform to geometry to do the intersection and then transform back to WGS84.';


--
-- Name: st_intersection(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(text, text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Intersection($1::geometry, $2::geometry);  $_$;


--
-- Name: st_intersection(raster, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(rast raster, geomin geometry) RETURNS SETOF geomval
    LANGUAGE sql STABLE
    AS $_$ SELECT st_intersection($2, $1, 1) $_$;


--
-- Name: FUNCTION st_intersection(rast raster, geomin geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersection(rast raster, geomin geometry) IS 'args: rast, geom - Returns a raster or a set of geometry-pixelvalue pairs representing the shared portion of two rasters or the geometrical intersection of a vectorization of the raster and a geometry.';


--
-- Name: st_intersection(geometry, raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(geomin geometry, rast raster, band integer DEFAULT 1) RETURNS SETOF geomval
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
	DECLARE
		intersects boolean := FALSE;
	BEGIN
		intersects := ST_Intersects(geomin, rast, band);
		IF intersects THEN
			-- Return the intersections of the geometry with the vectorized parts of
			-- the raster and the values associated with those parts, if really their
			-- intersection is not empty.
			RETURN QUERY
				SELECT
					intgeom,
					val
				FROM (
					SELECT
						ST_Intersection((gv).geom, geomin) AS intgeom,
						(gv).val
					FROM ST_DumpAsPolygons(rast, band) gv
					WHERE ST_Intersects((gv).geom, geomin)
				) foo
				WHERE NOT ST_IsEmpty(intgeom);
		ELSE
			-- If the geometry does not intersect with the raster, return an empty
			-- geometry and a null value
			RETURN QUERY
				SELECT
					emptygeom,
					NULL::float8
				FROM ST_GeomCollFromText('GEOMETRYCOLLECTION EMPTY', ST_SRID($1)) emptygeom;
		END IF;
	END;
	$_$;


--
-- Name: FUNCTION st_intersection(geomin geometry, rast raster, band integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersection(geomin geometry, rast raster, band integer) IS 'args: geom, rast, band_num=1 - Returns a raster or a set of geometry-pixelvalue pairs representing the shared portion of two rasters or the geometrical intersection of a vectorization of the raster and a geometry.';


--
-- Name: st_intersection(raster, integer, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(rast raster, band integer, geomin geometry) RETURNS SETOF geomval
    LANGUAGE sql STABLE
    AS $_$ SELECT st_intersection($3, $1, $2) $_$;


--
-- Name: FUNCTION st_intersection(rast raster, band integer, geomin geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersection(rast raster, band integer, geomin geometry) IS 'args: rast, band_num, geom - Returns a raster or a set of geometry-pixelvalue pairs representing the shared portion of two rasters or the geometrical intersection of a vectorization of the raster and a geometry.';


--
-- Name: st_intersection(raster, raster, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(rast1 raster, rast2 raster, nodataval double precision[]) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_intersection($1, 1, $2, 1, 'BOTH', $3) $_$;


--
-- Name: FUNCTION st_intersection(rast1 raster, rast2 raster, nodataval double precision[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersection(rast1 raster, rast2 raster, nodataval double precision[]) IS 'args: rast1, rast2, nodataval - Returns a raster or a set of geometry-pixelvalue pairs representing the shared portion of two rasters or the geometrical intersection of a vectorization of the raster and a geometry.';


--
-- Name: st_intersection(raster, raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(rast1 raster, rast2 raster, nodataval double precision) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_intersection($1, 1, $2, 1, 'BOTH', ARRAY[$3, $3]) $_$;


--
-- Name: st_intersection(raster, raster, text, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(rast1 raster, rast2 raster, returnband text DEFAULT 'BOTH'::text, nodataval double precision[] DEFAULT NULL::double precision[]) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_intersection($1, 1, $2, 1, $3, $4) $_$;


--
-- Name: FUNCTION st_intersection(rast1 raster, rast2 raster, returnband text, nodataval double precision[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersection(rast1 raster, rast2 raster, returnband text, nodataval double precision[]) IS 'args: rast1, rast2, returnband=''BOTH'', nodataval=NULL - Returns a raster or a set of geometry-pixelvalue pairs representing the shared portion of two rasters or the geometrical intersection of a vectorization of the raster and a geometry.';


--
-- Name: st_intersection(raster, raster, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(rast1 raster, rast2 raster, returnband text, nodataval double precision) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_intersection($1, 1, $2, 1, $3, ARRAY[$4, $4]) $_$;


--
-- Name: st_intersection(raster, integer, raster, integer, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(rast1 raster, band1 integer, rast2 raster, band2 integer, nodataval double precision[]) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_intersection($1, $2, $3, $4, 'BOTH', $5) $_$;


--
-- Name: FUNCTION st_intersection(rast1 raster, band1 integer, rast2 raster, band2 integer, nodataval double precision[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersection(rast1 raster, band1 integer, rast2 raster, band2 integer, nodataval double precision[]) IS 'args: rast1, band_num1, rast2, band_num2, nodataval - Returns a raster or a set of geometry-pixelvalue pairs representing the shared portion of two rasters or the geometrical intersection of a vectorization of the raster and a geometry.';


--
-- Name: st_intersection(raster, integer, raster, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(rast1 raster, band1 integer, rast2 raster, band2 integer, nodataval double precision) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_intersection($1, $2, $3, $4, 'BOTH', ARRAY[$5, $5]) $_$;


--
-- Name: st_intersection(raster, integer, raster, integer, text, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(rast1 raster, band1 integer, rast2 raster, band2 integer, returnband text DEFAULT 'BOTH'::text, nodataval double precision[] DEFAULT NULL::double precision[]) RETURNS raster
    LANGUAGE plpgsql STABLE
    AS $$
	DECLARE
		rtn raster;
		_returnband text;
		newnodata1 float8;
		newnodata2 float8;
	BEGIN
		newnodata1 := coalesce(nodataval[1], ST_BandNodataValue(rast1, band1), ST_MinPossibleValue(ST_BandPixelType(rast1, band1)));
		newnodata2 := coalesce(nodataval[2], ST_BandNodataValue(rast2, band2), ST_MinPossibleValue(ST_BandPixelType(rast2, band2)));
		
		_returnband := upper(returnband);

		rtn := NULL;
		CASE
			WHEN _returnband = 'BAND1' THEN
				rtn := ST_MapAlgebraExpr(rast1, band1, rast2, band2, '[rast1.val]', ST_BandPixelType(rast1, band1), 'INTERSECTION', newnodata1::text, newnodata1::text, newnodata1);
				rtn := ST_SetBandNodataValue(rtn, 1, newnodata1);
			WHEN _returnband = 'BAND2' THEN
				rtn := ST_MapAlgebraExpr(rast1, band1, rast2, band2, '[rast2.val]', ST_BandPixelType(rast2, band2), 'INTERSECTION', newnodata2::text, newnodata2::text, newnodata2);
				rtn := ST_SetBandNodataValue(rtn, 1, newnodata2);
			WHEN _returnband = 'BOTH' THEN
				rtn := ST_MapAlgebraExpr(rast1, band1, rast2, band2, '[rast1.val]', ST_BandPixelType(rast1, band1), 'INTERSECTION', newnodata1::text, newnodata1::text, newnodata1);
				rtn := ST_SetBandNodataValue(rtn, 1, newnodata1);
				rtn := ST_AddBand(rtn, ST_MapAlgebraExpr(rast1, band1, rast2, band2, '[rast2.val]', ST_BandPixelType(rast2, band2), 'INTERSECTION', newnodata2::text, newnodata2::text, newnodata2));
				rtn := ST_SetBandNodataValue(rtn, 2, newnodata2);
			ELSE
				RAISE EXCEPTION 'Unknown value provided for returnband: %', returnband;
				RETURN NULL;
		END CASE;

		RETURN rtn;
	END;
	$$;


--
-- Name: FUNCTION st_intersection(rast1 raster, band1 integer, rast2 raster, band2 integer, returnband text, nodataval double precision[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersection(rast1 raster, band1 integer, rast2 raster, band2 integer, returnband text, nodataval double precision[]) IS 'args: rast1, band_num1, rast2, band_num2, returnband=''BOTH'', nodataval=NULL - Returns a raster or a set of geometry-pixelvalue pairs representing the shared portion of two rasters or the geometrical intersection of a vectorization of the raster and a geometry.';


--
-- Name: st_intersection(raster, integer, raster, integer, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersection(rast1 raster, band1 integer, rast2 raster, band2 integer, returnband text, nodataval double precision) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_intersection($1, $2, $3, $4, $5, ARRAY[$6, $6]) $_$;


--
-- Name: st_intersects(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Intersects($1,$2)$_$;


--
-- Name: FUNCTION st_intersects(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersects(geom1 geometry, geom2 geometry) IS 'args: geomA, geomB - Returns TRUE if the Geometries/Geography "spatially intersect in 2D" - (share any portion of space) and FALSE if they dont (they are Disjoint). For geography -- tolerance is 0.00001 meters (so any points that close are considered to intersect)';


--
-- Name: st_intersects(geography, geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(geography, geography) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Distance($1, $2, 0.0, false) < 0.00001$_$;


--
-- Name: FUNCTION st_intersects(geography, geography); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersects(geography, geography) IS 'args: geogA, geogB - Returns TRUE if the Geometries/Geography "spatially intersect in 2D" - (share any portion of space) and FALSE if they dont (they are Disjoint). For geography -- tolerance is 0.00001 meters (so any points that close are considered to intersect)';


--
-- Name: st_intersects(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(text, text) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT ST_Intersects($1::geometry, $2::geometry);  $_$;


--
-- Name: st_intersects(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(rast1 raster, rast2 raster) RETURNS boolean
    LANGUAGE sql IMMUTABLE COST 1000
    AS $_$ SELECT st_intersects($1, NULL::integer, $2, NULL::integer) $_$;


--
-- Name: FUNCTION st_intersects(rast1 raster, rast2 raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersects(rast1 raster, rast2 raster) IS 'args: rasta, rastb - Return true if the raster spatially intersects a separate raster or geometry. If the band number is not provided (or set to NULL), only the convex hull of the raster is considered in the test. If the band number is provided, only those pixels with value (not NODATA) are considered in the test.';


--
-- Name: st_intersects(raster, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(rast raster, geom geometry, nband integer DEFAULT NULL::integer) RETURNS boolean
    LANGUAGE sql IMMUTABLE COST 1000
    AS $_$ SELECT $1::geometry && $2 AND _st_intersects($1, $2, $3) $_$;


--
-- Name: FUNCTION st_intersects(rast raster, geom geometry, nband integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersects(rast raster, geom geometry, nband integer) IS 'args: rast, geommin, nband=NULL - Return true if the raster spatially intersects a separate raster or geometry. If the band number is not provided (or set to NULL), only the convex hull of the raster is considered in the test. If the band number is provided, only those pixels with value (not NODATA) are considered in the test.';


--
-- Name: st_intersects(raster, integer, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(rast raster, nband integer, geom geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE COST 1000
    AS $_$ SELECT $1::geometry && $3 AND _st_intersects($1, $3, $2) $_$;


--
-- Name: FUNCTION st_intersects(rast raster, nband integer, geom geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersects(rast raster, nband integer, geom geometry) IS 'args: rast, nband, geommin - Return true if the raster spatially intersects a separate raster or geometry. If the band number is not provided (or set to NULL), only the convex hull of the raster is considered in the test. If the band number is provided, only those pixels with value (not NODATA) are considered in the test.';


--
-- Name: st_intersects(geometry, raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(geom geometry, rast raster, nband integer DEFAULT NULL::integer) RETURNS boolean
    LANGUAGE sql IMMUTABLE COST 1000
    AS $_$ SELECT $1 && $2::geometry AND _st_intersects($1, $2, $3); $_$;


--
-- Name: FUNCTION st_intersects(geom geometry, rast raster, nband integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersects(geom geometry, rast raster, nband integer) IS 'args: geommin, rast, nband=NULL - Return true if the raster spatially intersects a separate raster or geometry. If the band number is not provided (or set to NULL), only the convex hull of the raster is considered in the test. If the band number is provided, only those pixels with value (not NODATA) are considered in the test.';


--
-- Name: st_intersects(raster, integer, raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_intersects(rast1 raster, nband1 integer, rast2 raster, nband2 integer) RETURNS boolean
    LANGUAGE sql IMMUTABLE COST 1000
    AS $_$ SELECT $1 && $3 AND CASE WHEN $2 IS NULL OR $4 IS NULL THEN TRUE ELSE _st_intersects($1, $2, $3, $4) END $_$;


--
-- Name: FUNCTION st_intersects(rast1 raster, nband1 integer, rast2 raster, nband2 integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_intersects(rast1 raster, nband1 integer, rast2 raster, nband2 integer) IS 'args: rasta, nbanda, rastb, nbandb - Return true if the raster spatially intersects a separate raster or geometry. If the band number is not provided (or set to NULL), only the convex hull of the raster is considered in the test. If the band number is provided, only those pixels with value (not NODATA) are considered in the test.';


--
-- Name: st_isclosed(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isclosed(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_isclosed';


--
-- Name: FUNCTION st_isclosed(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_isclosed(geometry) IS 'args: g - Returns TRUE if the LINESTRINGs start and end points are coincident. For Polyhedral surface is closed (volumetric).';


--
-- Name: st_iscollection(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_iscollection(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_IsCollection';


--
-- Name: FUNCTION st_iscollection(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_iscollection(geometry) IS 'args: g - Returns TRUE if the argument is a collection (MULTI*, GEOMETRYCOLLECTION, ...)';


--
-- Name: st_isempty(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isempty(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_isempty';


--
-- Name: FUNCTION st_isempty(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_isempty(geometry) IS 'args: geomA - Returns true if this Geometry is an empty geometrycollection, polygon, point etc.';


--
-- Name: st_isempty(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isempty(rast raster) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_isEmpty';


--
-- Name: FUNCTION st_isempty(rast raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_isempty(rast raster) IS 'args: rast - Returns true if the raster is empty (width = 0 and height = 0). Otherwise, returns false.';


--
-- Name: st_isring(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isring(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'isring';


--
-- Name: FUNCTION st_isring(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_isring(geometry) IS 'args: g - Returns TRUE if this LINESTRING is both closed and simple.';


--
-- Name: st_issimple(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_issimple(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'issimple';


--
-- Name: FUNCTION st_issimple(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_issimple(geometry) IS 'args: geomA - Returns (TRUE) if this Geometry has no anomalous geometric points, such as self intersection or self tangency.';


--
-- Name: st_isvalid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isvalid(geometry) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'isvalid';


--
-- Name: FUNCTION st_isvalid(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_isvalid(geometry) IS 'args: g - Returns true if the ST_Geometry is well formed.';


--
-- Name: st_isvalid(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isvalid(geometry, integer) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT (ST_isValidDetail($1, $2)).valid$_$;


--
-- Name: FUNCTION st_isvalid(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_isvalid(geometry, integer) IS 'args: g, flags - Returns true if the ST_Geometry is well formed.';


--
-- Name: st_isvaliddetail(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isvaliddetail(geometry) RETURNS valid_detail
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'isvaliddetail';


--
-- Name: FUNCTION st_isvaliddetail(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_isvaliddetail(geometry) IS 'args: geom - Returns a valid_detail (valid,reason,location) row stating if a geometry is valid or not and if not valid, a reason why and a location where.';


--
-- Name: st_isvaliddetail(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isvaliddetail(geometry, integer) RETURNS valid_detail
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'isvaliddetail';


--
-- Name: FUNCTION st_isvaliddetail(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_isvaliddetail(geometry, integer) IS 'args: geom, flags - Returns a valid_detail (valid,reason,location) row stating if a geometry is valid or not and if not valid, a reason why and a location where.';


--
-- Name: st_isvalidreason(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isvalidreason(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'isvalidreason';


--
-- Name: FUNCTION st_isvalidreason(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_isvalidreason(geometry) IS 'args: geomA - Returns text stating if a geometry is valid or not and if not valid, a reason why.';


--
-- Name: st_isvalidreason(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_isvalidreason(geometry, integer) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT CASE WHEN valid THEN 'Valid Geometry' ELSE reason END FROM (
	SELECT (ST_isValidDetail($1, $2)).*
) foo
	$_$;


--
-- Name: FUNCTION st_isvalidreason(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_isvalidreason(geometry, integer) IS 'args: geomA, flags - Returns text stating if a geometry is valid or not and if not valid, a reason why.';


--
-- Name: st_length(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_length2d_linestring';


--
-- Name: FUNCTION st_length(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_length(geometry) IS 'args: a_2dlinestring - Returns the 2d length of the geometry if it is a linestring or multilinestring. geometry are in units of spatial reference and geography are in meters (default spheroid)';


--
-- Name: st_length(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length(text) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_Length($1::geometry);  $_$;


--
-- Name: st_length(geography, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length(geog geography, use_spheroid boolean DEFAULT true) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'geography_length';


--
-- Name: FUNCTION st_length(geog geography, use_spheroid boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_length(geog geography, use_spheroid boolean) IS 'args: geog, use_spheroid=true - Returns the 2d length of the geometry if it is a linestring or multilinestring. geometry are in units of spatial reference and geography are in meters (default spheroid)';


--
-- Name: st_length2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_length2d_linestring';


--
-- Name: FUNCTION st_length2d(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_length2d(geometry) IS 'args: a_2dlinestring - Returns the 2-dimensional length of the geometry if it is a linestring or multi-linestring. This is an alias for ST_Length';


--
-- Name: st_length2d_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length2d_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_length2d_ellipsoid';


--
-- Name: FUNCTION st_length2d_spheroid(geometry, spheroid); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_length2d_spheroid(geometry, spheroid) IS 'args: a_linestring, a_spheroid - Calculates the 2D length of a linestring/multilinestring on an ellipsoid. This is useful if the coordinates of the geometry are in longitude/latitude and a length is desired without reprojection.';


--
-- Name: st_length_spheroid(geometry, spheroid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_length_spheroid(geometry, spheroid) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'LWGEOM_length_ellipsoid_linestring';


--
-- Name: FUNCTION st_length_spheroid(geometry, spheroid); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_length_spheroid(geometry, spheroid) IS 'args: a_linestring, a_spheroid - Calculates the 2D or 3D length of a linestring/multilinestring on an ellipsoid. This is useful if the coordinates of the geometry are in longitude/latitude and a length is desired without reprojection.';


--
-- Name: st_line_interpolate_point(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_line_interpolate_point(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_line_interpolate_point';


--
-- Name: FUNCTION st_line_interpolate_point(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_line_interpolate_point(geometry, double precision) IS 'args: a_linestring, a_fraction - Returns a point interpolated along a line. Second argument is a float8 between 0 and 1 representing fraction of total length of linestring the point has to be located.';


--
-- Name: st_line_locate_point(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_line_locate_point(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_line_locate_point';


--
-- Name: FUNCTION st_line_locate_point(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_line_locate_point(geom1 geometry, geom2 geometry) IS 'args: a_linestring, a_point - Returns a float between 0 and 1 representing the location of the closest point on LineString to the given Point, as a fraction of total 2d line length.';


--
-- Name: st_line_substring(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_line_substring(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_line_substring';


--
-- Name: FUNCTION st_line_substring(geometry, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_line_substring(geometry, double precision, double precision) IS 'args: a_linestring, startfraction, endfraction - Return a linestring being a substring of the input one starting and ending at the given fractions of total 2d length. Second and third arguments are float8 values between 0 and 1.';


--
-- Name: st_linecrossingdirection(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linecrossingdirection(geom1 geometry, geom2 geometry) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT CASE WHEN NOT $1 && $2 THEN 0 ELSE _ST_LineCrossingDirection($1,$2) END $_$;


--
-- Name: FUNCTION st_linecrossingdirection(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_linecrossingdirection(geom1 geometry, geom2 geometry) IS 'args: linestringA, linestringB - Given 2 linestrings, returns a number between -3 and 3 denoting what kind of crossing behavior. 0 is no crossing.';


--
-- Name: st_linefrommultipoint(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linefrommultipoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_line_from_mpoint';


--
-- Name: FUNCTION st_linefrommultipoint(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_linefrommultipoint(geometry) IS 'args: aMultiPoint - Creates a LineString from a MultiPoint geometry.';


--
-- Name: st_linefromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'LINESTRING'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_linefromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_linefromtext(text) IS 'args: WKT - Makes a Geometry from WKT representation with the given SRID. If SRID is not given, it defaults to -1.';


--
-- Name: st_linefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'LINESTRING'
	THEN ST_GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_linefromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_linefromtext(text, integer) IS 'args: WKT, srid - Makes a Geometry from WKT representation with the given SRID. If SRID is not given, it defaults to -1.';


--
-- Name: st_linefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'LINESTRING'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_linefromwkb(bytea); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_linefromwkb(bytea) IS 'args: WKB - Makes a LINESTRING from WKB with the given SRID';


--
-- Name: st_linefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_linefromwkb(bytea, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_linefromwkb(bytea, integer) IS 'args: WKB, srid - Makes a LINESTRING from WKB with the given SRID';


--
-- Name: st_linemerge(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linemerge(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'linemerge';


--
-- Name: FUNCTION st_linemerge(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_linemerge(geometry) IS 'args: amultilinestring - Returns a (set of) LineString(s) formed by sewing together a MULTILINESTRING.';


--
-- Name: st_linestringfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linestringfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'LINESTRING'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_linestringfromwkb(bytea); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_linestringfromwkb(bytea) IS 'args: WKB - Makes a geometry from WKB with the given SRID.';


--
-- Name: st_linestringfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linestringfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'LINESTRING'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_linestringfromwkb(bytea, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_linestringfromwkb(bytea, integer) IS 'args: WKB, srid - Makes a geometry from WKB with the given SRID.';


--
-- Name: st_linetocurve(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_linetocurve(geometry geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_line_desegmentize';


--
-- Name: FUNCTION st_linetocurve(geometry geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_linetocurve(geometry geometry) IS 'args: geomANoncircular - Converts a LINESTRING/POLYGON to a CIRCULARSTRING, CURVED POLYGON';


--
-- Name: st_locate_along_measure(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_locate_along_measure(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT ST_locate_between_measures($1, $2, $2) $_$;


--
-- Name: st_locate_between_measures(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_locate_between_measures(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_locate_between_m';


--
-- Name: st_locatealong(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_locatealong(geometry geometry, measure double precision, leftrightoffset double precision DEFAULT 0.0) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_LocateAlong';


--
-- Name: FUNCTION st_locatealong(geometry geometry, measure double precision, leftrightoffset double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_locatealong(geometry geometry, measure double precision, leftrightoffset double precision) IS 'args: ageom_with_measure, a_measure, offset - Return a derived geometry collection value with elements that match the specified measure. Polygonal elements are not supported.';


--
-- Name: st_locatebetween(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_locatebetween(geometry geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision DEFAULT 0.0) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_LocateBetween';


--
-- Name: FUNCTION st_locatebetween(geometry geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_locatebetween(geometry geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision) IS 'args: geomA, measure_start, measure_end, offset - Return a derived geometry collection value with elements that match the specified range of measures inclusively. Polygonal elements are not supported.';


--
-- Name: st_locatebetweenelevations(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_locatebetweenelevations(geometry geometry, fromelevation double precision, toelevation double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_LocateBetweenElevations';


--
-- Name: FUNCTION st_locatebetweenelevations(geometry geometry, fromelevation double precision, toelevation double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_locatebetweenelevations(geometry geometry, fromelevation double precision, toelevation double precision) IS 'args: geom_mline, elevation_start, elevation_end - Return a derived geometry (collection) value with elements that intersect the specified range of elevations inclusively. Only 3D, 4D LINESTRINGS and MULTILINESTRINGS are supported.';


--
-- Name: st_longestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_longestline(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_LongestLine(ST_ConvexHull($1), ST_ConvexHull($2))$_$;


--
-- Name: FUNCTION st_longestline(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_longestline(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns the 2-dimensional longest line points of two geometries. The function will only return the first longest line if more than one, that the function finds. The line returned will always start in g1 and end in g2. The length of the line this function returns will always be the same as st_maxdistance returns for g1 and g2.';


--
-- Name: st_m(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_m(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_m_point';


--
-- Name: FUNCTION st_m(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_m(geometry) IS 'args: a_point - Return the M coordinate of the point, or NULL if not available. Input must be a point.';


--
-- Name: st_makebox2d(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makebox2d(geom1 geometry, geom2 geometry) RETURNS box2d
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX2D_construct';


--
-- Name: FUNCTION st_makebox2d(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makebox2d(geom1 geometry, geom2 geometry) IS 'args: pointLowLeft, pointUpRight - Creates a BOX2D defined by the given point geometries.';


--
-- Name: st_makeemptyraster(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makeemptyraster(rast raster) RETURNS raster
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
		DECLARE
			w int;
			h int;
			ul_x double precision;
			ul_y double precision;
			scale_x double precision;
			scale_y double precision;
			skew_x double precision;
			skew_y double precision;
			sr_id int;
		BEGIN
			SELECT width, height, upperleftx, upperlefty, scalex, scaley, skewx, skewy, srid INTO w, h, ul_x, ul_y, scale_x, scale_y, skew_x, skew_y, sr_id FROM ST_Metadata(rast);
			RETURN st_makeemptyraster(w, h, ul_x, ul_y, scale_x, scale_y, skew_x, skew_y, sr_id);
		END;
    $$;


--
-- Name: FUNCTION st_makeemptyraster(rast raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makeemptyraster(rast raster) IS 'args: rast - Returns an empty raster (having no bands) of given dimensions (width & height), upperleft X and Y, pixel size and rotation (scalex, scaley, skewx & skewy) and reference system (srid). If a raster is passed in, returns a new raster with the same size, alignment and SRID. If srid is left out, the spatial ref is set to unknown (0).';


--
-- Name: st_makeemptyraster(integer, integer, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makeemptyraster(width integer, height integer, upperleftx double precision, upperlefty double precision, pixelsize double precision) RETURNS raster
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT st_makeemptyraster($1, $2, $3, $4, $5, -($5), 0, 0, ST_SRID('POINT(0 0)'::geometry)) $_$;


--
-- Name: FUNCTION st_makeemptyraster(width integer, height integer, upperleftx double precision, upperlefty double precision, pixelsize double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makeemptyraster(width integer, height integer, upperleftx double precision, upperlefty double precision, pixelsize double precision) IS 'args: width, height, upperleftx, upperlefty, pixelsize - Returns an empty raster (having no bands) of given dimensions (width & height), upperleft X and Y, pixel size and rotation (scalex, scaley, skewx & skewy) and reference system (srid). If a raster is passed in, returns a new raster with the same size, alignment and SRID. If srid is left out, the spatial ref is set to unknown (0).';


--
-- Name: st_makeemptyraster(integer, integer, double precision, double precision, double precision, double precision, double precision, double precision, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makeemptyraster(width integer, height integer, upperleftx double precision, upperlefty double precision, scalex double precision, scaley double precision, skewx double precision, skewy double precision, srid integer DEFAULT 0) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_makeEmpty';


--
-- Name: FUNCTION st_makeemptyraster(width integer, height integer, upperleftx double precision, upperlefty double precision, scalex double precision, scaley double precision, skewx double precision, skewy double precision, srid integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makeemptyraster(width integer, height integer, upperleftx double precision, upperlefty double precision, scalex double precision, scaley double precision, skewx double precision, skewy double precision, srid integer) IS 'args: width, height, upperleftx, upperlefty, scalex, scaley, skewx, skewy, srid=unknown - Returns an empty raster (having no bands) of given dimensions (width & height), upperleft X and Y, pixel size and rotation (scalex, scaley, skewx & skewy) and reference system (srid). If a raster is passed in, returns a new raster with the same size, alignment and SRID. If srid is left out, the spatial ref is set to unknown (0).';


--
-- Name: st_makeenvelope(double precision, double precision, double precision, double precision, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makeenvelope(double precision, double precision, double precision, double precision, integer DEFAULT 0) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_MakeEnvelope';


--
-- Name: FUNCTION st_makeenvelope(double precision, double precision, double precision, double precision, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makeenvelope(double precision, double precision, double precision, double precision, integer) IS 'args: xmin, ymin, xmax, ymax, srid=unknown - Creates a rectangular Polygon formed from the given minimums and maximums. Input values must be in SRS specified by the SRID.';


--
-- Name: st_makeline(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makeline(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_makeline_garray';


--
-- Name: FUNCTION st_makeline(geometry[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makeline(geometry[]) IS 'args: geoms_array - Creates a Linestring from point or line geometries.';


--
-- Name: st_makeline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makeline(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_makeline';


--
-- Name: FUNCTION st_makeline(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makeline(geom1 geometry, geom2 geometry) IS 'args: geom1, geom2 - Creates a Linestring from point or line geometries.';


--
-- Name: st_makepoint(double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepoint(double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_makepoint';


--
-- Name: FUNCTION st_makepoint(double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makepoint(double precision, double precision) IS 'args: x, y - Creates a 2D,3DZ or 4D point geometry.';


--
-- Name: st_makepoint(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepoint(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_makepoint';


--
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makepoint(double precision, double precision, double precision) IS 'args: x, y, z - Creates a 2D,3DZ or 4D point geometry.';


--
-- Name: st_makepoint(double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepoint(double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_makepoint';


--
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makepoint(double precision, double precision, double precision, double precision) IS 'args: x, y, z, m - Creates a 2D,3DZ or 4D point geometry.';


--
-- Name: st_makepointm(double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepointm(double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_makepoint3dm';


--
-- Name: FUNCTION st_makepointm(double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makepointm(double precision, double precision, double precision) IS 'args: x, y, m - Creates a point geometry with an x y and m coordinate.';


--
-- Name: st_makepolygon(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepolygon(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_makepoly';


--
-- Name: FUNCTION st_makepolygon(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makepolygon(geometry) IS 'args: linestring - Creates a Polygon formed by the given shell. Input geometries must be closed LINESTRINGS.';


--
-- Name: st_makepolygon(geometry, geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makepolygon(geometry, geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_makepoly';


--
-- Name: FUNCTION st_makepolygon(geometry, geometry[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makepolygon(geometry, geometry[]) IS 'args: outerlinestring, interiorlinestrings - Creates a Polygon formed by the given shell. Input geometries must be closed LINESTRINGS.';


--
-- Name: st_makevalid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_makevalid(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_MakeValid';


--
-- Name: FUNCTION st_makevalid(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_makevalid(geometry) IS 'args: input - Attempts to make an invalid geometry valid w/out loosing vertices.';


--
-- Name: st_mapalgebraexpr(raster, text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebraexpr(rast raster, pixeltype text, expression text, nodataval double precision DEFAULT NULL::double precision) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_mapalgebraexpr($1, 1, $2, $3, $4) $_$;


--
-- Name: FUNCTION st_mapalgebraexpr(rast raster, pixeltype text, expression text, nodataval double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebraexpr(rast raster, pixeltype text, expression text, nodataval double precision) IS 'args: rast, pixeltype, expression, nodataval=NULL - 1 raster band version: Creates a new one band raster formed by applying a valid PostgreSQL algebraic operation on the input raster band and of pixeltype provided. Band 1 is assumed if no band is specified.';


--
-- Name: st_mapalgebraexpr(raster, integer, text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebraexpr(rast raster, band integer, pixeltype text, expression text, nodataval double precision DEFAULT NULL::double precision) RETURNS raster
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_mapAlgebraExpr';


--
-- Name: FUNCTION st_mapalgebraexpr(rast raster, band integer, pixeltype text, expression text, nodataval double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebraexpr(rast raster, band integer, pixeltype text, expression text, nodataval double precision) IS 'args: rast, band, pixeltype, expression, nodataval=NULL - 1 raster band version: Creates a new one band raster formed by applying a valid PostgreSQL algebraic operation on the input raster band and of pixeltype provided. Band 1 is assumed if no band is specified.';


--
-- Name: st_mapalgebraexpr(raster, raster, text, text, text, text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebraexpr(rast1 raster, rast2 raster, expression text, pixeltype text DEFAULT NULL::text, extenttype text DEFAULT 'INTERSECTION'::text, nodata1expr text DEFAULT NULL::text, nodata2expr text DEFAULT NULL::text, nodatanodataval double precision DEFAULT NULL::double precision) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_mapalgebraexpr($1, 1, $2, 1, $3, $4, $5, $6, $7, $8) $_$;


--
-- Name: FUNCTION st_mapalgebraexpr(rast1 raster, rast2 raster, expression text, pixeltype text, extenttype text, nodata1expr text, nodata2expr text, nodatanodataval double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebraexpr(rast1 raster, rast2 raster, expression text, pixeltype text, extenttype text, nodata1expr text, nodata2expr text, nodatanodataval double precision) IS 'args: rast1, rast2, expression, pixeltype=same_as_rast1_band, extenttype=INTERSECTION, nodata1expr=NULL, nodata2expr=NULL, nodatanodataval=NULL - 2 raster band version: Creates a new one band raster formed by applying a valid PostgreSQL algebraic operation on the two input raster bands and of pixeltype provided. band 1 of each raster is assumed if no band numbers are specified. The resulting raster will be aligned (scale, skew and pixel corners) on the grid defined by the first raster and have its extent defined by the "extenttype" parameter. Values for "extenttype" can be: INTERSECTION, UNION, FIRST, SECOND.';


--
-- Name: st_mapalgebraexpr(raster, integer, raster, integer, text, text, text, text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebraexpr(rast1 raster, band1 integer, rast2 raster, band2 integer, expression text, pixeltype text DEFAULT NULL::text, extenttype text DEFAULT 'INTERSECTION'::text, nodata1expr text DEFAULT NULL::text, nodata2expr text DEFAULT NULL::text, nodatanodataval double precision DEFAULT NULL::double precision) RETURNS raster
    LANGUAGE c STABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_mapAlgebra2';


--
-- Name: FUNCTION st_mapalgebraexpr(rast1 raster, band1 integer, rast2 raster, band2 integer, expression text, pixeltype text, extenttype text, nodata1expr text, nodata2expr text, nodatanodataval double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebraexpr(rast1 raster, band1 integer, rast2 raster, band2 integer, expression text, pixeltype text, extenttype text, nodata1expr text, nodata2expr text, nodatanodataval double precision) IS 'args: rast1, band1, rast2, band2, expression, pixeltype=same_as_rast1_band, extenttype=INTERSECTION, nodata1expr=NULL, nodata2expr=NULL, nodatanodataval=NULL - 2 raster band version: Creates a new one band raster formed by applying a valid PostgreSQL algebraic operation on the two input raster bands and of pixeltype provided. band 1 of each raster is assumed if no band numbers are specified. The resulting raster will be aligned (scale, skew and pixel corners) on the grid defined by the first raster and have its extent defined by the "extenttype" parameter. Values for "extenttype" can be: INTERSECTION, UNION, FIRST, SECOND.';


--
-- Name: st_mapalgebrafct(raster, regprocedure); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafct(rast raster, onerastuserfunc regprocedure) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_mapalgebrafct($1, 1, NULL, $2, NULL) $_$;


--
-- Name: FUNCTION st_mapalgebrafct(rast raster, onerastuserfunc regprocedure); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafct(rast raster, onerastuserfunc regprocedure) IS 'args: rast, onerasteruserfunc - 1 band version - Creates a new one band raster formed by applying a valid PostgreSQL function on the input raster band and of pixeltype prodived. Band 1 is assumed if no band is specified.';


--
-- Name: st_mapalgebrafct(raster, integer, regprocedure); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafct(rast raster, band integer, onerastuserfunc regprocedure) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_mapalgebrafct($1, $2, NULL, $3, NULL) $_$;


--
-- Name: FUNCTION st_mapalgebrafct(rast raster, band integer, onerastuserfunc regprocedure); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafct(rast raster, band integer, onerastuserfunc regprocedure) IS 'args: rast, band, onerasteruserfunc - 1 band version - Creates a new one band raster formed by applying a valid PostgreSQL function on the input raster band and of pixeltype prodived. Band 1 is assumed if no band is specified.';


--
-- Name: st_mapalgebrafct(raster, text, regprocedure); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafct(rast raster, pixeltype text, onerastuserfunc regprocedure) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_mapalgebrafct($1, 1, $2, $3, NULL) $_$;


--
-- Name: FUNCTION st_mapalgebrafct(rast raster, pixeltype text, onerastuserfunc regprocedure); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafct(rast raster, pixeltype text, onerastuserfunc regprocedure) IS 'args: rast, pixeltype, onerasteruserfunc - 1 band version - Creates a new one band raster formed by applying a valid PostgreSQL function on the input raster band and of pixeltype prodived. Band 1 is assumed if no band is specified.';


--
-- Name: st_mapalgebrafct(raster, regprocedure, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafct(rast raster, onerastuserfunc regprocedure, VARIADIC args text[]) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_mapalgebrafct($1, 1, NULL, $2, VARIADIC $3) $_$;


--
-- Name: FUNCTION st_mapalgebrafct(rast raster, onerastuserfunc regprocedure, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafct(rast raster, onerastuserfunc regprocedure, VARIADIC args text[]) IS 'args: rast, onerasteruserfunc, VARIADIC args - 1 band version - Creates a new one band raster formed by applying a valid PostgreSQL function on the input raster band and of pixeltype prodived. Band 1 is assumed if no band is specified.';


--
-- Name: st_mapalgebrafct(raster, integer, text, regprocedure); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafct(rast raster, band integer, pixeltype text, onerastuserfunc regprocedure) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_mapalgebrafct($1, $2, $3, $4, NULL) $_$;


--
-- Name: FUNCTION st_mapalgebrafct(rast raster, band integer, pixeltype text, onerastuserfunc regprocedure); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafct(rast raster, band integer, pixeltype text, onerastuserfunc regprocedure) IS 'args: rast, band, pixeltype, onerasteruserfunc - 1 band version - Creates a new one band raster formed by applying a valid PostgreSQL function on the input raster band and of pixeltype prodived. Band 1 is assumed if no band is specified.';


--
-- Name: st_mapalgebrafct(raster, integer, regprocedure, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafct(rast raster, band integer, onerastuserfunc regprocedure, VARIADIC args text[]) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_mapalgebrafct($1, $2, NULL, $3, VARIADIC $4) $_$;


--
-- Name: FUNCTION st_mapalgebrafct(rast raster, band integer, onerastuserfunc regprocedure, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafct(rast raster, band integer, onerastuserfunc regprocedure, VARIADIC args text[]) IS 'args: rast, band, onerasteruserfunc, VARIADIC args - 1 band version - Creates a new one band raster formed by applying a valid PostgreSQL function on the input raster band and of pixeltype prodived. Band 1 is assumed if no band is specified.';


--
-- Name: st_mapalgebrafct(raster, text, regprocedure, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafct(rast raster, pixeltype text, onerastuserfunc regprocedure, VARIADIC args text[]) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_mapalgebrafct($1, 1, $2, $3, VARIADIC $4) $_$;


--
-- Name: FUNCTION st_mapalgebrafct(rast raster, pixeltype text, onerastuserfunc regprocedure, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafct(rast raster, pixeltype text, onerastuserfunc regprocedure, VARIADIC args text[]) IS 'args: rast, pixeltype, onerasteruserfunc, VARIADIC args - 1 band version - Creates a new one band raster formed by applying a valid PostgreSQL function on the input raster band and of pixeltype prodived. Band 1 is assumed if no band is specified.';


--
-- Name: st_mapalgebrafct(raster, integer, text, regprocedure, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafct(rast raster, band integer, pixeltype text, onerastuserfunc regprocedure, VARIADIC args text[]) RETURNS raster
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_mapAlgebraFct';


--
-- Name: FUNCTION st_mapalgebrafct(rast raster, band integer, pixeltype text, onerastuserfunc regprocedure, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafct(rast raster, band integer, pixeltype text, onerastuserfunc regprocedure, VARIADIC args text[]) IS 'args: rast, band, pixeltype, onerasteruserfunc, VARIADIC args - 1 band version - Creates a new one band raster formed by applying a valid PostgreSQL function on the input raster band and of pixeltype prodived. Band 1 is assumed if no band is specified.';


--
-- Name: st_mapalgebrafct(raster, raster, regprocedure, text, text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafct(rast1 raster, rast2 raster, tworastuserfunc regprocedure, pixeltype text DEFAULT NULL::text, extenttype text DEFAULT 'INTERSECTION'::text, VARIADIC userargs text[] DEFAULT NULL::text[]) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_mapalgebrafct($1, 1, $2, 1, $3, $4, $5, VARIADIC $6) $_$;


--
-- Name: FUNCTION st_mapalgebrafct(rast1 raster, rast2 raster, tworastuserfunc regprocedure, pixeltype text, extenttype text, VARIADIC userargs text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafct(rast1 raster, rast2 raster, tworastuserfunc regprocedure, pixeltype text, extenttype text, VARIADIC userargs text[]) IS 'args: rast1, rast2, tworastuserfunc, pixeltype=same_as_rast1, extenttype=INTERSECTION, VARIADIC userargs - 2 band version - Creates a new one band raster formed by applying a valid PostgreSQL function on the 2 input raster bands and of pixeltype prodived. Band 1 is assumed if no band is specified. Extent type defaults to INTERSECTION if not specified.';


--
-- Name: st_mapalgebrafct(raster, integer, raster, integer, regprocedure, text, text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafct(rast1 raster, band1 integer, rast2 raster, band2 integer, tworastuserfunc regprocedure, pixeltype text DEFAULT NULL::text, extenttype text DEFAULT 'INTERSECTION'::text, VARIADIC userargs text[] DEFAULT NULL::text[]) RETURNS raster
    LANGUAGE c STABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_mapAlgebra2';


--
-- Name: FUNCTION st_mapalgebrafct(rast1 raster, band1 integer, rast2 raster, band2 integer, tworastuserfunc regprocedure, pixeltype text, extenttype text, VARIADIC userargs text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafct(rast1 raster, band1 integer, rast2 raster, band2 integer, tworastuserfunc regprocedure, pixeltype text, extenttype text, VARIADIC userargs text[]) IS 'args: rast1, band1, rast2, band2, tworastuserfunc, pixeltype=same_as_rast1, extenttype=INTERSECTION, VARIADIC userargs - 2 band version - Creates a new one band raster formed by applying a valid PostgreSQL function on the 2 input raster bands and of pixeltype prodived. Band 1 is assumed if no band is specified. Extent type defaults to INTERSECTION if not specified.';


--
-- Name: st_mapalgebrafctngb(raster, integer, text, integer, integer, regprocedure, text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mapalgebrafctngb(rast raster, band integer, pixeltype text, ngbwidth integer, ngbheight integer, onerastngbuserfunc regprocedure, nodatamode text, VARIADIC args text[]) RETURNS raster
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_mapAlgebraFctNgb';


--
-- Name: FUNCTION st_mapalgebrafctngb(rast raster, band integer, pixeltype text, ngbwidth integer, ngbheight integer, onerastngbuserfunc regprocedure, nodatamode text, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mapalgebrafctngb(rast raster, band integer, pixeltype text, ngbwidth integer, ngbheight integer, onerastngbuserfunc regprocedure, nodatamode text, VARIADIC args text[]) IS 'args: rast, band, pixeltype, ngbwidth, ngbheight, onerastngbuserfunc, nodatamode, VARIADIC args - 1-band version: Map Algebra Nearest Neighbor using user-defined PostgreSQL function. Return a raster which values are the result of a PLPGSQL user function involving a neighborhood of values from the input raster band.';


--
-- Name: st_max4ma(double precision[], text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_max4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        _matrix float[][];
        max float;
    BEGIN
        _matrix := matrix;
        max := '-Infinity'::float;
        FOR x in array_lower(_matrix, 1)..array_upper(_matrix, 1) LOOP
            FOR y in array_lower(_matrix, 2)..array_upper(_matrix, 2) LOOP
                IF _matrix[x][y] IS NULL THEN
                    IF NOT nodatamode = 'ignore' THEN
                        _matrix[x][y] := nodatamode::float;
                    END IF;
                END IF;
                IF max < _matrix[x][y] THEN
                    max := _matrix[x][y];
                END IF;
            END LOOP;
        END LOOP;
        RETURN max;
    END;
    $$;


--
-- Name: FUNCTION st_max4ma(matrix double precision[], nodatamode text, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_max4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) IS 'args: matrix, nodatamode, VARIADIC args - Raster processing function that calculates the maximum pixel value in a neighborhood.';


--
-- Name: st_maxdistance(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_maxdistance(geom1 geometry, geom2 geometry) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT _ST_MaxDistance(ST_ConvexHull($1), ST_ConvexHull($2))$_$;


--
-- Name: FUNCTION st_maxdistance(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_maxdistance(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns the 2-dimensional largest distance between two geometries in projected units.';


--
-- Name: st_mean4ma(double precision[], text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mean4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        _matrix float[][];
        sum float;
        count float;
    BEGIN
        _matrix := matrix;
        sum := 0;
        count := 0;
        FOR x in array_lower(matrix, 1)..array_upper(matrix, 1) LOOP
            FOR y in array_lower(matrix, 2)..array_upper(matrix, 2) LOOP
                IF _matrix[x][y] IS NULL THEN
                    IF nodatamode = 'ignore' THEN
                        _matrix[x][y] := 0;
                    ELSE
                        _matrix[x][y] := nodatamode::float;
                        count := count + 1;
                    END IF;
                ELSE
                    count := count + 1;
                END IF;
                sum := sum + _matrix[x][y];
            END LOOP;
        END LOOP;
        IF count = 0 THEN
            RETURN NULL;
        END IF;
        RETURN sum / count;
    END;
    $$;


--
-- Name: FUNCTION st_mean4ma(matrix double precision[], nodatamode text, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mean4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) IS 'args: matrix, nodatamode, VARIADIC args - Raster processing function that calculates the mean pixel value in a neighborhood.';


--
-- Name: st_mem_size(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mem_size(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_mem_size';


--
-- Name: FUNCTION st_mem_size(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mem_size(geometry) IS 'args: geomA - Returns the amount of space (in bytes) the geometry takes.';


--
-- Name: st_metadata(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_metadata(rast raster, OUT upperleftx double precision, OUT upperlefty double precision, OUT width integer, OUT height integer, OUT scalex double precision, OUT scaley double precision, OUT skewx double precision, OUT skewy double precision, OUT srid integer, OUT numbands integer) RETURNS record
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_metadata';


--
-- Name: FUNCTION st_metadata(rast raster, OUT upperleftx double precision, OUT upperlefty double precision, OUT width integer, OUT height integer, OUT scalex double precision, OUT scaley double precision, OUT skewx double precision, OUT skewy double precision, OUT srid integer, OUT numbands integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_metadata(rast raster, OUT upperleftx double precision, OUT upperlefty double precision, OUT width integer, OUT height integer, OUT scalex double precision, OUT scaley double precision, OUT skewx double precision, OUT skewy double precision, OUT srid integer, OUT numbands integer) IS 'args: rast - Returns basic meta data about a raster object such as pixel size, rotation (skew), upper, lower left, etc.';


--
-- Name: st_min4ma(double precision[], text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_min4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        _matrix float[][];
        min float;
    BEGIN
        _matrix := matrix;
        min := 'Infinity'::float;
        FOR x in array_lower(_matrix, 1)..array_upper(_matrix, 1) LOOP
            FOR y in array_lower(_matrix, 2)..array_upper(_matrix, 2) LOOP
                IF _matrix[x][y] IS NULL THEN
                    IF NOT nodatamode = 'ignore' THEN
                        _matrix[x][y] := nodatamode::float;
                    END IF;
                END IF;
                IF min > _matrix[x][y] THEN
                    min := _matrix[x][y];
                END IF;
            END LOOP;
        END LOOP;
        RETURN min;
    END;
    $$;


--
-- Name: FUNCTION st_min4ma(matrix double precision[], nodatamode text, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_min4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) IS 'args: matrix, nodatamode, VARIADIC args - Raster processing function that calculates the minimum pixel value in a neighborhood.';


--
-- Name: st_minimumboundingcircle(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_minimumboundingcircle(inputgeom geometry, segs_per_quarter integer DEFAULT 48) RETURNS geometry
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
	DECLARE
	hull GEOMETRY;
	ring GEOMETRY;
	center GEOMETRY;
	radius DOUBLE PRECISION;
	dist DOUBLE PRECISION;
	d DOUBLE PRECISION;
	idx1 integer;
	idx2 integer;
	l1 GEOMETRY;
	l2 GEOMETRY;
	p1 GEOMETRY;
	p2 GEOMETRY;
	a1 DOUBLE PRECISION;
	a2 DOUBLE PRECISION;


	BEGIN

	-- First compute the ConvexHull of the geometry
	hull = ST_ConvexHull(inputgeom);
	--A point really has no MBC
	IF ST_GeometryType(hull) = 'ST_Point' THEN
		RETURN hull;
	END IF;
	-- convert the hull perimeter to a linestring so we can manipulate individual points
	--If its already a linestring force it to a closed linestring
	ring = CASE WHEN ST_GeometryType(hull) = 'ST_LineString' THEN ST_AddPoint(hull, ST_StartPoint(hull)) ELSE ST_ExteriorRing(hull) END;

	dist = 0;
	-- Brute Force - check every pair
	FOR i in 1 .. (ST_NumPoints(ring)-2)
		LOOP
			FOR j in i .. (ST_NumPoints(ring)-1)
				LOOP
				d = ST_Distance(ST_PointN(ring,i),ST_PointN(ring,j));
				-- Check the distance and update if larger
				IF (d > dist) THEN
					dist = d;
					idx1 = i;
					idx2 = j;
				END IF;
			END LOOP;
		END LOOP;

	-- We now have the diameter of the convex hull.  The following line returns it if desired.
	-- RETURN ST_MakeLine(ST_PointN(ring,idx1),ST_PointN(ring,idx2));

	-- Now for the Minimum Bounding Circle.  Since we know the two points furthest from each
	-- other, the MBC must go through those two points. Start with those points as a diameter of a circle.

	-- The radius is half the distance between them and the center is midway between them
	radius = ST_Distance(ST_PointN(ring,idx1),ST_PointN(ring,idx2)) / 2.0;
	center = ST_Line_interpolate_point(ST_MakeLine(ST_PointN(ring,idx1),ST_PointN(ring,idx2)),0.5);

	-- Loop through each vertex and check if the distance from the center to the point
	-- is greater than the current radius.
	FOR k in 1 .. (ST_NumPoints(ring)-1)
		LOOP
		IF(k <> idx1 and k <> idx2) THEN
			dist = ST_Distance(center,ST_PointN(ring,k));
			IF (dist > radius) THEN
				-- We have to expand the circle.  The new circle must pass trhough
				-- three points - the two original diameters and this point.

				-- Draw a line from the first diameter to this point
				l1 = ST_Makeline(ST_PointN(ring,idx1),ST_PointN(ring,k));
				-- Compute the midpoint
				p1 = ST_line_interpolate_point(l1,0.5);
				-- Rotate the line 90 degrees around the midpoint (perpendicular bisector)
				l1 = ST_Rotate(l1,pi()/2,p1);
				--  Compute the azimuth of the bisector
				a1 = ST_Azimuth(ST_PointN(l1,1),ST_PointN(l1,2));
				--  Extend the line in each direction the new computed distance to insure they will intersect
				l1 = ST_AddPoint(l1,ST_Makepoint(ST_X(ST_PointN(l1,2))+sin(a1)*dist,ST_Y(ST_PointN(l1,2))+cos(a1)*dist),-1);
				l1 = ST_AddPoint(l1,ST_Makepoint(ST_X(ST_PointN(l1,1))-sin(a1)*dist,ST_Y(ST_PointN(l1,1))-cos(a1)*dist),0);

				-- Repeat for the line from the point to the other diameter point
				l2 = ST_Makeline(ST_PointN(ring,idx2),ST_PointN(ring,k));
				p2 = ST_Line_interpolate_point(l2,0.5);
				l2 = ST_Rotate(l2,pi()/2,p2);
				a2 = ST_Azimuth(ST_PointN(l2,1),ST_PointN(l2,2));
				l2 = ST_AddPoint(l2,ST_Makepoint(ST_X(ST_PointN(l2,2))+sin(a2)*dist,ST_Y(ST_PointN(l2,2))+cos(a2)*dist),-1);
				l2 = ST_AddPoint(l2,ST_Makepoint(ST_X(ST_PointN(l2,1))-sin(a2)*dist,ST_Y(ST_PointN(l2,1))-cos(a2)*dist),0);

				-- The new center is the intersection of the two bisectors
				center = ST_Intersection(l1,l2);
				-- The new radius is the distance to any of the three points
				radius = ST_Distance(center,ST_PointN(ring,idx1));
			END IF;
		END IF;
		END LOOP;
	--DONE!!  Return the MBC via the buffer command
	RETURN ST_Buffer(center,radius,segs_per_quarter);

	END;
$$;


--
-- Name: FUNCTION st_minimumboundingcircle(inputgeom geometry, segs_per_quarter integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_minimumboundingcircle(inputgeom geometry, segs_per_quarter integer) IS 'args: geomA, num_segs_per_qt_circ=48 - Returns the smallest circle polygon that can fully contain a geometry. Default uses 48 segments per quarter circle.';


--
-- Name: st_minpossiblevalue(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_minpossiblevalue(pixeltype text) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_minPossibleValue';


--
-- Name: st_mlinefromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mlinefromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'MULTILINESTRING'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_mlinefromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mlinefromtext(text) IS 'args: WKT - Return a specified ST_MultiLineString value from WKT representation.';


--
-- Name: st_mlinefromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mlinefromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE
	WHEN geometrytype(ST_GeomFromText($1, $2)) = 'MULTILINESTRING'
	THEN ST_GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_mlinefromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mlinefromtext(text, integer) IS 'args: WKT, srid - Return a specified ST_MultiLineString value from WKT representation.';


--
-- Name: st_mlinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mlinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: st_mlinefromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mlinefromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'MULTILINESTRING'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: st_mpointfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'MULTIPOINT'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_mpointfromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mpointfromtext(text) IS 'args: WKT - Makes a Geometry from WKT with the given SRID. If SRID is not give, it defaults to -1.';


--
-- Name: st_mpointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'MULTIPOINT'
	THEN ST_GeomFromText($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_mpointfromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mpointfromtext(text, integer) IS 'args: WKT, srid - Makes a Geometry from WKT with the given SRID. If SRID is not give, it defaults to -1.';


--
-- Name: st_mpointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOINT'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: st_mpointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'MULTIPOINT'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: st_mpolyfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpolyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'MULTIPOLYGON'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_mpolyfromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mpolyfromtext(text) IS 'args: WKT - Makes a MultiPolygon Geometry from WKT with the given SRID. If SRID is not give, it defaults to -1.';


--
-- Name: st_mpolyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpolyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'MULTIPOLYGON'
	THEN ST_GeomFromText($1,$2)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_mpolyfromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_mpolyfromtext(text, integer) IS 'args: WKT, srid - Makes a MultiPolygon Geometry from WKT with the given SRID. If SRID is not give, it defaults to -1.';


--
-- Name: st_mpolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: st_mpolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_mpolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: st_multi(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multi(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_force_multi';


--
-- Name: FUNCTION st_multi(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_multi(geometry) IS 'args: g1 - Returns the geometry as a MULTI* geometry. If the geometry is already a MULTI*, it is returned unchanged.';


--
-- Name: st_multilinefromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multilinefromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTILINESTRING'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: st_multilinestringfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multilinestringfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MLineFromText($1)$_$;


--
-- Name: st_multilinestringfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multilinestringfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MLineFromText($1, $2)$_$;


--
-- Name: st_multipointfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MPointFromText($1)$_$;


--
-- Name: st_multipointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOINT'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: st_multipointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1,$2)) = 'MULTIPOINT'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: st_multipolyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipolyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: st_multipolyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipolyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'MULTIPOLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: st_multipolygonfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipolygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MPolyFromText($1)$_$;


--
-- Name: st_multipolygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_multipolygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_MPolyFromText($1, $2)$_$;


--
-- Name: st_ndims(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_ndims(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_ndims';


--
-- Name: FUNCTION st_ndims(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_ndims(geometry) IS 'args: g1 - Returns coordinate dimension of the geometry as a small int. Values are: 2,3 or 4.';


--
-- Name: st_node(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_node(g geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_Node';


--
-- Name: FUNCTION st_node(g geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_node(g geometry) IS 'args: geom - Node a set of linestrings.';


--
-- Name: st_npoints(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_npoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_npoints';


--
-- Name: FUNCTION st_npoints(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_npoints(geometry) IS 'args: g1 - Return the number of points (vertexes) in a geometry.';


--
-- Name: st_nrings(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_nrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_nrings';


--
-- Name: FUNCTION st_nrings(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_nrings(geometry) IS 'args: geomA - If the geometry is a polygon or multi-polygon returns the number of rings.';


--
-- Name: st_numbands(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_numbands(raster) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getNumBands';


--
-- Name: FUNCTION st_numbands(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_numbands(raster) IS 'args: rast - Returns the number of bands in the raster object.';


--
-- Name: st_numgeometries(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_numgeometries(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_numgeometries_collection';


--
-- Name: FUNCTION st_numgeometries(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_numgeometries(geometry) IS 'args: geom - If geometry is a GEOMETRYCOLLECTION (or MULTI*) return the number of geometries, for single geometries will return 1, otherwise return NULL.';


--
-- Name: st_numinteriorring(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_numinteriorring(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_numinteriorrings_polygon';


--
-- Name: FUNCTION st_numinteriorring(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_numinteriorring(geometry) IS 'args: a_polygon - Return the number of interior rings of the first polygon in the geometry. Synonym to ST_NumInteriorRings.';


--
-- Name: st_numinteriorrings(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_numinteriorrings(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_numinteriorrings_polygon';


--
-- Name: FUNCTION st_numinteriorrings(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_numinteriorrings(geometry) IS 'args: a_polygon - Return the number of interior rings of the first polygon in the geometry. This will work with both POLYGON and MULTIPOLYGON types but only looks at the first polygon. Return NULL if there is no polygon in the geometry.';


--
-- Name: st_numpatches(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_numpatches(geometry) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN ST_GeometryType($1) = 'ST_PolyhedralSurface'
	THEN ST_NumGeometries($1)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_numpatches(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_numpatches(geometry) IS 'args: g1 - Return the number of faces on a Polyhedral Surface. Will return null for non-polyhedral geometries.';


--
-- Name: st_numpoints(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_numpoints(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_numpoints_linestring';


--
-- Name: FUNCTION st_numpoints(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_numpoints(geometry) IS 'args: g1 - Return the number of points in an ST_LineString or ST_CircularString value.';


--
-- Name: st_offsetcurve(geometry, double precision, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_offsetcurve(line geometry, distance double precision, params text DEFAULT ''::text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_OffsetCurve';


--
-- Name: FUNCTION st_offsetcurve(line geometry, distance double precision, params text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_offsetcurve(line geometry, distance double precision, params text) IS 'args: line, signed_distance, style_parameters='' - Return an offset line at a given distance and side from an input line. Useful for computing parallel lines about a center line';


--
-- Name: st_orderingequals(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_orderingequals(geometrya geometry, geometryb geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ 
	SELECT $1 ~= $2 AND _ST_OrderingEquals($1, $2)
	$_$;


--
-- Name: FUNCTION st_orderingequals(geometrya geometry, geometryb geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_orderingequals(geometrya geometry, geometryb geometry) IS 'args: A, B - Returns true if the given geometries represent the same geometry and points are in the same directional order.';


--
-- Name: st_overlaps(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_overlaps(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Overlaps($1,$2)$_$;


--
-- Name: FUNCTION st_overlaps(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_overlaps(geom1 geometry, geom2 geometry) IS 'args: A, B - Returns TRUE if the Geometries share space, are of the same dimension, but are not completely contained by each other.';


--
-- Name: st_patchn(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_patchn(geometry, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN ST_GeometryType($1) = 'ST_PolyhedralSurface'
	THEN ST_GeometryN($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_patchn(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_patchn(geometry, integer) IS 'args: geomA, n - Return the 1-based Nth geometry (face) if the geometry is a POLYHEDRALSURFACE, POLYHEDRALSURFACEM. Otherwise, return NULL.';


--
-- Name: st_perimeter(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_perimeter(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_perimeter2d_poly';


--
-- Name: FUNCTION st_perimeter(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_perimeter(geometry) IS 'args: g1 - Return the length measurement of the boundary of an ST_Surface or ST_MultiSurface geometry or geography. (Polygon, Multipolygon). geometry measurement is in units of spatial reference and geography is in meters.';


--
-- Name: st_perimeter(geography, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_perimeter(geog geography, use_spheroid boolean DEFAULT true) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'geography_perimeter';


--
-- Name: FUNCTION st_perimeter(geog geography, use_spheroid boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_perimeter(geog geography, use_spheroid boolean) IS 'args: geog, use_spheroid=true - Return the length measurement of the boundary of an ST_Surface or ST_MultiSurface geometry or geography. (Polygon, Multipolygon). geometry measurement is in units of spatial reference and geography is in meters.';


--
-- Name: st_perimeter2d(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_perimeter2d(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_perimeter2d_poly';


--
-- Name: FUNCTION st_perimeter2d(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_perimeter2d(geometry) IS 'args: geomA - Returns the 2-dimensional perimeter of the geometry, if it is a polygon or multi-polygon. This is currently an alias for ST_Perimeter.';


--
-- Name: st_pixelaspolygon(raster, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pixelaspolygon(rast raster, x integer, y integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getPixelPolygon';


--
-- Name: FUNCTION st_pixelaspolygon(rast raster, x integer, y integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_pixelaspolygon(rast raster, x integer, y integer) IS 'args: rast, columnx, rowy - Returns the geometry that bounds the pixel for a particular row and column.';


--
-- Name: st_pixelaspolygons(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pixelaspolygons(rast raster, band integer DEFAULT 1, OUT geom geometry, OUT val double precision, OUT x integer, OUT y integer) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        rast alias for $1;
        var_w integer;
        var_h integer;
        var_x integer;
        var_y integer;
        value float8 := NULL;
        hasband boolean := TRUE;
    BEGIN
        IF rast IS NOT NULL AND NOT ST_IsEmpty(rast) THEN
            IF ST_HasNoBand(rast, band) THEN
                RAISE NOTICE 'Raster do not have band %. Returning null values', band;
                hasband := false;
            END IF;
            SELECT ST_Width(rast), ST_Height(rast) INTO var_w, var_h;
            FOR var_x IN 1..var_w LOOP
                FOR var_y IN 1..var_h LOOP
                    IF hasband THEN
                        value := ST_Value(rast, band, var_x, var_y);
                    END IF;
                    SELECT ST_PixelAsPolygon(rast, var_x, var_y), value, var_x, var_y INTO geom,val,x,y;
                    RETURN NEXT;
                END LOOP;
            END LOOP;
        END IF;
        RETURN;
    END;
    $_$;


--
-- Name: FUNCTION st_pixelaspolygons(rast raster, band integer, OUT geom geometry, OUT val double precision, OUT x integer, OUT y integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_pixelaspolygons(rast raster, band integer, OUT geom geometry, OUT val double precision, OUT x integer, OUT y integer) IS 'args: rast, band=1 - Returns the geometry that bounds every pixel of a raster band along with the value, the X and the Y raster coordinates of each pixel.';


--
-- Name: st_pixelheight(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pixelheight(raster) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getPixelHeight';


--
-- Name: FUNCTION st_pixelheight(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_pixelheight(raster) IS 'args: rast - Returns the pixel height in geometric units of the spatial reference system.';


--
-- Name: st_pixelwidth(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pixelwidth(raster) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getPixelWidth';


--
-- Name: FUNCTION st_pixelwidth(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_pixelwidth(raster) IS 'args: rast - Returns the pixel width in geometric units of the spatial reference system.';


--
-- Name: st_point(double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_point(double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_makepoint';


--
-- Name: FUNCTION st_point(double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_point(double precision, double precision) IS 'args: x_lon, y_lat - Returns an ST_Point with the given coordinate values. OGC alias for ST_MakePoint.';


--
-- Name: st_point_inside_circle(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_point_inside_circle(geometry, double precision, double precision, double precision) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_inside_circle_point';


--
-- Name: FUNCTION st_point_inside_circle(geometry, double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_point_inside_circle(geometry, double precision, double precision, double precision) IS 'args: a_point, center_x, center_y, radius - Is the point geometry insert circle defined by center_x, center_y, radius';


--
-- Name: st_pointfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'POINT'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_pointfromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_pointfromtext(text) IS 'args: WKT - Makes a point Geometry from WKT with the given SRID. If SRID is not given, it defaults to unknown.';


--
-- Name: st_pointfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'POINT'
	THEN ST_GeomFromText($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: FUNCTION st_pointfromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_pointfromtext(text, integer) IS 'args: WKT, srid - Makes a point Geometry from WKT with the given SRID. If SRID is not given, it defaults to unknown.';


--
-- Name: st_pointfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'POINT'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: st_pointfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'POINT'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: st_pointn(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointn(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_pointn_linestring';


--
-- Name: FUNCTION st_pointn(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_pointn(geometry, integer) IS 'args: a_linestring, n - Return the Nth point in the first linestring or circular linestring in the geometry. Return NULL if there is no linestring in the geometry.';


--
-- Name: st_pointonsurface(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_pointonsurface(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'pointonsurface';


--
-- Name: FUNCTION st_pointonsurface(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_pointonsurface(geometry) IS 'args: g1 - Returns a POINT guaranteed to lie on the surface.';


--
-- Name: st_polyfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polyfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1)) = 'POLYGON'
	THEN ST_GeomFromText($1)
	ELSE NULL END
	$_$;


--
-- Name: st_polyfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polyfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromText($1, $2)) = 'POLYGON'
	THEN ST_GeomFromText($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: st_polyfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polyfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'POLYGON'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: st_polyfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polyfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1, $2)) = 'POLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: st_polygon(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygon(geometry, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ 
	SELECT ST_SetSRID(ST_MakePolygon($1), $2)
	$_$;


--
-- Name: FUNCTION st_polygon(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_polygon(geometry, integer) IS 'args: aLineString, srid - Returns a polygon built from the specified linestring and SRID.';


--
-- Name: st_polygon(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygon(rast raster, band integer DEFAULT 1) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
    SELECT st_union(f.geom) AS singlegeom
    FROM (SELECT (st_dumpaspolygons($1, $2)).geom AS geom) AS f;
    $_$;


--
-- Name: FUNCTION st_polygon(rast raster, band integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_polygon(rast raster, band integer) IS 'args: rast, band_num=1 - Returns a polygon geometry formed by the union of pixels that have a pixel value that is not no data value. If no band number is specified, band num defaults to 1.';


--
-- Name: st_polygonfromtext(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonfromtext(text) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_PolyFromText($1)$_$;


--
-- Name: FUNCTION st_polygonfromtext(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_polygonfromtext(text) IS 'args: WKT - Makes a Geometry from WKT with the given SRID. If SRID is not give, it defaults to -1.';


--
-- Name: st_polygonfromtext(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonfromtext(text, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_PolyFromText($1, $2)$_$;


--
-- Name: FUNCTION st_polygonfromtext(text, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_polygonfromtext(text, integer) IS 'args: WKT, srid - Makes a Geometry from WKT with the given SRID. If SRID is not give, it defaults to -1.';


--
-- Name: st_polygonfromwkb(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonfromwkb(bytea) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1)) = 'POLYGON'
	THEN ST_GeomFromWKB($1)
	ELSE NULL END
	$_$;


--
-- Name: st_polygonfromwkb(bytea, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonfromwkb(bytea, integer) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	SELECT CASE WHEN geometrytype(ST_GeomFromWKB($1,$2)) = 'POLYGON'
	THEN ST_GeomFromWKB($1, $2)
	ELSE NULL END
	$_$;


--
-- Name: st_polygonize(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_polygonize(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'polygonize_garray';


--
-- Name: FUNCTION st_polygonize(geometry[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_polygonize(geometry[]) IS 'args: geom_array - Aggregate. Creates a GeometryCollection containing possible polygons formed from the constituent linework of a set of geometries.';


--
-- Name: st_project(geography, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_project(geog geography, distance double precision, azimuth double precision) RETURNS geography
    LANGUAGE c IMMUTABLE COST 100
    AS '$libdir/postgis-2.0', 'geography_project';


--
-- Name: FUNCTION st_project(geog geography, distance double precision, azimuth double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_project(geog geography, distance double precision, azimuth double precision) IS 'args: g1, distance, azimuth - Returns a POINT projected from a start point using a bearing and distance.';


--
-- Name: st_quantile(raster, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rast raster, quantiles double precision[]) RETURNS SETOF quantile
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_quantile($1, 1, TRUE, 1, $2) $_$;


--
-- Name: FUNCTION st_quantile(rast raster, quantiles double precision[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_quantile(rast raster, quantiles double precision[]) IS 'args: rast, quantiles - Compute quantiles for a raster or raster table coverage in the context of the sample or population. Thus, a value could be examined to be at the rasters 25%, 50%, 75% percentile.';


--
-- Name: st_quantile(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rast raster, quantile double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_quantile($1, 1, TRUE, 1, ARRAY[$2]::double precision[])).value $_$;


--
-- Name: FUNCTION st_quantile(rast raster, quantile double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_quantile(rast raster, quantile double precision) IS 'args: rast, quantile - Compute quantiles for a raster or raster table coverage in the context of the sample or population. Thus, a value could be examined to be at the rasters 25%, 50%, 75% percentile.';


--
-- Name: st_quantile(raster, integer, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rast raster, nband integer, quantiles double precision[]) RETURNS SETOF quantile
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_quantile($1, $2, TRUE, 1, $3) $_$;


--
-- Name: FUNCTION st_quantile(rast raster, nband integer, quantiles double precision[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_quantile(rast raster, nband integer, quantiles double precision[]) IS 'args: rast, nband, quantiles - Compute quantiles for a raster or raster table coverage in the context of the sample or population. Thus, a value could be examined to be at the rasters 25%, 50%, 75% percentile.';


--
-- Name: st_quantile(raster, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rast raster, nband integer, quantile double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_quantile($1, $2, TRUE, 1, ARRAY[$3]::double precision[])).value $_$;


--
-- Name: FUNCTION st_quantile(rast raster, nband integer, quantile double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_quantile(rast raster, nband integer, quantile double precision) IS 'args: rast, nband, quantile - Compute quantiles for a raster or raster table coverage in the context of the sample or population. Thus, a value could be examined to be at the rasters 25%, 50%, 75% percentile.';


--
-- Name: st_quantile(raster, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rast raster, exclude_nodata_value boolean, quantile double precision DEFAULT NULL::double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT (_st_quantile($1, 1, $2, 1, ARRAY[$3]::double precision[])).value $_$;


--
-- Name: FUNCTION st_quantile(rast raster, exclude_nodata_value boolean, quantile double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_quantile(rast raster, exclude_nodata_value boolean, quantile double precision) IS 'args: rast, exclude_nodata_value, quantile=NULL - Compute quantiles for a raster or raster table coverage in the context of the sample or population. Thus, a value could be examined to be at the rasters 25%, 50%, 75% percentile.';


--
-- Name: st_quantile(text, text, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rastertable text, rastercolumn text, quantiles double precision[]) RETURNS SETOF quantile
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_quantile($1, $2, 1, TRUE, 1, $3) $_$;


--
-- Name: st_quantile(text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rastertable text, rastercolumn text, quantile double precision) RETURNS double precision
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_quantile($1, $2, 1, TRUE, 1, ARRAY[$3]::double precision[])).value $_$;


--
-- Name: st_quantile(raster, integer, boolean, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, quantiles double precision[] DEFAULT NULL::double precision[]) RETURNS SETOF quantile
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT _st_quantile($1, $2, $3, 1, $4) $_$;


--
-- Name: FUNCTION st_quantile(rast raster, nband integer, exclude_nodata_value boolean, quantiles double precision[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_quantile(rast raster, nband integer, exclude_nodata_value boolean, quantiles double precision[]) IS 'args: rast, nband=1, exclude_nodata_value=true, quantiles=NULL - Compute quantiles for a raster or raster table coverage in the context of the sample or population. Thus, a value could be examined to be at the rasters 25%, 50%, 75% percentile.';


--
-- Name: st_quantile(raster, integer, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rast raster, nband integer, exclude_nodata_value boolean, quantile double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_quantile($1, $2, $3, 1, ARRAY[$4]::double precision[])).value $_$;


--
-- Name: FUNCTION st_quantile(rast raster, nband integer, exclude_nodata_value boolean, quantile double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_quantile(rast raster, nband integer, exclude_nodata_value boolean, quantile double precision) IS 'args: rast, nband, exclude_nodata_value, quantile - Compute quantiles for a raster or raster table coverage in the context of the sample or population. Thus, a value could be examined to be at the rasters 25%, 50%, 75% percentile.';


--
-- Name: st_quantile(text, text, integer, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rastertable text, rastercolumn text, nband integer, quantiles double precision[]) RETURNS SETOF quantile
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_quantile($1, $2, $3, TRUE, 1, $4) $_$;


--
-- Name: FUNCTION st_quantile(rastertable text, rastercolumn text, nband integer, quantiles double precision[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_quantile(rastertable text, rastercolumn text, nband integer, quantiles double precision[]) IS 'args: rastertable, rastercolumn, nband, quantiles - Compute quantiles for a raster or raster table coverage in the context of the sample or population. Thus, a value could be examined to be at the rasters 25%, 50%, 75% percentile.';


--
-- Name: st_quantile(text, text, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rastertable text, rastercolumn text, nband integer, quantile double precision) RETURNS double precision
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_quantile($1, $2, $3, TRUE, 1, ARRAY[$4]::double precision[])).value $_$;


--
-- Name: st_quantile(text, text, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rastertable text, rastercolumn text, exclude_nodata_value boolean, quantile double precision DEFAULT NULL::double precision) RETURNS double precision
    LANGUAGE sql STABLE
    AS $_$ SELECT (_st_quantile($1, $2, 1, $3, 1, ARRAY[$4]::double precision[])).value $_$;


--
-- Name: st_quantile(text, text, integer, boolean, double precision[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, quantiles double precision[] DEFAULT NULL::double precision[]) RETURNS SETOF quantile
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_quantile($1, $2, $3, $4, 1, $5) $_$;


--
-- Name: FUNCTION st_quantile(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, quantiles double precision[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_quantile(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, quantiles double precision[]) IS 'args: rastertable, rastercolumn, nband=1, exclude_nodata_value=true, quantiles=NULL - Compute quantiles for a raster or raster table coverage in the context of the sample or population. Thus, a value could be examined to be at the rasters 25%, 50%, 75% percentile.';


--
-- Name: st_quantile(text, text, integer, boolean, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_quantile(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, quantile double precision) RETURNS double precision
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_quantile($1, $2, $3, $4, 1, ARRAY[$5]::double precision[])).value $_$;


--
-- Name: st_range4ma(double precision[], text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_range4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        _matrix float[][];
        min float;
        max float;
    BEGIN
        _matrix := matrix;
        min := 'Infinity'::float;
        max := '-Infinity'::float;
        FOR x in array_lower(matrix, 1)..array_upper(matrix, 1) LOOP
            FOR y in array_lower(matrix, 2)..array_upper(matrix, 2) LOOP
                IF _matrix[x][y] IS NULL THEN
                    IF NOT nodatamode = 'ignore' THEN
                        _matrix[x][y] := nodatamode::float;
                    END IF;
                END IF;
                IF min > _matrix[x][y] THEN
                    min = _matrix[x][y];
                END IF;
                IF max < _matrix[x][y] THEN
                    max = _matrix[x][y];
                END IF;
            END LOOP;
        END LOOP;
        IF max = '-Infinity'::float OR min = 'Infinity'::float THEN
            RETURN NULL;
        END IF;
        RETURN max - min;
    END;
    $$;


--
-- Name: FUNCTION st_range4ma(matrix double precision[], nodatamode text, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_range4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) IS 'args: matrix, nodatamode, VARIADIC args - Raster processing function that calculates the range of pixel values in a neighborhood.';


--
-- Name: st_raster2worldcoordx(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_raster2worldcoordx(rast raster, xr integer) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT longitude FROM _st_raster2worldcoord($1, $2, NULL) $_$;


--
-- Name: FUNCTION st_raster2worldcoordx(rast raster, xr integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_raster2worldcoordx(rast raster, xr integer) IS 'args: rast, xcolumn - Returns the geometric X coordinate upper left of a raster, column and row. Numbering of columns and rows starts at 1.';


--
-- Name: st_raster2worldcoordx(raster, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_raster2worldcoordx(rast raster, xr integer, yr integer) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT longitude FROM _st_raster2worldcoord($1, $2, $3) $_$;


--
-- Name: FUNCTION st_raster2worldcoordx(rast raster, xr integer, yr integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_raster2worldcoordx(rast raster, xr integer, yr integer) IS 'args: rast, xcolumn, yrow - Returns the geometric X coordinate upper left of a raster, column and row. Numbering of columns and rows starts at 1.';


--
-- Name: st_raster2worldcoordy(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_raster2worldcoordy(rast raster, yr integer) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT latitude FROM _st_raster2worldcoord($1, NULL, $2) $_$;


--
-- Name: FUNCTION st_raster2worldcoordy(rast raster, yr integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_raster2worldcoordy(rast raster, yr integer) IS 'args: rast, yrow - Returns the geometric Y coordinate upper left corner of a raster, column and row. Numbering of columns and rows starts at 1.';


--
-- Name: st_raster2worldcoordy(raster, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_raster2worldcoordy(rast raster, xr integer, yr integer) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT latitude FROM _st_raster2worldcoord($1, $2, $3) $_$;


--
-- Name: FUNCTION st_raster2worldcoordy(rast raster, xr integer, yr integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_raster2worldcoordy(rast raster, xr integer, yr integer) IS 'args: rast, xcolumn, yrow - Returns the geometric Y coordinate upper left corner of a raster, column and row. Numbering of columns and rows starts at 1.';


--
-- Name: st_reclass(raster, reclassarg[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_reclass(rast raster, VARIADIC reclassargset reclassarg[]) RETURNS raster
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
	DECLARE
		i int;
		expr text;
	BEGIN
		-- for each reclassarg, validate elements as all except nodataval cannot be NULL
		FOR i IN SELECT * FROM generate_subscripts($2, 1) LOOP
			IF $2[i].nband IS NULL OR $2[i].reclassexpr IS NULL OR $2[i].pixeltype IS NULL THEN
				RAISE WARNING 'Values are required for the nband, reclassexpr and pixeltype attributes.';
				RETURN rast;
			END IF;
		END LOOP;

		RETURN _st_reclass($1, VARIADIC $2);
	END;
	$_$;


--
-- Name: FUNCTION st_reclass(rast raster, VARIADIC reclassargset reclassarg[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_reclass(rast raster, VARIADIC reclassargset reclassarg[]) IS 'args: rast, VARIADIC reclassargset - Creates a new raster composed of band types reclassified from original. The nband is the band to be changed. If nband is not specified assumed to be 1. All other bands are returned unchanged. Use case: convert a 16BUI band to a 8BUI and so forth for simpler rendering as viewable formats.';


--
-- Name: st_reclass(raster, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_reclass(rast raster, reclassexpr text, pixeltype text) RETURNS raster
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT st_reclass($1, ROW(1, $2, $3, NULL)) $_$;


--
-- Name: FUNCTION st_reclass(rast raster, reclassexpr text, pixeltype text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_reclass(rast raster, reclassexpr text, pixeltype text) IS 'args: rast, reclassexpr, pixeltype - Creates a new raster composed of band types reclassified from original. The nband is the band to be changed. If nband is not specified assumed to be 1. All other bands are returned unchanged. Use case: convert a 16BUI band to a 8BUI and so forth for simpler rendering as viewable formats.';


--
-- Name: st_reclass(raster, integer, text, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_reclass(rast raster, nband integer, reclassexpr text, pixeltype text, nodataval double precision DEFAULT NULL::double precision) RETURNS raster
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT st_reclass($1, ROW($2, $3, $4, $5)) $_$;


--
-- Name: FUNCTION st_reclass(rast raster, nband integer, reclassexpr text, pixeltype text, nodataval double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_reclass(rast raster, nband integer, reclassexpr text, pixeltype text, nodataval double precision) IS 'args: rast, nband, reclassexpr, pixeltype, nodataval=NULL - Creates a new raster composed of band types reclassified from original. The nband is the band to be changed. If nband is not specified assumed to be 1. All other bands are returned unchanged. Use case: convert a 16BUI band to a 8BUI and so forth for simpler rendering as viewable formats.';


--
-- Name: st_relate(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_relate(geom1 geometry, geom2 geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'relate_full';


--
-- Name: FUNCTION st_relate(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_relate(geom1 geometry, geom2 geometry) IS 'args: geomA, geomB - Returns true if this Geometry is spatially related to anotherGeometry, by testing for intersections between the Interior, Boundary and Exterior of the two geometries as specified by the values in the intersectionMatrixPattern. If no intersectionMatrixPattern is passed in, then returns the maximum intersectionMatrixPattern that relates the 2 geometries.';


--
-- Name: st_relate(geometry, geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_relate(geom1 geometry, geom2 geometry, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'relate_full';


--
-- Name: FUNCTION st_relate(geom1 geometry, geom2 geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_relate(geom1 geometry, geom2 geometry, integer) IS 'args: geomA, geomB, BoundaryNodeRule - Returns true if this Geometry is spatially related to anotherGeometry, by testing for intersections between the Interior, Boundary and Exterior of the two geometries as specified by the values in the intersectionMatrixPattern. If no intersectionMatrixPattern is passed in, then returns the maximum intersectionMatrixPattern that relates the 2 geometries.';


--
-- Name: st_relate(geometry, geometry, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_relate(geom1 geometry, geom2 geometry, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'relate_pattern';


--
-- Name: FUNCTION st_relate(geom1 geometry, geom2 geometry, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_relate(geom1 geometry, geom2 geometry, text) IS 'args: geomA, geomB, intersectionMatrixPattern - Returns true if this Geometry is spatially related to anotherGeometry, by testing for intersections between the Interior, Boundary and Exterior of the two geometries as specified by the values in the intersectionMatrixPattern. If no intersectionMatrixPattern is passed in, then returns the maximum intersectionMatrixPattern that relates the 2 geometries.';


--
-- Name: st_relatematch(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_relatematch(text, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_RelateMatch';


--
-- Name: FUNCTION st_relatematch(text, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_relatematch(text, text) IS 'args: intersectionMatrix, intersectionMatrixPattern - Returns true if intersectionMattrixPattern1 implies intersectionMatrixPattern2';


--
-- Name: st_removepoint(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_removepoint(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_removepoint';


--
-- Name: FUNCTION st_removepoint(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_removepoint(geometry, integer) IS 'args: linestring, offset - Removes point from a linestring. Offset is 0-based.';


--
-- Name: st_removerepeatedpoints(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_removerepeatedpoints(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_RemoveRepeatedPoints';


--
-- Name: FUNCTION st_removerepeatedpoints(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_removerepeatedpoints(geometry) IS 'args: geom - Returns a version of the given geometry with duplicated points removed.';


--
-- Name: st_resample(raster, raster, text, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_resample(rast raster, ref raster, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125, usescale boolean DEFAULT true) RETURNS raster
    LANGUAGE plpgsql STABLE STRICT
    AS $_$
	DECLARE
		sr_id int;
		dim_x int;
		dim_y int;
		scale_x double precision;
		scale_y double precision;
		grid_x double precision;
		grid_y double precision;
		skew_x double precision;
		skew_y double precision;
	BEGIN
		SELECT srid, width, height, scalex, scaley, upperleftx, upperlefty, skewx, skewy INTO sr_id, dim_x, dim_y, scale_x, scale_y, grid_x, grid_y, skew_x, skew_y FROM st_metadata($2);

		IF usescale IS TRUE THEN
			dim_x := NULL;
			dim_y := NULL;
		ELSE
			scale_x := NULL;
			scale_y := NULL;
		END IF;

		RETURN _st_resample($1, $3, $4, sr_id, scale_x, scale_y, grid_x, grid_y, skew_x, skew_y, dim_x, dim_y);
	END;
	$_$;


--
-- Name: FUNCTION st_resample(rast raster, ref raster, algorithm text, maxerr double precision, usescale boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_resample(rast raster, ref raster, algorithm text, maxerr double precision, usescale boolean) IS 'args: rast, ref, algorithm=NearestNeighbour, maxerr=0.125, usescale=true - Resample a raster using a specified resampling algorithm, new dimensions, an arbitrary grid corner and a set of raster georeferencing attributes defined or borrowed from another raster. New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_resample(raster, raster, boolean, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_resample(rast raster, ref raster, usescale boolean, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT st_resample($1, $2, $4, $5, $3) $_$;


--
-- Name: FUNCTION st_resample(rast raster, ref raster, usescale boolean, algorithm text, maxerr double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_resample(rast raster, ref raster, usescale boolean, algorithm text, maxerr double precision) IS 'args: rast, ref, usescale, algorithm=NearestNeighbour, maxerr=0.125 - Resample a raster using a specified resampling algorithm, new dimensions, an arbitrary grid corner and a set of raster georeferencing attributes defined or borrowed from another raster. New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_resample(raster, integer, double precision, double precision, double precision, double precision, double precision, double precision, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_resample(rast raster, srid integer DEFAULT NULL::integer, scalex double precision DEFAULT 0, scaley double precision DEFAULT 0, gridx double precision DEFAULT NULL::double precision, gridy double precision DEFAULT NULL::double precision, skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_resample($1, $9,	$10, $2, $3, $4, $5, $6, $7, $8) $_$;


--
-- Name: FUNCTION st_resample(rast raster, srid integer, scalex double precision, scaley double precision, gridx double precision, gridy double precision, skewx double precision, skewy double precision, algorithm text, maxerr double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_resample(rast raster, srid integer, scalex double precision, scaley double precision, gridx double precision, gridy double precision, skewx double precision, skewy double precision, algorithm text, maxerr double precision) IS 'args: rast, srid=NULL, scalex=0, scaley=0, gridx=NULL, gridy=NULL, skewx=0, skewy=0, algorithm=NearestNeighbor, maxerr=0.125 - Resample a raster using a specified resampling algorithm, new dimensions, an arbitrary grid corner and a set of raster georeferencing attributes defined or borrowed from another raster. New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_resample(raster, integer, integer, integer, double precision, double precision, double precision, double precision, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_resample(rast raster, width integer, height integer, srid integer DEFAULT NULL::integer, gridx double precision DEFAULT NULL::double precision, gridy double precision DEFAULT NULL::double precision, skewx double precision DEFAULT 0, skewy double precision DEFAULT 0, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT _st_resample($1, $9,	$10, $4, NULL, NULL, $5, $6, $7, $8, $2, $3) $_$;


--
-- Name: FUNCTION st_resample(rast raster, width integer, height integer, srid integer, gridx double precision, gridy double precision, skewx double precision, skewy double precision, algorithm text, maxerr double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_resample(rast raster, width integer, height integer, srid integer, gridx double precision, gridy double precision, skewx double precision, skewy double precision, algorithm text, maxerr double precision) IS 'args: rast, width, height, srid=same_as_rast, gridx=NULL, gridy=NULL, skewx=0, skewy=0, algorithm=NearestNeighbour, maxerr=0.125 - Resample a raster using a specified resampling algorithm, new dimensions, an arbitrary grid corner and a set of raster georeferencing attributes defined or borrowed from another raster. New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_rescale(raster, double precision, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rescale(rast raster, scalexy double precision, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_resample($1, $3, $4, NULL, $2, $2) $_$;


--
-- Name: FUNCTION st_rescale(rast raster, scalexy double precision, algorithm text, maxerr double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_rescale(rast raster, scalexy double precision, algorithm text, maxerr double precision) IS 'args: rast, scalexy, algorithm=NearestNeighbour, maxerr=0.125 - Resample a raster by adjusting only its scale (or pixel size). New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_rescale(raster, double precision, double precision, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rescale(rast raster, scalex double precision, scaley double precision, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_resample($1, $4, $5, NULL, $2, $3) $_$;


--
-- Name: FUNCTION st_rescale(rast raster, scalex double precision, scaley double precision, algorithm text, maxerr double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_rescale(rast raster, scalex double precision, scaley double precision, algorithm text, maxerr double precision) IS 'args: rast, scalex, scaley, algorithm=NearestNeighbour, maxerr=0.125 - Resample a raster by adjusting only its scale (or pixel size). New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_reskew(raster, double precision, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_reskew(rast raster, skewxy double precision, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_resample($1, $3, $4, NULL, 0, 0, NULL, NULL, $2, $2) $_$;


--
-- Name: FUNCTION st_reskew(rast raster, skewxy double precision, algorithm text, maxerr double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_reskew(rast raster, skewxy double precision, algorithm text, maxerr double precision) IS 'args: rast, skewxy, algorithm=NearestNeighbour, maxerr=0.125 - Resample a raster by adjusting only its skew (or rotation parameters). New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_reskew(raster, double precision, double precision, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_reskew(rast raster, skewx double precision, skewy double precision, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_resample($1, $4, $5, NULL, 0, 0, NULL, NULL, $2, $3) $_$;


--
-- Name: FUNCTION st_reskew(rast raster, skewx double precision, skewy double precision, algorithm text, maxerr double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_reskew(rast raster, skewx double precision, skewy double precision, algorithm text, maxerr double precision) IS 'args: rast, skewx, skewy, algorithm=NearestNeighbour, maxerr=0.125 - Resample a raster by adjusting only its skew (or rotation parameters). New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_reverse(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_reverse(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_reverse';


--
-- Name: FUNCTION st_reverse(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_reverse(geometry) IS 'args: g1 - Returns the geometry with vertex order reversed.';


--
-- Name: st_rotate(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotate(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Affine($1,  cos($2), -sin($2), 0,  sin($2), cos($2), 0,  0, 0, 1,  0, 0, 0)$_$;


--
-- Name: FUNCTION st_rotate(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_rotate(geometry, double precision) IS 'args: geomA, rotRadians - Rotate a geometry rotRadians counter-clockwise about an origin.';


--
-- Name: st_rotate(geometry, double precision, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotate(geometry, double precision, geometry) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Affine($1,  cos($2), -sin($2), 0,  sin($2),  cos($2), 0, 0, 0, 1, ST_X($3) - cos($2) * ST_X($3) + sin($2) * ST_Y($3), ST_Y($3) - sin($2) * ST_X($3) - cos($2) * ST_Y($3), 0)$_$;


--
-- Name: FUNCTION st_rotate(geometry, double precision, geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_rotate(geometry, double precision, geometry) IS 'args: geomA, rotRadians, pointOrigin - Rotate a geometry rotRadians counter-clockwise about an origin.';


--
-- Name: st_rotate(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotate(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Affine($1,  cos($2), -sin($2), 0,  sin($2),  cos($2), 0, 0, 0, 1,	$3 - cos($2) * $3 + sin($2) * $4, $4 - sin($2) * $3 - cos($2) * $4, 0)$_$;


--
-- Name: FUNCTION st_rotate(geometry, double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_rotate(geometry, double precision, double precision, double precision) IS 'args: geomA, rotRadians, x0, y0 - Rotate a geometry rotRadians counter-clockwise about an origin.';


--
-- Name: st_rotatex(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotatex(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Affine($1, 1, 0, 0, 0, cos($2), -sin($2), 0, sin($2), cos($2), 0, 0, 0)$_$;


--
-- Name: FUNCTION st_rotatex(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_rotatex(geometry, double precision) IS 'args: geomA, rotRadians - Rotate a geometry rotRadians about the X axis.';


--
-- Name: st_rotatey(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotatey(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Affine($1,  cos($2), 0, sin($2),  0, 1, 0,  -sin($2), 0, cos($2), 0,  0, 0)$_$;


--
-- Name: FUNCTION st_rotatey(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_rotatey(geometry, double precision) IS 'args: geomA, rotRadians - Rotate a geometry rotRadians about the Y axis.';


--
-- Name: st_rotatez(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotatez(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Rotate($1, $2)$_$;


--
-- Name: FUNCTION st_rotatez(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_rotatez(geometry, double precision) IS 'args: geomA, rotRadians - Rotate a geometry rotRadians about the Z axis.';


--
-- Name: st_rotation(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_rotation(raster) RETURNS double precision
    LANGUAGE sql
    AS $_$ SELECT (ST_Geotransform($1)).theta_i $_$;


--
-- Name: FUNCTION st_rotation(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_rotation(raster) IS 'args: rast - Returns the rotation of the raster in radian.';


--
-- Name: st_samealignment(raster, raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_samealignment(rast1 raster, rast2 raster) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_sameAlignment';


--
-- Name: FUNCTION st_samealignment(rast1 raster, rast2 raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_samealignment(rast1 raster, rast2 raster) IS 'args: rastA, rastB - Returns true if rasters have same skew, scale, spatial ref and false if they dont with notice detailing issue.';


--
-- Name: st_samealignment(double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_samealignment(ulx1 double precision, uly1 double precision, scalex1 double precision, scaley1 double precision, skewx1 double precision, skewy1 double precision, ulx2 double precision, uly2 double precision, scalex2 double precision, scaley2 double precision, skewx2 double precision, skewy2 double precision) RETURNS boolean
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT st_samealignment(st_makeemptyraster(1, 1, $1, $2, $3, $4, $5, $6), st_makeemptyraster(1, 1, $7, $8, $9, $10, $11, $12)) $_$;


--
-- Name: FUNCTION st_samealignment(ulx1 double precision, uly1 double precision, scalex1 double precision, scaley1 double precision, skewx1 double precision, skewy1 double precision, ulx2 double precision, uly2 double precision, scalex2 double precision, scaley2 double precision, skewx2 double precision, skewy2 double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_samealignment(ulx1 double precision, uly1 double precision, scalex1 double precision, scaley1 double precision, skewx1 double precision, skewy1 double precision, ulx2 double precision, uly2 double precision, scalex2 double precision, scaley2 double precision, skewx2 double precision, skewy2 double precision) IS 'args: ulx1, uly1, scalex1, scaley1, skewx1, skewy1, ulx2, uly2, scalex2, scaley2, skewx2, skewy2 - Returns true if rasters have same skew, scale, spatial ref and false if they dont with notice detailing issue.';


--
-- Name: st_scale(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_scale(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Scale($1, $2, $3, 1)$_$;


--
-- Name: FUNCTION st_scale(geometry, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_scale(geometry, double precision, double precision) IS 'args: geomA, XFactor, YFactor - Scales the geometry to a new size by multiplying the ordinates with the parameters. Ie: ST_Scale(geom, Xfactor, Yfactor, Zfactor).';


--
-- Name: st_scale(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_scale(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Affine($1,  $2, 0, 0,  0, $3, 0,  0, 0, $4,  0, 0, 0)$_$;


--
-- Name: FUNCTION st_scale(geometry, double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_scale(geometry, double precision, double precision, double precision) IS 'args: geomA, XFactor, YFactor, ZFactor - Scales the geometry to a new size by multiplying the ordinates with the parameters. Ie: ST_Scale(geom, Xfactor, Yfactor, Zfactor).';


--
-- Name: st_scalex(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_scalex(raster) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getXScale';


--
-- Name: FUNCTION st_scalex(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_scalex(raster) IS 'args: rast - Returns the X component of the pixel width in units of coordinate reference system.';


--
-- Name: st_scaley(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_scaley(raster) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getYScale';


--
-- Name: FUNCTION st_scaley(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_scaley(raster) IS 'args: rast - Returns the Y component of the pixel height in units of coordinate reference system.';


--
-- Name: st_segmentize(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_segmentize(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_segmentize2d';


--
-- Name: FUNCTION st_segmentize(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_segmentize(geometry, double precision) IS 'args: geomA, max_length - Return a modified geometry having no segment longer than the given distance. Distance computation is performed in 2d only.';


--
-- Name: st_setbandisnodata(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setbandisnodata(rast raster, band integer DEFAULT 1) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_setBandIsNoData';


--
-- Name: FUNCTION st_setbandisnodata(rast raster, band integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setbandisnodata(rast raster, band integer) IS 'args: rast, band=1 - Sets the isnodata flag of the band to TRUE. You may want to call this function if ST_BandIsNoData(rast, band) != ST_BandIsNodata(rast, band, TRUE). This is, if the isnodata flag is dirty. Band 1 is assumed if no band is specified.';


--
-- Name: st_setbandnodatavalue(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setbandnodatavalue(rast raster, nodatavalue double precision) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_setbandnodatavalue($1, 1, $2, FALSE) $_$;


--
-- Name: FUNCTION st_setbandnodatavalue(rast raster, nodatavalue double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setbandnodatavalue(rast raster, nodatavalue double precision) IS 'args: rast, nodatavalue - Sets the value for the given band that represents no data. Band 1 is assumed if no band is specified. To mark a band as having no nodata value, set the nodata value = NULL.';


--
-- Name: st_setbandnodatavalue(raster, integer, double precision, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setbandnodatavalue(rast raster, band integer, nodatavalue double precision, forcechecking boolean DEFAULT false) RETURNS raster
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_setBandNoDataValue';


--
-- Name: FUNCTION st_setbandnodatavalue(rast raster, band integer, nodatavalue double precision, forcechecking boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setbandnodatavalue(rast raster, band integer, nodatavalue double precision, forcechecking boolean) IS 'args: rast, band, nodatavalue, forcechecking=false - Sets the value for the given band that represents no data. Band 1 is assumed if no band is specified. To mark a band as having no nodata value, set the nodata value = NULL.';


--
-- Name: st_setgeoreference(raster, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setgeoreference(rast raster, georef text, format text DEFAULT 'GDAL'::text) RETURNS raster
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
    DECLARE
        params text[];
        rastout raster;
    BEGIN
        IF rast IS NULL THEN
            RAISE WARNING 'Cannot set georeferencing on a null raster in st_setgeoreference.';
            RETURN rastout;
        END IF;

        SELECT regexp_matches(georef,
            E'(-?\\d+(?:\\.\\d+)?)\\s(-?\\d+(?:\\.\\d+)?)\\s(-?\\d+(?:\\.\\d+)?)\\s' ||
            E'(-?\\d+(?:\\.\\d+)?)\\s(-?\\d+(?:\\.\\d+)?)\\s(-?\\d+(?:\\.\\d+)?)') INTO params;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'st_setgeoreference requires a string with 6 floating point values.';
        END IF;

        IF format = 'ESRI' THEN
            -- params array is now:
            -- {scalex, skewy, skewx, scaley, upperleftx, upperlefty}
            rastout := st_setscale(rast, params[1]::float8, params[4]::float8);
            rastout := st_setskew(rastout, params[3]::float8, params[2]::float8);
            rastout := st_setupperleft(rastout,
                                   params[5]::float8 - (params[1]::float8 * 0.5),
                                   params[6]::float8 - (params[4]::float8 * 0.5));
        ELSE
            IF format != 'GDAL' THEN
                RAISE WARNING E'Format \'%\' is not recognized, defaulting to GDAL format.', format;
            END IF;
            -- params array is now:
            -- {scalex, skewy, skewx, scaley, upperleftx, upperlefty}

            rastout := st_setscale(rast, params[1]::float8, params[4]::float8);
            rastout := st_setskew( rastout, params[3]::float8, params[2]::float8);
            rastout := st_setupperleft(rastout, params[5]::float8, params[6]::float8);
        END IF;
        RETURN rastout;
    END;
    $$;


--
-- Name: FUNCTION st_setgeoreference(rast raster, georef text, format text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setgeoreference(rast raster, georef text, format text) IS 'args: rast, georefcoords, format=GDAL - Set Georeference 6 georeference parameters in a single call. Numbers should be separated by white space. Accepts inputs in GDAL or ESRI format. Default is GDAL.';


--
-- Name: st_setgeotransform(raster, double precision, double precision, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setgeotransform(rast raster, imag double precision, jmag double precision, theta_i double precision, theta_ij double precision, xoffset double precision, yoffset double precision) RETURNS raster
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_setGeotransform';


--
-- Name: st_setpoint(geometry, integer, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setpoint(geometry, integer, geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_setpoint_linestring';


--
-- Name: FUNCTION st_setpoint(geometry, integer, geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setpoint(geometry, integer, geometry) IS 'args: linestring, zerobasedposition, point - Replace point N of linestring with given point. Index is 0-based.';


--
-- Name: st_setrotation(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setrotation(rast raster, rotation double precision) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_setRotation';


--
-- Name: FUNCTION st_setrotation(rast raster, rotation double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setrotation(rast raster, rotation double precision) IS 'args: rast, rotation - Set the rotation of the raster in radian.';


--
-- Name: st_setscale(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setscale(rast raster, scale double precision) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_setScale';


--
-- Name: FUNCTION st_setscale(rast raster, scale double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setscale(rast raster, scale double precision) IS 'args: rast, xy - Sets the X and Y size of pixels in units of coordinate reference system. Number units/pixel width/height.';


--
-- Name: st_setscale(raster, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setscale(rast raster, scalex double precision, scaley double precision) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_setScaleXY';


--
-- Name: FUNCTION st_setscale(rast raster, scalex double precision, scaley double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setscale(rast raster, scalex double precision, scaley double precision) IS 'args: rast, x, y - Sets the X and Y size of pixels in units of coordinate reference system. Number units/pixel width/height.';


--
-- Name: st_setskew(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setskew(rast raster, skew double precision) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_setSkew';


--
-- Name: FUNCTION st_setskew(rast raster, skew double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setskew(rast raster, skew double precision) IS 'args: rast, skewxy - Sets the georeference X and Y skew (or rotation parameter). If only one is passed in, sets X and Y to the same value.';


--
-- Name: st_setskew(raster, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setskew(rast raster, skewx double precision, skewy double precision) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_setSkewXY';


--
-- Name: FUNCTION st_setskew(rast raster, skewx double precision, skewy double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setskew(rast raster, skewx double precision, skewy double precision) IS 'args: rast, skewx, skewy - Sets the georeference X and Y skew (or rotation parameter). If only one is passed in, sets X and Y to the same value.';


--
-- Name: st_setsrid(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setsrid(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_set_srid';


--
-- Name: FUNCTION st_setsrid(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setsrid(geometry, integer) IS 'args: geom, srid - Sets the SRID on a geometry to a particular integer value.';


--
-- Name: st_setsrid(raster, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setsrid(rast raster, srid integer) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_setSRID';


--
-- Name: FUNCTION st_setsrid(rast raster, srid integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setsrid(rast raster, srid integer) IS 'args: rast, srid - Sets the SRID of a raster to a particular integer srid defined in the spatial_ref_sys table.';


--
-- Name: st_setupperleft(raster, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setupperleft(rast raster, upperleftx double precision, upperlefty double precision) RETURNS raster
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_setUpperLeftXY';


--
-- Name: FUNCTION st_setupperleft(rast raster, upperleftx double precision, upperlefty double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setupperleft(rast raster, upperleftx double precision, upperlefty double precision) IS 'args: rast, x, y - Sets the value of the upper left corner of the pixel to projected X and Y coordinates.';


--
-- Name: st_setvalue(raster, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setvalue(rast raster, pt geometry, newvalue double precision) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_setvalue($1, 1, $2, $3) $_$;


--
-- Name: FUNCTION st_setvalue(rast raster, pt geometry, newvalue double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setvalue(rast raster, pt geometry, newvalue double precision) IS 'args: rast, pt, newvalue - Returns modified raster resulting from setting the value of a given band in a given columnx, rowy pixel or at a pixel that intersects a particular geometric point. Band numbers start at 1 and assumed to be 1 if not specified.';


--
-- Name: st_setvalue(raster, integer, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setvalue(rast raster, x integer, y integer, newvalue double precision) RETURNS raster
    LANGUAGE sql
    AS $_$ SELECT st_setvalue($1, 1, $2, $3, $4) $_$;


--
-- Name: FUNCTION st_setvalue(rast raster, x integer, y integer, newvalue double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setvalue(rast raster, x integer, y integer, newvalue double precision) IS 'args: rast, columnx, rowy, newvalue - Returns modified raster resulting from setting the value of a given band in a given columnx, rowy pixel or at a pixel that intersects a particular geometric point. Band numbers start at 1 and assumed to be 1 if not specified.';


--
-- Name: st_setvalue(raster, integer, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setvalue(rast raster, band integer, pt geometry, newvalue double precision) RETURNS raster
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        x float8;
        y float8;
        gtype text;
    BEGIN
        gtype := st_geometrytype(pt);
        IF ( gtype != 'ST_Point' ) THEN
            RAISE EXCEPTION 'Attempting to get the value of a pixel with a non-point geometry';
        END IF;
        x := st_x(pt);
        y := st_y(pt);
        RETURN st_setvalue(rast,
                           band,
                           st_world2rastercoordx(rast, x, y),
                           st_world2rastercoordy(rast, x, y),
                           newvalue);
    END;
    $$;


--
-- Name: FUNCTION st_setvalue(rast raster, band integer, pt geometry, newvalue double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setvalue(rast raster, band integer, pt geometry, newvalue double precision) IS 'args: rast, bandnum, pt, newvalue - Returns modified raster resulting from setting the value of a given band in a given columnx, rowy pixel or at a pixel that intersects a particular geometric point. Band numbers start at 1 and assumed to be 1 if not specified.';


--
-- Name: st_setvalue(raster, integer, integer, integer, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_setvalue(rast raster, band integer, x integer, y integer, newvalue double precision) RETURNS raster
    LANGUAGE c IMMUTABLE
    AS '$libdir/rtpostgis-2.0', 'RASTER_setPixelValue';


--
-- Name: FUNCTION st_setvalue(rast raster, band integer, x integer, y integer, newvalue double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_setvalue(rast raster, band integer, x integer, y integer, newvalue double precision) IS 'args: rast, bandnum, columnx, rowy, newvalue - Returns modified raster resulting from setting the value of a given band in a given columnx, rowy pixel or at a pixel that intersects a particular geometric point. Band numbers start at 1 and assumed to be 1 if not specified.';


--
-- Name: st_sharedpaths(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_sharedpaths(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_SharedPaths';


--
-- Name: FUNCTION st_sharedpaths(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_sharedpaths(geom1 geometry, geom2 geometry) IS 'args: lineal1, lineal2 - Returns a collection containing paths shared by the two input linestrings/multilinestrings.';


--
-- Name: st_shift_longitude(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_shift_longitude(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_longitude_shift';


--
-- Name: FUNCTION st_shift_longitude(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_shift_longitude(geometry) IS 'args: geomA - Reads every point/vertex in every component of every feature in a geometry, and if the longitude coordinate is <0, adds 360 to it. The result would be a 0-360 version of the data to be plotted in a 180 centric map';


--
-- Name: st_shortestline(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_shortestline(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_shortestline2d';


--
-- Name: FUNCTION st_shortestline(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_shortestline(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns the 2-dimensional shortest line between two geometries';


--
-- Name: st_simplify(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_simplify(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_simplify2d';


--
-- Name: FUNCTION st_simplify(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_simplify(geometry, double precision) IS 'args: geomA, tolerance - Returns a "simplified" version of the given geometry using the Douglas-Peucker algorithm.';


--
-- Name: st_simplifypreservetopology(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_simplifypreservetopology(geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'topologypreservesimplify';


--
-- Name: FUNCTION st_simplifypreservetopology(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_simplifypreservetopology(geometry, double precision) IS 'args: geomA, tolerance - Returns a "simplified" version of the given geometry using the Douglas-Peucker algorithm. Will avoid creating derived geometries (polygons in particular) that are invalid.';


--
-- Name: st_skewx(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_skewx(raster) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getXSkew';


--
-- Name: FUNCTION st_skewx(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_skewx(raster) IS 'args: rast - Returns the georeference X skew (or rotation parameter).';


--
-- Name: st_skewy(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_skewy(raster) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getYSkew';


--
-- Name: FUNCTION st_skewy(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_skewy(raster) IS 'args: rast - Returns the georeference Y skew (or rotation parameter).';


--
-- Name: st_slope(raster, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_slope(rast raster, band integer, pixeltype text) RETURNS raster
    LANGUAGE sql STABLE
    AS $_$ SELECT st_mapalgebrafctngb($1, $2, $3, 1, 1, '_st_slope4ma(float[][], text, text[])'::regprocedure, 'value', st_pixelwidth($1)::text, st_pixelheight($1)::text) $_$;


--
-- Name: FUNCTION st_slope(rast raster, band integer, pixeltype text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_slope(rast raster, band integer, pixeltype text) IS 'args: rast, band, pixeltype - Returns the surface slope of an elevation raster band. Useful for analyzing terrain.';


--
-- Name: st_snap(geometry, geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snap(geom1 geometry, geom2 geometry, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_Snap';


--
-- Name: FUNCTION st_snap(geom1 geometry, geom2 geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_snap(geom1 geometry, geom2 geometry, double precision) IS 'args: input, reference, tolerance - Snap segments and vertices of input geometry to vertices of a reference geometry.';


--
-- Name: st_snaptogrid(geometry, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(geometry, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SnapToGrid($1, 0, 0, $2, $2)$_$;


--
-- Name: FUNCTION st_snaptogrid(geometry, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_snaptogrid(geometry, double precision) IS 'args: geomA, size - Snap all points of the input geometry to a regular grid.';


--
-- Name: st_snaptogrid(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_SnapToGrid($1, 0, 0, $2, $3)$_$;


--
-- Name: FUNCTION st_snaptogrid(geometry, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_snaptogrid(geometry, double precision, double precision) IS 'args: geomA, sizeX, sizeY - Snap all points of the input geometry to a regular grid.';


--
-- Name: st_snaptogrid(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_snaptogrid';


--
-- Name: FUNCTION st_snaptogrid(geometry, double precision, double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_snaptogrid(geometry, double precision, double precision, double precision, double precision) IS 'args: geomA, originX, originY, sizeX, sizeY - Snap all points of the input geometry to a regular grid.';


--
-- Name: st_snaptogrid(geometry, geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(geom1 geometry, geom2 geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_snaptogrid_pointoff';


--
-- Name: FUNCTION st_snaptogrid(geom1 geometry, geom2 geometry, double precision, double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_snaptogrid(geom1 geometry, geom2 geometry, double precision, double precision, double precision, double precision) IS 'args: geomA, pointOrigin, sizeX, sizeY, sizeZ, sizeM - Snap all points of the input geometry to a regular grid.';


--
-- Name: st_snaptogrid(raster, double precision, double precision, double precision, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(rast raster, gridx double precision, gridy double precision, scalexy double precision, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_resample($1, $5, $6, NULL, $4, $4, $2, $3) $_$;


--
-- Name: FUNCTION st_snaptogrid(rast raster, gridx double precision, gridy double precision, scalexy double precision, algorithm text, maxerr double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_snaptogrid(rast raster, gridx double precision, gridy double precision, scalexy double precision, algorithm text, maxerr double precision) IS 'args: rast, gridx, gridy, scalexy, algorithm=NearestNeighbour, maxerr=0.125 - Resample a raster by snapping it to a grid. New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_snaptogrid(raster, double precision, double precision, text, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(rast raster, gridx double precision, gridy double precision, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125, scalex double precision DEFAULT 0, scaley double precision DEFAULT 0) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_resample($1, $4, $5, NULL, $6, $7, $2, $3) $_$;


--
-- Name: FUNCTION st_snaptogrid(rast raster, gridx double precision, gridy double precision, algorithm text, maxerr double precision, scalex double precision, scaley double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_snaptogrid(rast raster, gridx double precision, gridy double precision, algorithm text, maxerr double precision, scalex double precision, scaley double precision) IS 'args: rast, gridx, gridy, algorithm=NearestNeighbour, maxerr=0.125, scalex=DEFAULT 0, scaley=DEFAULT 0 - Resample a raster by snapping it to a grid. New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_snaptogrid(raster, double precision, double precision, double precision, double precision, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_snaptogrid(rast raster, gridx double precision, gridy double precision, scalex double precision, scaley double precision, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_resample($1, $6, $7, NULL, $4, $5, $2, $3) $_$;


--
-- Name: FUNCTION st_snaptogrid(rast raster, gridx double precision, gridy double precision, scalex double precision, scaley double precision, algorithm text, maxerr double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_snaptogrid(rast raster, gridx double precision, gridy double precision, scalex double precision, scaley double precision, algorithm text, maxerr double precision) IS 'args: rast, gridx, gridy, scalex, scaley, algorithm=NearestNeighbour, maxerr=0.125 - Resample a raster by snapping it to a grid. New pixel values are computed using the NearestNeighbor (english or american spelling), Bilinear, Cubic, CubicSpline or Lanczos resampling algorithm. Default is NearestNeighbor.';


--
-- Name: st_split(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_split(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT COST 100
    AS '$libdir/postgis-2.0', 'ST_Split';


--
-- Name: FUNCTION st_split(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_split(geom1 geometry, geom2 geometry) IS 'args: input, blade - Returns a collection of geometries resulting by splitting a geometry.';


--
-- Name: st_srid(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_srid(geometry) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_get_srid';


--
-- Name: FUNCTION st_srid(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_srid(geometry) IS 'args: g1 - Returns the spatial reference identifier for the ST_Geometry as defined in spatial_ref_sys table.';


--
-- Name: st_srid(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_srid(raster) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getSRID';


--
-- Name: FUNCTION st_srid(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_srid(raster) IS 'args: rast - Returns the spatial reference identifier of the raster as defined in spatial_ref_sys table.';


--
-- Name: st_startpoint(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_startpoint(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_startpoint_linestring';


--
-- Name: FUNCTION st_startpoint(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_startpoint(geometry) IS 'args: geomA - Returns the first point of a LINESTRING geometry as a POINT.';


--
-- Name: st_stddev4ma(double precision[], text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_stddev4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT stddev(unnest) FROM unnest($1) $_$;


--
-- Name: FUNCTION st_stddev4ma(matrix double precision[], nodatamode text, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_stddev4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) IS 'args: matrix, nodatamode, VARIADIC args - Raster processing function that calculates the standard deviation of pixel values in a neighborhood.';


--
-- Name: st_sum4ma(double precision[], text, text[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_sum4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    DECLARE
        _matrix float[][];
        sum float;
    BEGIN
        _matrix := matrix;
        sum := 0;
        FOR x in array_lower(matrix, 1)..array_upper(matrix, 1) LOOP
            FOR y in array_lower(matrix, 2)..array_upper(matrix, 2) LOOP
                IF _matrix[x][y] IS NULL THEN
                    IF nodatamode = 'ignore' THEN
                        _matrix[x][y] := 0;
                    ELSE
                        _matrix[x][y] := nodatamode::float;
                    END IF;
                END IF;
                sum := sum + _matrix[x][y];
            END LOOP;
        END LOOP;
        RETURN sum;
    END;
    $$;


--
-- Name: FUNCTION st_sum4ma(matrix double precision[], nodatamode text, VARIADIC args text[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_sum4ma(matrix double precision[], nodatamode text, VARIADIC args text[]) IS 'args: matrix, nodatamode, VARIADIC args - Raster processing function that calculates the sum of all pixel values in a neighborhood.';


--
-- Name: st_summary(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_summary(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_summary';


--
-- Name: FUNCTION st_summary(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_summary(geometry) IS 'args: g - Returns a text summary of the contents of the geometry.';


--
-- Name: st_summary(geography); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_summary(geography) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_summary';


--
-- Name: FUNCTION st_summary(geography); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_summary(geography) IS 'args: g - Returns a text summary of the contents of the geometry.';


--
-- Name: st_summarystats(raster, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_summarystats(rast raster, exclude_nodata_value boolean) RETURNS summarystats
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_summarystats($1, 1, $2, 1) $_$;


--
-- Name: FUNCTION st_summarystats(rast raster, exclude_nodata_value boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_summarystats(rast raster, exclude_nodata_value boolean) IS 'args: rast, exclude_nodata_value - Returns summary stats consisting of count,sum,mean,stddev,min,max for a given raster band of a raster or raster coverage. Band 1 is assumed is no band is specified.';


--
-- Name: st_summarystats(raster, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_summarystats(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true) RETURNS summarystats
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT _st_summarystats($1, $2, $3, 1) $_$;


--
-- Name: FUNCTION st_summarystats(rast raster, nband integer, exclude_nodata_value boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_summarystats(rast raster, nband integer, exclude_nodata_value boolean) IS 'args: rast, nband, exclude_nodata_value - Returns summary stats consisting of count,sum,mean,stddev,min,max for a given raster band of a raster or raster coverage. Band 1 is assumed is no band is specified.';


--
-- Name: st_summarystats(text, text, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_summarystats(rastertable text, rastercolumn text, exclude_nodata_value boolean) RETURNS summarystats
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_summarystats($1, $2, 1, $3, 1) $_$;


--
-- Name: FUNCTION st_summarystats(rastertable text, rastercolumn text, exclude_nodata_value boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_summarystats(rastertable text, rastercolumn text, exclude_nodata_value boolean) IS 'args: rastertable, rastercolumn, exclude_nodata_value - Returns summary stats consisting of count,sum,mean,stddev,min,max for a given raster band of a raster or raster coverage. Band 1 is assumed is no band is specified.';


--
-- Name: st_summarystats(text, text, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_summarystats(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true) RETURNS summarystats
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_summarystats($1, $2, $3, $4, 1) $_$;


--
-- Name: FUNCTION st_summarystats(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_summarystats(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean) IS 'args: rastertable, rastercolumn, nband=1, exclude_nodata_value=true - Returns summary stats consisting of count,sum,mean,stddev,min,max for a given raster band of a raster or raster coverage. Band 1 is assumed is no band is specified.';


--
-- Name: st_symdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_symdifference(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'symdifference';


--
-- Name: FUNCTION st_symdifference(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_symdifference(geom1 geometry, geom2 geometry) IS 'args: geomA, geomB - Returns a geometry that represents the portions of A and B that do not intersect. It is called a symmetric difference because ST_SymDifference(A,B) = ST_SymDifference(B,A).';


--
-- Name: st_symmetricdifference(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_symmetricdifference(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'symdifference';


--
-- Name: st_touches(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_touches(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Touches($1,$2)$_$;


--
-- Name: FUNCTION st_touches(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_touches(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns TRUE if the geometries have at least one point in common, but their interiors do not intersect.';


--
-- Name: st_transform(geometry, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_transform(geometry, integer) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'transform';


--
-- Name: FUNCTION st_transform(geometry, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_transform(geometry, integer) IS 'args: g1, srid - Returns a new geometry with its coordinates transformed to the SRID referenced by the integer parameter.';


--
-- Name: st_transform(raster, integer, double precision, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_transform(rast raster, srid integer, scalexy double precision, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_resample($1, $4, $5, $2, $3, $3) $_$;


--
-- Name: st_transform(raster, integer, text, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_transform(rast raster, srid integer, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125, scalex double precision DEFAULT 0, scaley double precision DEFAULT 0) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_resample($1, $3, $4, $2, $5, $6) $_$;


--
-- Name: FUNCTION st_transform(rast raster, srid integer, algorithm text, maxerr double precision, scalex double precision, scaley double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_transform(rast raster, srid integer, algorithm text, maxerr double precision, scalex double precision, scaley double precision) IS 'args: rast, srid, algorithm=NearestNeighbor, maxerr=0.125, scalex, scaley - Reprojects a raster in a known spatial reference system to another known spatial reference system using specified resampling algorithm. Options are NearestNeighbor, Bilinear, Cubic, CubicSpline, Lanczos defaulting to NearestNeighbor.';


--
-- Name: st_transform(raster, integer, double precision, double precision, text, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_transform(rast raster, srid integer, scalex double precision, scaley double precision, algorithm text DEFAULT 'NearestNeighbour'::text, maxerr double precision DEFAULT 0.125) RETURNS raster
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT _st_resample($1, $5, $6, $2, $3, $4) $_$;


--
-- Name: FUNCTION st_transform(rast raster, srid integer, scalex double precision, scaley double precision, algorithm text, maxerr double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_transform(rast raster, srid integer, scalex double precision, scaley double precision, algorithm text, maxerr double precision) IS 'args: rast, srid, scalex, scaley, algorithm=NearestNeighbor, maxerr=0.125 - Reprojects a raster in a known spatial reference system to another known spatial reference system using specified resampling algorithm. Options are NearestNeighbor, Bilinear, Cubic, CubicSpline, Lanczos defaulting to NearestNeighbor.';


--
-- Name: st_translate(geometry, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_translate(geometry, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Translate($1, $2, $3, 0)$_$;


--
-- Name: FUNCTION st_translate(geometry, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_translate(geometry, double precision, double precision) IS 'args: g1, deltax, deltay - Translates the geometry to a new location using the numeric parameters as offsets. Ie: ST_Translate(geom, X, Y) or ST_Translate(geom, X, Y,Z).';


--
-- Name: st_translate(geometry, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_translate(geometry, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Affine($1, 1, 0, 0, 0, 1, 0, 0, 0, 1, $2, $3, $4)$_$;


--
-- Name: FUNCTION st_translate(geometry, double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_translate(geometry, double precision, double precision, double precision) IS 'args: g1, deltax, deltay, deltaz - Translates the geometry to a new location using the numeric parameters as offsets. Ie: ST_Translate(geom, X, Y) or ST_Translate(geom, X, Y,Z).';


--
-- Name: st_transscale(geometry, double precision, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_transscale(geometry, double precision, double precision, double precision, double precision) RETURNS geometry
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT ST_Affine($1,  $4, 0, 0,  0, $5, 0,
		0, 0, 1,  $2 * $4, $3 * $5, 0)$_$;


--
-- Name: FUNCTION st_transscale(geometry, double precision, double precision, double precision, double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_transscale(geometry, double precision, double precision, double precision, double precision) IS 'args: geomA, deltaX, deltaY, XFactor, YFactor - Translates the geometry using the deltaX and deltaY args, then scales it using the XFactor, YFactor args, working in 2D only.';


--
-- Name: st_unaryunion(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_unaryunion(geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'ST_UnaryUnion';


--
-- Name: FUNCTION st_unaryunion(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_unaryunion(geometry) IS 'args: geom - Like ST_Union, but working at the geometry component level.';


--
-- Name: st_union(geometry[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_union(geometry[]) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'pgis_union_geometry_array';


--
-- Name: FUNCTION st_union(geometry[]); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_union(geometry[]) IS 'args: g1_array - Returns a geometry that represents the point set union of the Geometries.';


--
-- Name: st_union(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_union(geom1 geometry, geom2 geometry) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'geomunion';


--
-- Name: FUNCTION st_union(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_union(geom1 geometry, geom2 geometry) IS 'args: g1, g2 - Returns a geometry that represents the point set union of the Geometries.';


--
-- Name: st_upperleftx(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_upperleftx(raster) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getXUpperLeft';


--
-- Name: FUNCTION st_upperleftx(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_upperleftx(raster) IS 'args: rast - Returns the upper left X coordinate of raster in projected spatial ref.';


--
-- Name: st_upperlefty(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_upperlefty(raster) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getYUpperLeft';


--
-- Name: FUNCTION st_upperlefty(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_upperlefty(raster) IS 'args: rast - Returns the upper left Y coordinate of raster in projected spatial ref.';


--
-- Name: st_value(raster, geometry, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_value(rast raster, pt geometry, hasnodata boolean DEFAULT true) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT st_value($1, 1, $2, $3) $_$;


--
-- Name: FUNCTION st_value(rast raster, pt geometry, hasnodata boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_value(rast raster, pt geometry, hasnodata boolean) IS 'args: rast, pt, exclude_nodata_value=true - Returns the value of a given band in a given columnx, rowy pixel or at a particular geometric point. Band numbers start at 1 and assumed to be 1 if not specified. If exclude_nodata_value is set to false, then all pixels include nodata pixels are considered to intersect and return value. If exclude_nodata_value is not passed in then reads it from metadata of raster.';


--
-- Name: st_value(raster, integer, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_value(rast raster, x integer, y integer, hasnodata boolean DEFAULT true) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT st_value($1, 1, $2, $3, $4) $_$;


--
-- Name: FUNCTION st_value(rast raster, x integer, y integer, hasnodata boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_value(rast raster, x integer, y integer, hasnodata boolean) IS 'args: rast, columnx, rowy, exclude_nodata_value=true - Returns the value of a given band in a given columnx, rowy pixel or at a particular geometric point. Band numbers start at 1 and assumed to be 1 if not specified. If exclude_nodata_value is set to false, then all pixels include nodata pixels are considered to intersect and return value. If exclude_nodata_value is not passed in then reads it from metadata of raster.';


--
-- Name: st_value(raster, integer, geometry, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_value(rast raster, band integer, pt geometry, hasnodata boolean DEFAULT true) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
    DECLARE
        x float8;
        y float8;
        gtype text;
    BEGIN
        gtype := st_geometrytype(pt);
        IF ( gtype != 'ST_Point' ) THEN
            RAISE EXCEPTION 'Attempting to get the value of a pixel with a non-point geometry';
        END IF;
        x := st_x(pt);
        y := st_y(pt);
        RETURN st_value(rast,
                        band,
                        st_world2rastercoordx(rast, x, y),
                        st_world2rastercoordy(rast, x, y),
                        hasnodata);
    END;
    $$;


--
-- Name: FUNCTION st_value(rast raster, band integer, pt geometry, hasnodata boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_value(rast raster, band integer, pt geometry, hasnodata boolean) IS 'args: rast, bandnum, pt, exclude_nodata_value=true - Returns the value of a given band in a given columnx, rowy pixel or at a particular geometric point. Band numbers start at 1 and assumed to be 1 if not specified. If exclude_nodata_value is set to false, then all pixels include nodata pixels are considered to intersect and return value. If exclude_nodata_value is not passed in then reads it from metadata of raster.';


--
-- Name: st_value(raster, integer, integer, integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_value(rast raster, band integer, x integer, y integer, hasnodata boolean DEFAULT true) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getPixelValue';


--
-- Name: FUNCTION st_value(rast raster, band integer, x integer, y integer, hasnodata boolean); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_value(rast raster, band integer, x integer, y integer, hasnodata boolean) IS 'args: rast, bandnum, columnx, rowy, exclude_nodata_value=true - Returns the value of a given band in a given columnx, rowy pixel or at a particular geometric point. Band numbers start at 1 and assumed to be 1 if not specified. If exclude_nodata_value is set to false, then all pixels include nodata pixels are considered to intersect and return value. If exclude_nodata_value is not passed in then reads it from metadata of raster.';


--
-- Name: st_valuecount(raster, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rast raster, searchvalues double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT count integer) RETURNS SETOF record
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT value, count FROM _st_valuecount($1, 1, TRUE, $2, $3) $_$;


--
-- Name: FUNCTION st_valuecount(rast raster, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rast raster, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer) IS 'args: rast, searchvalues, roundto=0, OUT value, OUT count - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(raster, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rast raster, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, 1, TRUE, ARRAY[$2]::double precision[], $3)).count $_$;


--
-- Name: FUNCTION st_valuecount(rast raster, searchvalue double precision, roundto double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rast raster, searchvalue double precision, roundto double precision) IS 'args: rast, searchvalue, roundto=0 - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(raster, integer, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rast raster, nband integer, searchvalues double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT count integer) RETURNS SETOF record
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT value, count FROM _st_valuecount($1, $2, TRUE, $3, $4) $_$;


--
-- Name: FUNCTION st_valuecount(rast raster, nband integer, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rast raster, nband integer, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer) IS 'args: rast, nband, searchvalues, roundto=0, OUT value, OUT count - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(raster, integer, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rast raster, nband integer, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, $2, TRUE, ARRAY[$3]::double precision[], $4)).count $_$;


--
-- Name: FUNCTION st_valuecount(rast raster, nband integer, searchvalue double precision, roundto double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rast raster, nband integer, searchvalue double precision, roundto double precision) IS 'args: rast, nband, searchvalue, roundto=0 - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(text, text, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rastertable text, rastercolumn text, searchvalues double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT count integer) RETURNS SETOF record
    LANGUAGE sql STABLE
    AS $_$ SELECT value, count FROM _st_valuecount($1, $2, 1, TRUE, $3, $4) $_$;


--
-- Name: FUNCTION st_valuecount(rastertable text, rastercolumn text, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rastertable text, rastercolumn text, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer) IS 'args: rastertable, rastercolumn, searchvalues, roundto=0, OUT value, OUT count - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(text, text, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rastertable text, rastercolumn text, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS integer
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, $2, 1, TRUE, ARRAY[$3]::double precision[], $4)).count $_$;


--
-- Name: FUNCTION st_valuecount(rastertable text, rastercolumn text, searchvalue double precision, roundto double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rastertable text, rastercolumn text, searchvalue double precision, roundto double precision) IS 'args: rastertable, rastercolumn, searchvalue, roundto=0 - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(raster, integer, boolean, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, searchvalues double precision[] DEFAULT NULL::double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT count integer) RETURNS SETOF record
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT value, count FROM _st_valuecount($1, $2, $3, $4, $5) $_$;


--
-- Name: FUNCTION st_valuecount(rast raster, nband integer, exclude_nodata_value boolean, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rast raster, nband integer, exclude_nodata_value boolean, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer) IS 'args: rast, nband=1, exclude_nodata_value=true, searchvalues=NULL, roundto=0, OUT value, OUT count - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(raster, integer, boolean, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rast raster, nband integer, exclude_nodata_value boolean, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, $2, $3, ARRAY[$4]::double precision[], $5)).count $_$;


--
-- Name: FUNCTION st_valuecount(rast raster, nband integer, exclude_nodata_value boolean, searchvalue double precision, roundto double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rast raster, nband integer, exclude_nodata_value boolean, searchvalue double precision, roundto double precision) IS 'args: rast, nband, exclude_nodata_value, searchvalue, roundto=0 - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(text, text, integer, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, searchvalues double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT count integer) RETURNS SETOF record
    LANGUAGE sql STABLE
    AS $_$ SELECT value, count FROM _st_valuecount($1, $2, $3, TRUE, $4, $5) $_$;


--
-- Name: FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer) IS 'args: rastertable, rastercolumn, nband, searchvalues, roundto=0, OUT value, OUT count - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(text, text, integer, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS integer
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, $2, $3, TRUE, ARRAY[$4]::double precision[], $5)).count $_$;


--
-- Name: FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, searchvalue double precision, roundto double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, searchvalue double precision, roundto double precision) IS 'args: rastertable, rastercolumn, nband, searchvalue, roundto=0 - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(text, text, integer, boolean, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, searchvalues double precision[] DEFAULT NULL::double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT count integer) RETURNS SETOF record
    LANGUAGE sql STABLE
    AS $_$ SELECT value, count FROM _st_valuecount($1, $2, $3, $4, $5, $6) $_$;


--
-- Name: FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, searchvalues double precision[], roundto double precision, OUT value double precision, OUT count integer) IS 'args: rastertable, rastercolumn, nband=1, exclude_nodata_value=true, searchvalues=NULL, roundto=0, OUT value, OUT count - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuecount(text, text, integer, boolean, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS integer
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, $2, $3, $4, ARRAY[$5]::double precision[], $6)).count $_$;


--
-- Name: FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, searchvalue double precision, roundto double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_valuecount(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, searchvalue double precision, roundto double precision) IS 'args: rastertable, rastercolumn, nband, exclude_nodata_value, searchvalue, roundto=0 - Returns a set of records containing a pixel band value and count of the number of pixels in a given band of a raster (or a raster coverage) that have a given set of values. If no band is specified defaults to band 1. By default nodata value pixels are not counted. and all other values in the pixel are output and pixel band values are rounded to the nearest integer.';


--
-- Name: st_valuepercent(raster, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rast raster, searchvalues double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT percent double precision) RETURNS SETOF record
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT value, percent FROM _st_valuecount($1, 1, TRUE, $2, $3) $_$;


--
-- Name: st_valuepercent(raster, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rast raster, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, 1, TRUE, ARRAY[$2]::double precision[], $3)).percent $_$;


--
-- Name: st_valuepercent(raster, integer, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rast raster, nband integer, searchvalues double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT percent double precision) RETURNS SETOF record
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT value, percent FROM _st_valuecount($1, $2, TRUE, $3, $4) $_$;


--
-- Name: st_valuepercent(raster, integer, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rast raster, nband integer, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, $2, TRUE, ARRAY[$3]::double precision[], $4)).percent $_$;


--
-- Name: st_valuepercent(text, text, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rastertable text, rastercolumn text, searchvalues double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT percent double precision) RETURNS SETOF record
    LANGUAGE sql STABLE
    AS $_$ SELECT value, percent FROM _st_valuecount($1, $2, 1, TRUE, $3, $4) $_$;


--
-- Name: st_valuepercent(text, text, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rastertable text, rastercolumn text, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS double precision
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, $2, 1, TRUE, ARRAY[$3]::double precision[], $4)).percent $_$;


--
-- Name: st_valuepercent(raster, integer, boolean, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rast raster, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, searchvalues double precision[] DEFAULT NULL::double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT percent double precision) RETURNS SETOF record
    LANGUAGE sql IMMUTABLE
    AS $_$ SELECT value, percent FROM _st_valuecount($1, $2, $3, $4, $5) $_$;


--
-- Name: st_valuepercent(raster, integer, boolean, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rast raster, nband integer, exclude_nodata_value boolean, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, $2, $3, ARRAY[$4]::double precision[], $5)).percent $_$;


--
-- Name: st_valuepercent(text, text, integer, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rastertable text, rastercolumn text, nband integer, searchvalues double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT percent double precision) RETURNS SETOF record
    LANGUAGE sql STABLE
    AS $_$ SELECT value, percent FROM _st_valuecount($1, $2, $3, TRUE, $4, $5) $_$;


--
-- Name: st_valuepercent(text, text, integer, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rastertable text, rastercolumn text, nband integer, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS double precision
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, $2, $3, TRUE, ARRAY[$4]::double precision[], $5)).percent $_$;


--
-- Name: st_valuepercent(text, text, integer, boolean, double precision[], double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rastertable text, rastercolumn text, nband integer DEFAULT 1, exclude_nodata_value boolean DEFAULT true, searchvalues double precision[] DEFAULT NULL::double precision[], roundto double precision DEFAULT 0, OUT value double precision, OUT percent double precision) RETURNS SETOF record
    LANGUAGE sql STABLE
    AS $_$ SELECT value, percent FROM _st_valuecount($1, $2, $3, $4, $5, $6) $_$;


--
-- Name: st_valuepercent(text, text, integer, boolean, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_valuepercent(rastertable text, rastercolumn text, nband integer, exclude_nodata_value boolean, searchvalue double precision, roundto double precision DEFAULT 0) RETURNS double precision
    LANGUAGE sql STABLE STRICT
    AS $_$ SELECT (_st_valuecount($1, $2, $3, $4, ARRAY[$5]::double precision[], $6)).percent $_$;


--
-- Name: st_width(raster); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_width(raster) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/rtpostgis-2.0', 'RASTER_getWidth';


--
-- Name: FUNCTION st_width(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_width(raster) IS 'args: rast - Returns the width of the raster in pixels.';


--
-- Name: st_within(geometry, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_within(geom1 geometry, geom2 geometry) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT $1 && $2 AND _ST_Contains($2,$1)$_$;


--
-- Name: FUNCTION st_within(geom1 geometry, geom2 geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_within(geom1 geometry, geom2 geometry) IS 'args: A, B - Returns true if the geometry A is completely inside geometry B';


--
-- Name: st_wkbtosql(bytea); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_wkbtosql(wkb bytea) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_from_WKB';


--
-- Name: FUNCTION st_wkbtosql(wkb bytea); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_wkbtosql(wkb bytea) IS 'args: WKB - Return a specified ST_Geometry value from Well-Known Binary representation (WKB). This is an alias name for ST_GeomFromWKB that takes no srid';


--
-- Name: st_wkttosql(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_wkttosql(text) RETURNS geometry
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_from_text';


--
-- Name: FUNCTION st_wkttosql(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_wkttosql(text) IS 'args: WKT - Return a specified ST_Geometry value from Well-Known Text representation (WKT). This is an alias name for ST_GeomFromText';


--
-- Name: st_world2rastercoordx(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_world2rastercoordx(rast raster, xw double precision) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT columnx FROM _st_world2rastercoord($1, $2, NULL) $_$;


--
-- Name: FUNCTION st_world2rastercoordx(rast raster, xw double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_world2rastercoordx(rast raster, xw double precision) IS 'args: rast, xw - Returns the column in the raster of the point geometry (pt) or a X and Y world coordinate (xw, yw) represented in world spatial reference system of raster.';


--
-- Name: st_world2rastercoordx(raster, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_world2rastercoordx(rast raster, pt geometry) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
	DECLARE
		xr integer;
	BEGIN
		IF ( st_geometrytype(pt) != 'ST_Point' ) THEN
			RAISE EXCEPTION 'Attempting to compute raster coordinate with a non-point geometry';
		END IF;
		SELECT columnx INTO xr FROM _st_world2rastercoord($1, st_x(pt), st_y(pt));
		RETURN xr;
	END;
	$_$;


--
-- Name: FUNCTION st_world2rastercoordx(rast raster, pt geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_world2rastercoordx(rast raster, pt geometry) IS 'args: rast, pt - Returns the column in the raster of the point geometry (pt) or a X and Y world coordinate (xw, yw) represented in world spatial reference system of raster.';


--
-- Name: st_world2rastercoordx(raster, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_world2rastercoordx(rast raster, xw double precision, yw double precision) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT columnx FROM _st_world2rastercoord($1, $2, $3) $_$;


--
-- Name: FUNCTION st_world2rastercoordx(rast raster, xw double precision, yw double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_world2rastercoordx(rast raster, xw double precision, yw double precision) IS 'args: rast, xw, yw - Returns the column in the raster of the point geometry (pt) or a X and Y world coordinate (xw, yw) represented in world spatial reference system of raster.';


--
-- Name: st_world2rastercoordy(raster, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_world2rastercoordy(rast raster, yw double precision) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT rowy FROM _st_world2rastercoord($1, NULL, $2) $_$;


--
-- Name: FUNCTION st_world2rastercoordy(rast raster, yw double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_world2rastercoordy(rast raster, yw double precision) IS 'args: rast, xw - Returns the row in the raster of the point geometry (pt) or a X and Y world coordinate (xw, yw) represented in world spatial reference system of raster.';


--
-- Name: st_world2rastercoordy(raster, geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_world2rastercoordy(rast raster, pt geometry) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $_$
	DECLARE
		yr integer;
	BEGIN
		IF ( st_geometrytype(pt) != 'ST_Point' ) THEN
			RAISE EXCEPTION 'Attempting to compute raster coordinate with a non-point geometry';
		END IF;
		SELECT rowy INTO yr FROM _st_world2rastercoord($1, st_x(pt), st_y(pt));
		RETURN yr;
	END;
	$_$;


--
-- Name: FUNCTION st_world2rastercoordy(rast raster, pt geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_world2rastercoordy(rast raster, pt geometry) IS 'args: rast, pt - Returns the row in the raster of the point geometry (pt) or a X and Y world coordinate (xw, yw) represented in world spatial reference system of raster.';


--
-- Name: st_world2rastercoordy(raster, double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_world2rastercoordy(rast raster, xw double precision, yw double precision) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT rowy FROM _st_world2rastercoord($1, $2, $3) $_$;


--
-- Name: FUNCTION st_world2rastercoordy(rast raster, xw double precision, yw double precision); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_world2rastercoordy(rast raster, xw double precision, yw double precision) IS 'args: rast, xw, yw - Returns the row in the raster of the point geometry (pt) or a X and Y world coordinate (xw, yw) represented in world spatial reference system of raster.';


--
-- Name: st_x(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_x(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_x_point';


--
-- Name: FUNCTION st_x(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_x(geometry) IS 'args: a_point - Return the X coordinate of the point, or NULL if not available. Input must be a point.';


--
-- Name: st_xmax(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_xmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_xmax';


--
-- Name: FUNCTION st_xmax(box3d); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_xmax(box3d) IS 'args: aGeomorBox2DorBox3D - Returns X maxima of a bounding box 2d or 3d or a geometry.';


--
-- Name: st_xmin(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_xmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_xmin';


--
-- Name: FUNCTION st_xmin(box3d); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_xmin(box3d) IS 'args: aGeomorBox2DorBox3D - Returns X minima of a bounding box 2d or 3d or a geometry.';


--
-- Name: st_y(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_y(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_y_point';


--
-- Name: FUNCTION st_y(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_y(geometry) IS 'args: a_point - Return the Y coordinate of the point, or NULL if not available. Input must be a point.';


--
-- Name: st_ymax(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_ymax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_ymax';


--
-- Name: FUNCTION st_ymax(box3d); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_ymax(box3d) IS 'args: aGeomorBox2DorBox3D - Returns Y maxima of a bounding box 2d or 3d or a geometry.';


--
-- Name: st_ymin(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_ymin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_ymin';


--
-- Name: FUNCTION st_ymin(box3d); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_ymin(box3d) IS 'args: aGeomorBox2DorBox3D - Returns Y minima of a bounding box 2d or 3d or a geometry.';


--
-- Name: st_z(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_z(geometry) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_z_point';


--
-- Name: FUNCTION st_z(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_z(geometry) IS 'args: a_point - Return the Z coordinate of the point, or NULL if not available. Input must be a point.';


--
-- Name: st_zmax(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_zmax(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_zmax';


--
-- Name: FUNCTION st_zmax(box3d); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_zmax(box3d) IS 'args: aGeomorBox2DorBox3D - Returns Z minima of a bounding box 2d or 3d or a geometry.';


--
-- Name: st_zmflag(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_zmflag(geometry) RETURNS smallint
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_zmflag';


--
-- Name: FUNCTION st_zmflag(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_zmflag(geometry) IS 'args: geomA - Returns ZM (dimension semantic) flag of the geometries as a small int. Values are: 0=2d, 1=3dm, 2=3dz, 3=4d.';


--
-- Name: st_zmin(box3d); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION st_zmin(box3d) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'BOX3D_zmin';


--
-- Name: FUNCTION st_zmin(box3d); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION st_zmin(box3d) IS 'args: aGeomorBox2DorBox3D - Returns Z minima of a bounding box 2d or 3d or a geometry.';


--
-- Name: text(geometry); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION text(geometry) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/postgis-2.0', 'LWGEOM_to_text';


--
-- Name: unlockrows(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION unlockrows(text) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$ 
DECLARE
	ret int;
BEGIN

	IF NOT LongTransactionsEnabled() THEN
		RAISE EXCEPTION 'Long transaction support disabled, use EnableLongTransaction() to enable.';
	END IF;

	EXECUTE 'DELETE FROM authorization_table where authid = ' ||
		quote_literal($1);

	GET DIAGNOSTICS ret = ROW_COUNT;

	RETURN ret;
END;
$_$;


--
-- Name: FUNCTION unlockrows(text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION unlockrows(text) IS 'args: auth_token - Remove all locks held by specified authorization id. Returns the number of locks released.';


--
-- Name: updategeometrysrid(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION updategeometrysrid(character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT UpdateGeometrySRID('','',$1,$2,$3) into ret;
	RETURN ret;
END;
$_$;


--
-- Name: FUNCTION updategeometrysrid(character varying, character varying, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION updategeometrysrid(character varying, character varying, integer) IS 'args: table_name, column_name, srid - Updates the SRID of all features in a geometry column, geometry_columns metadata and srid table constraint';


--
-- Name: updategeometrysrid(character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION updategeometrysrid(character varying, character varying, character varying, integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $_$
DECLARE
	ret  text;
BEGIN
	SELECT UpdateGeometrySRID('',$1,$2,$3,$4) into ret;
	RETURN ret;
END;
$_$;


--
-- Name: FUNCTION updategeometrysrid(character varying, character varying, character varying, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION updategeometrysrid(character varying, character varying, character varying, integer) IS 'args: schema_name, table_name, column_name, srid - Updates the SRID of all features in a geometry column, geometry_columns metadata and srid table constraint';


--
-- Name: updategeometrysrid(character varying, character varying, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) RETURNS text
    LANGUAGE plpgsql STRICT
    AS $$
DECLARE
	myrec RECORD;
	okay boolean;
	cname varchar;
	real_schema name;
	unknown_srid integer;
	new_srid integer := new_srid_in;

BEGIN


	-- Find, check or fix schema_name
	IF ( schema_name != '' ) THEN
		okay = false;

		FOR myrec IN SELECT nspname FROM pg_namespace WHERE text(nspname) = schema_name LOOP
			okay := true;
		END LOOP;

		IF ( okay <> true ) THEN
			RAISE EXCEPTION 'Invalid schema name';
		ELSE
			real_schema = schema_name;
		END IF;
	ELSE
		SELECT INTO real_schema current_schema()::text;
	END IF;

	-- Ensure that column_name is in geometry_columns
	okay = false;
	FOR myrec IN SELECT type, coord_dimension FROM geometry_columns WHERE f_table_schema = text(real_schema) and f_table_name = table_name and f_geometry_column = column_name LOOP
		okay := true;
	END LOOP;
	IF (NOT okay) THEN
		RAISE EXCEPTION 'column not found in geometry_columns table';
		RETURN false;
	END IF;

	-- Ensure that new_srid is valid
	IF ( new_srid > 0 ) THEN
		IF ( SELECT count(*) = 0 from spatial_ref_sys where srid = new_srid ) THEN
			RAISE EXCEPTION 'invalid SRID: % not found in spatial_ref_sys', new_srid;
			RETURN false;
		END IF;
	ELSE
		unknown_srid := ST_SRID('POINT EMPTY'::geometry);
		IF ( new_srid != unknown_srid ) THEN
			new_srid := unknown_srid;
			RAISE NOTICE 'SRID value % converted to the officially unknown SRID value %', new_srid_in, new_srid;
		END IF;
	END IF;

	IF postgis_constraint_srid(schema_name, table_name, column_name) IS NOT NULL THEN 
	-- srid was enforced with constraints before, keep it that way.
        -- Make up constraint name
        cname = 'enforce_srid_'  || column_name;
    
        -- Drop enforce_srid constraint
        EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) ||
            '.' || quote_ident(table_name) ||
            ' DROP constraint ' || quote_ident(cname);
    
        -- Update geometries SRID
        EXECUTE 'UPDATE ' || quote_ident(real_schema) ||
            '.' || quote_ident(table_name) ||
            ' SET ' || quote_ident(column_name) ||
            ' = ST_SetSRID(' || quote_ident(column_name) ||
            ', ' || new_srid::text || ')';
            
        -- Reset enforce_srid constraint
        EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) ||
            '.' || quote_ident(table_name) ||
            ' ADD constraint ' || quote_ident(cname) ||
            ' CHECK (st_srid(' || quote_ident(column_name) ||
            ') = ' || new_srid::text || ')';
    ELSE 
        -- We will use typmod to enforce if no srid constraints
        -- We are using postgis_type_name to lookup the new name 
        -- (in case Paul changes his mind and flips geometry_columns to return old upper case name) 
        EXECUTE 'ALTER TABLE ' || quote_ident(real_schema) || '.' || quote_ident(table_name) || 
        ' ALTER COLUMN ' || quote_ident(column_name) || ' TYPE  geometry(' || postgis_type_name(myrec.type, myrec.coord_dimension, true) || ', ' || new_srid::text || ') USING ST_SetSRID(' || quote_ident(column_name) || ',' || new_srid::text || ');' ;
    END IF;

	RETURN real_schema || '.' || table_name || '.' || column_name ||' SRID changed to ' || new_srid::text;

END;
$$;


--
-- Name: FUNCTION updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON FUNCTION updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) IS 'args: catalog_name, schema_name, table_name, column_name, srid - Updates the SRID of all features in a geometry column, geometry_columns metadata and srid table constraint';


--
-- Name: st_3dextent(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_3dextent(geometry) (
    SFUNC = public.st_combine_bbox,
    STYPE = box3d
);


--
-- Name: AGGREGATE st_3dextent(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_3dextent(geometry) IS 'args: geomfield - an aggregate function that returns the box3D bounding box that bounds rows of geometries.';


--
-- Name: st_accum(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_accum(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_accum_finalfn
);


--
-- Name: AGGREGATE st_accum(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_accum(geometry) IS 'args: geomfield - Aggregate. Constructs an array of geometries.';


--
-- Name: st_collect(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_collect(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_collect_finalfn
);


--
-- Name: AGGREGATE st_collect(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_collect(geometry) IS 'args: g1field - Return a specified ST_Geometry value from a collection of other geometries.';


--
-- Name: st_extent(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_extent(geometry) (
    SFUNC = public.st_combine_bbox,
    STYPE = box3d,
    FINALFUNC = public.box2d
);


--
-- Name: AGGREGATE st_extent(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_extent(geometry) IS 'args: geomfield - an aggregate function that returns the bounding box that bounds rows of geometries.';


--
-- Name: st_makeline(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_makeline(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_makeline_finalfn
);


--
-- Name: AGGREGATE st_makeline(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_makeline(geometry) IS 'args: geoms - Creates a Linestring from point or line geometries.';


--
-- Name: st_memcollect(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_memcollect(geometry) (
    SFUNC = public.st_collect,
    STYPE = geometry
);


--
-- Name: st_memunion(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_memunion(geometry) (
    SFUNC = public.st_union,
    STYPE = geometry
);


--
-- Name: AGGREGATE st_memunion(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_memunion(geometry) IS 'args: geomfield - Same as ST_Union, only memory-friendly (uses less memory and more processor time).';


--
-- Name: st_polygonize(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_polygonize(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_polygonize_finalfn
);


--
-- Name: AGGREGATE st_polygonize(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_polygonize(geometry) IS 'args: geomfield - Aggregate. Creates a GeometryCollection containing possible polygons formed from the constituent linework of a set of geometries.';


--
-- Name: st_union(geometry); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_union(geometry) (
    SFUNC = pgis_geometry_accum_transfn,
    STYPE = pgis_abs,
    FINALFUNC = pgis_geometry_union_finalfn
);


--
-- Name: AGGREGATE st_union(geometry); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_union(geometry) IS 'args: g1field - Returns a geometry that represents the point set union of the Geometries.';


--
-- Name: st_union(raster); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_union(raster) (
    SFUNC = public._st_mapalgebra4unionstate,
    STYPE = raster,
    FINALFUNC = _st_mapalgebra4unionfinal1
);


--
-- Name: AGGREGATE st_union(raster); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_union(raster) IS 'args: rast - Returns the union of a set of raster tiles into a single raster composed of 1 band. If no band is specified for unioning, band num 1 is assumed. The resulting rasters extent is the extent of the whole set. In the case of intersection, the resulting value is defined by p_expression which is one of the following: LAST - the default when none is specified, MEAN, SUM, FIRST, MAX, MIN.';


--
-- Name: st_union(raster, integer); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_union(raster, integer) (
    SFUNC = public._st_mapalgebra4unionstate,
    STYPE = raster,
    FINALFUNC = _st_mapalgebra4unionfinal1
);


--
-- Name: AGGREGATE st_union(raster, integer); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_union(raster, integer) IS 'args: rast, band_num - Returns the union of a set of raster tiles into a single raster composed of 1 band. If no band is specified for unioning, band num 1 is assumed. The resulting rasters extent is the extent of the whole set. In the case of intersection, the resulting value is defined by p_expression which is one of the following: LAST - the default when none is specified, MEAN, SUM, FIRST, MAX, MIN.';


--
-- Name: st_union(raster, text); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_union(raster, text) (
    SFUNC = public._st_mapalgebra4unionstate,
    STYPE = raster,
    FINALFUNC = _st_mapalgebra4unionfinal1
);


--
-- Name: AGGREGATE st_union(raster, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_union(raster, text) IS 'args: rast, p_expression - Returns the union of a set of raster tiles into a single raster composed of 1 band. If no band is specified for unioning, band num 1 is assumed. The resulting rasters extent is the extent of the whole set. In the case of intersection, the resulting value is defined by p_expression which is one of the following: LAST - the default when none is specified, MEAN, SUM, FIRST, MAX, MIN.';


--
-- Name: st_union(raster, integer, text); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE st_union(raster, integer, text) (
    SFUNC = public._st_mapalgebra4unionstate,
    STYPE = raster,
    FINALFUNC = _st_mapalgebra4unionfinal1
);


--
-- Name: AGGREGATE st_union(raster, integer, text); Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON AGGREGATE st_union(raster, integer, text) IS 'args: rast, band_num, p_expression - Returns the union of a set of raster tiles into a single raster composed of 1 band. If no band is specified for unioning, band num 1 is assumed. The resulting rasters extent is the extent of the whole set. In the case of intersection, the resulting value is defined by p_expression which is one of the following: LAST - the default when none is specified, MEAN, SUM, FIRST, MAX, MIN.';


--
-- Name: &&; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR && (
    PROCEDURE = geometry_overlaps,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &&,
    RESTRICT = geometry_gist_sel_2d,
    JOIN = geometry_gist_joinsel_2d
);


--
-- Name: &&; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR && (
    PROCEDURE = geography_overlaps,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = &&,
    RESTRICT = geography_gist_selectivity,
    JOIN = geography_gist_join_selectivity
);


--
-- Name: &&; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR && (
    PROCEDURE = raster_overlap,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = &&,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: &&; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR && (
    PROCEDURE = geometry_raster_overlap,
    LEFTARG = geometry,
    RIGHTARG = raster,
    COMMUTATOR = &&,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: &&; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR && (
    PROCEDURE = raster_geometry_overlap,
    LEFTARG = raster,
    RIGHTARG = geometry,
    COMMUTATOR = &&,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: &&&; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR &&& (
    PROCEDURE = geometry_overlaps_nd,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &&&,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: &<; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR &< (
    PROCEDURE = geometry_overleft,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: &<; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR &< (
    PROCEDURE = raster_overleft,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = &>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: &<|; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR &<| (
    PROCEDURE = geometry_overbelow,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = |&>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: &<|; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR &<| (
    PROCEDURE = raster_overbelow,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = |&>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: &>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR &> (
    PROCEDURE = geometry_overright,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: &>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR &> (
    PROCEDURE = raster_overright,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = &<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: <; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR < (
    PROCEDURE = geometry_lt,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: <; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR < (
    PROCEDURE = geography_lt,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: <#>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <#> (
    PROCEDURE = geometry_distance_box,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <#>
);


--
-- Name: <->; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <-> (
    PROCEDURE = geometry_distance_centroid,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <->
);


--
-- Name: <<; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR << (
    PROCEDURE = geometry_left,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = >>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: <<; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR << (
    PROCEDURE = raster_left,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = >>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: <<|; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <<| (
    PROCEDURE = geometry_below,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = |>>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: <<|; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <<| (
    PROCEDURE = raster_below,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = |>>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: <=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <= (
    PROCEDURE = geometry_le,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: <=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <= (
    PROCEDURE = geography_le,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: =; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR = (
    PROCEDURE = geometry_eq,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = =,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: =; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR = (
    PROCEDURE = geography_eq,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = =,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: >; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR > (
    PROCEDURE = geometry_gt,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: >; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR > (
    PROCEDURE = geography_gt,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: >=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR >= (
    PROCEDURE = geometry_ge,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: >=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR >= (
    PROCEDURE = geography_ge,
    LEFTARG = geography,
    RIGHTARG = geography,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: >>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR >> (
    PROCEDURE = geometry_right,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: >>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR >> (
    PROCEDURE = raster_right,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = <<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: @; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR @ (
    PROCEDURE = geometry_within,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: @; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR @ (
    PROCEDURE = raster_contained,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: |&>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR |&> (
    PROCEDURE = geometry_overabove,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = &<|,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: |&>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR |&> (
    PROCEDURE = raster_overabove,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = &<|,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: |>>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR |>> (
    PROCEDURE = geometry_above,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = <<|,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: |>>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR |>> (
    PROCEDURE = raster_above,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = <<|,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


--
-- Name: ~; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR ~ (
    PROCEDURE = geometry_contains,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: ~; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR ~ (
    PROCEDURE = raster_contain,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: ~; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR ~ (
    PROCEDURE = raster_geometry_contain,
    LEFTARG = raster,
    RIGHTARG = geometry,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: ~; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR ~ (
    PROCEDURE = geometry_raster_contain,
    LEFTARG = geometry,
    RIGHTARG = raster,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: ~=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR ~= (
    PROCEDURE = geometry_same,
    LEFTARG = geometry,
    RIGHTARG = geometry,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


--
-- Name: ~=; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR ~= (
    PROCEDURE = raster_same,
    LEFTARG = raster,
    RIGHTARG = raster,
    COMMUTATOR = ~=,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


--
-- Name: btree_geography_ops; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS btree_geography_ops
    DEFAULT FOR TYPE geography USING btree AS
    OPERATOR 1 <(geography,geography) ,
    OPERATOR 2 <=(geography,geography) ,
    OPERATOR 3 =(geography,geography) ,
    OPERATOR 4 >=(geography,geography) ,
    OPERATOR 5 >(geography,geography) ,
    FUNCTION 1 geography_cmp(geography,geography);


--
-- Name: btree_geometry_ops; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS btree_geometry_ops
    DEFAULT FOR TYPE geometry USING btree AS
    OPERATOR 1 <(geometry,geometry) ,
    OPERATOR 2 <=(geometry,geometry) ,
    OPERATOR 3 =(geometry,geometry) ,
    OPERATOR 4 >=(geometry,geometry) ,
    OPERATOR 5 >(geometry,geometry) ,
    FUNCTION 1 geometry_cmp(geometry,geometry);


--
-- Name: gist_geography_ops; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS gist_geography_ops
    DEFAULT FOR TYPE geography USING gist AS
    STORAGE gidx ,
    OPERATOR 3 &&(geography,geography) ,
    FUNCTION 1 geography_gist_consistent(internal,geography,integer) ,
    FUNCTION 2 geography_gist_union(bytea,internal) ,
    FUNCTION 3 geography_gist_compress(internal) ,
    FUNCTION 4 geography_gist_decompress(internal) ,
    FUNCTION 5 geography_gist_penalty(internal,internal,internal) ,
    FUNCTION 6 geography_gist_picksplit(internal,internal) ,
    FUNCTION 7 geography_gist_same(box2d,box2d,internal);


--
-- Name: gist_geometry_ops_2d; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS gist_geometry_ops_2d
    DEFAULT FOR TYPE geometry USING gist AS
    STORAGE box2df ,
    OPERATOR 1 <<(geometry,geometry) ,
    OPERATOR 2 &<(geometry,geometry) ,
    OPERATOR 3 &&(geometry,geometry) ,
    OPERATOR 4 &>(geometry,geometry) ,
    OPERATOR 5 >>(geometry,geometry) ,
    OPERATOR 6 ~=(geometry,geometry) ,
    OPERATOR 7 ~(geometry,geometry) ,
    OPERATOR 8 @(geometry,geometry) ,
    OPERATOR 9 &<|(geometry,geometry) ,
    OPERATOR 10 <<|(geometry,geometry) ,
    OPERATOR 11 |>>(geometry,geometry) ,
    OPERATOR 12 |&>(geometry,geometry) ,
    OPERATOR 13 <->(geometry,geometry) FOR ORDER BY pg_catalog.float_ops ,
    OPERATOR 14 <#>(geometry,geometry) FOR ORDER BY pg_catalog.float_ops ,
    FUNCTION 1 geometry_gist_consistent_2d(internal,geometry,integer) ,
    FUNCTION 2 geometry_gist_union_2d(bytea,internal) ,
    FUNCTION 3 geometry_gist_compress_2d(internal) ,
    FUNCTION 4 geometry_gist_decompress_2d(internal) ,
    FUNCTION 5 geometry_gist_penalty_2d(internal,internal,internal) ,
    FUNCTION 6 geometry_gist_picksplit_2d(internal,internal) ,
    FUNCTION 7 geometry_gist_same_2d(geometry,geometry,internal) ,
    FUNCTION 8 geometry_gist_distance_2d(internal,geometry,integer);


--
-- Name: gist_geometry_ops_nd; Type: OPERATOR CLASS; Schema: public; Owner: -
--

CREATE OPERATOR CLASS gist_geometry_ops_nd
    FOR TYPE geometry USING gist AS
    STORAGE gidx ,
    OPERATOR 3 &&&(geometry,geometry) ,
    FUNCTION 1 geometry_gist_consistent_nd(internal,geometry,integer) ,
    FUNCTION 2 geometry_gist_union_nd(bytea,internal) ,
    FUNCTION 3 geometry_gist_compress_nd(internal) ,
    FUNCTION 4 geometry_gist_decompress_nd(internal) ,
    FUNCTION 5 geometry_gist_penalty_nd(internal,internal,internal) ,
    FUNCTION 6 geometry_gist_picksplit_nd(internal,internal) ,
    FUNCTION 7 geometry_gist_same_nd(geometry,geometry,internal);


SET search_path = pg_catalog;

--
-- Name: CAST (public.box2d AS public.box3d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box2d AS public.box3d) WITH FUNCTION public.box3d(public.box2d) AS IMPLICIT;


--
-- Name: CAST (public.box2d AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box2d AS public.geometry) WITH FUNCTION public.geometry(public.box2d) AS IMPLICIT;


--
-- Name: CAST (public.box3d AS box); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box3d AS box) WITH FUNCTION public.box(public.box3d) AS IMPLICIT;


--
-- Name: CAST (public.box3d AS public.box2d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box3d AS public.box2d) WITH FUNCTION public.box2d(public.box3d) AS IMPLICIT;


--
-- Name: CAST (public.box3d AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.box3d AS public.geometry) WITH FUNCTION public.geometry(public.box3d) AS IMPLICIT;


--
-- Name: CAST (bytea AS public.geography); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (bytea AS public.geography) WITH FUNCTION public.geography(bytea) AS IMPLICIT;


--
-- Name: CAST (bytea AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (bytea AS public.geometry) WITH FUNCTION public.geometry(bytea) AS IMPLICIT;


--
-- Name: CAST (public.geography AS bytea); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geography AS bytea) WITH FUNCTION public.bytea(public.geography) AS IMPLICIT;


--
-- Name: CAST (public.geography AS public.geography); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geography AS public.geography) WITH FUNCTION public.geography(public.geography, integer, boolean) AS IMPLICIT;


--
-- Name: CAST (public.geography AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geography AS public.geometry) WITH FUNCTION public.geometry(public.geography);


--
-- Name: CAST (public.geometry AS box); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS box) WITH FUNCTION public.box(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS public.box2d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS public.box2d) WITH FUNCTION public.box2d(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS public.box3d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS public.box3d) WITH FUNCTION public.box3d(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS bytea); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS bytea) WITH FUNCTION public.bytea(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS public.geography); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS public.geography) WITH FUNCTION public.geography(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS public.geometry) WITH FUNCTION public.geometry(public.geometry, integer, boolean) AS IMPLICIT;


--
-- Name: CAST (public.geometry AS text); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.geometry AS text) WITH FUNCTION public.text(public.geometry) AS IMPLICIT;


--
-- Name: CAST (public.raster AS public.box3d); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.raster AS public.box3d) WITH FUNCTION public.box3d(public.raster) AS ASSIGNMENT;


--
-- Name: CAST (public.raster AS bytea); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.raster AS bytea) WITH FUNCTION public.bytea(public.raster) AS ASSIGNMENT;


--
-- Name: CAST (public.raster AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (public.raster AS public.geometry) WITH FUNCTION public.st_convexhull(public.raster) AS ASSIGNMENT;


--
-- Name: CAST (text AS public.geometry); Type: CAST; Schema: pg_catalog; Owner: -
--

CREATE CAST (text AS public.geometry) WITH FUNCTION public.geometry(text) AS IMPLICIT;


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: announcements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE announcements (
    id integer NOT NULL,
    placement character varying(255),
    start timestamp without time zone,
    "end" timestamp without time zone,
    body text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE announcements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE announcements_id_seq OWNED BY announcements.id;


--
-- Name: assessment_sections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE assessment_sections (
    id integer NOT NULL,
    assessment_id integer,
    user_id integer,
    title character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    display_order integer
);


--
-- Name: assessment_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE assessment_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assessment_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE assessment_sections_id_seq OWNED BY assessment_sections.id;


--
-- Name: assessments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE assessments (
    id integer NOT NULL,
    taxon_id integer,
    project_id integer,
    user_id integer,
    description text,
    completed_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: assessments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE assessments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assessments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE assessments_id_seq OWNED BY assessments.id;


--
-- Name: colors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE colors (
    id integer NOT NULL,
    value character varying(255)
);


--
-- Name: colors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE colors_id_seq OWNED BY colors.id;


--
-- Name: colors_taxa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE colors_taxa (
    color_id integer,
    taxon_id integer
);


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    user_id integer,
    parent_id integer,
    parent_type character varying(255),
    body text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: conservation_statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE conservation_statuses (
    id integer NOT NULL,
    taxon_id integer,
    user_id integer,
    place_id integer,
    source_id integer,
    authority character varying(255),
    status character varying(255),
    url character varying(512),
    description text,
    geoprivacy character varying(255) DEFAULT 'obscured'::character varying,
    iucn integer DEFAULT 20,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: conservation_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE conservation_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conservation_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE conservation_statuses_id_seq OWNED BY conservation_statuses.id;


--
-- Name: counties_simplified_01; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE counties_simplified_01 (
    id integer NOT NULL,
    place_geometry_id integer,
    place_id integer,
    geom geometry(MultiPolygon) NOT NULL
);


--
-- Name: counties_simplified_01_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE counties_simplified_01_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: counties_simplified_01_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE counties_simplified_01_id_seq OWNED BY counties_simplified_01.id;


--
-- Name: countries_simplified_1; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE countries_simplified_1 (
    id integer NOT NULL,
    place_geometry_id integer,
    place_id integer,
    geom geometry(MultiPolygon) NOT NULL
);


--
-- Name: countries_simplified_1_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE countries_simplified_1_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: countries_simplified_1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE countries_simplified_1_id_seq OWNED BY countries_simplified_1.id;


--
-- Name: custom_projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE custom_projects (
    id integer NOT NULL,
    head text,
    side text,
    css text,
    project_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: custom_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE custom_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE custom_projects_id_seq OWNED BY custom_projects.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0,
    attempts integer DEFAULT 0,
    handler text,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    queue character varying(255)
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: deleted_observations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE deleted_observations (
    id integer NOT NULL,
    user_id integer,
    observation_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: deleted_observations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deleted_observations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deleted_observations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deleted_observations_id_seq OWNED BY deleted_observations.id;


--
-- Name: deleted_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE deleted_users (
    id integer NOT NULL,
    user_id integer,
    login character varying(255),
    email character varying(255),
    user_created_at timestamp without time zone,
    user_updated_at timestamp without time zone,
    observations_count integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: deleted_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deleted_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deleted_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deleted_users_id_seq OWNED BY deleted_users.id;


--
-- Name: flags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE flags (
    id integer NOT NULL,
    flag character varying(255),
    comment character varying(255),
    created_at timestamp without time zone NOT NULL,
    flaggable_id integer DEFAULT 0 NOT NULL,
    flaggable_type character varying(15) NOT NULL,
    user_id integer DEFAULT 0 NOT NULL,
    resolver_id integer,
    resolved boolean DEFAULT false,
    updated_at timestamp without time zone
);


--
-- Name: flags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE flags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE flags_id_seq OWNED BY flags.id;


--
-- Name: flickr_identities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE flickr_identities (
    id integer NOT NULL,
    flickr_username character varying(255),
    frob character varying(255),
    token character varying(255),
    token_created_at timestamp without time zone,
    auto_import integer DEFAULT 0,
    auto_imported_at timestamp without time zone,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    flickr_user_id character varying(255),
    secret character varying(255)
);


--
-- Name: flickr_identities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE flickr_identities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flickr_identities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE flickr_identities_id_seq OWNED BY flickr_identities.id;


--
-- Name: flow_task_resources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE flow_task_resources (
    id integer NOT NULL,
    flow_task_id integer,
    resource_type character varying(255),
    resource_id integer,
    type character varying(255),
    file_file_name character varying(255),
    file_content_type character varying(255),
    file_file_size integer,
    file_updated_at timestamp without time zone,
    extra text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: flow_task_resources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE flow_task_resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flow_task_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE flow_task_resources_id_seq OWNED BY flow_task_resources.id;


--
-- Name: flow_tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE flow_tasks (
    id integer NOT NULL,
    type character varying(255),
    options text,
    command character varying(255),
    error character varying(255),
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    user_id integer,
    redirect_url character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: flow_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE flow_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: flow_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE flow_tasks_id_seq OWNED BY flow_tasks.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE friendly_id_slugs (
    id integer NOT NULL,
    slug character varying(255),
    sluggable_id integer,
    sequence integer DEFAULT 1 NOT NULL,
    sluggable_type character varying(40),
    scope character varying(255),
    created_at timestamp without time zone
);


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE friendly_id_slugs_id_seq OWNED BY friendly_id_slugs.id;


--
-- Name: friendships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE friendships (
    id integer NOT NULL,
    user_id integer,
    friend_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: friendships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE friendships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE friendships_id_seq OWNED BY friendships.id;


--
-- Name: geography_columns; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW geography_columns AS
    SELECT current_database() AS f_table_catalog, n.nspname AS f_table_schema, c.relname AS f_table_name, a.attname AS f_geography_column, postgis_typmod_dims(a.atttypmod) AS coord_dimension, postgis_typmod_srid(a.atttypmod) AS srid, postgis_typmod_type(a.atttypmod) AS type FROM pg_class c, pg_attribute a, pg_type t, pg_namespace n WHERE (((((((t.typname = 'geography'::name) AND (a.attisdropped = false)) AND (a.atttypid = t.oid)) AND (a.attrelid = c.oid)) AND (c.relnamespace = n.oid)) AND (NOT pg_is_other_temp_schema(c.relnamespace))) AND has_table_privilege(c.oid, 'SELECT'::text));


--
-- Name: geometry_columns; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW geometry_columns AS
    SELECT (current_database())::character varying(256) AS f_table_catalog, (n.nspname)::character varying(256) AS f_table_schema, (c.relname)::character varying(256) AS f_table_name, (a.attname)::character varying(256) AS f_geometry_column, COALESCE(NULLIF(postgis_typmod_dims(a.atttypmod), 2), postgis_constraint_dims((n.nspname)::text, (c.relname)::text, (a.attname)::text), 2) AS coord_dimension, COALESCE(NULLIF(postgis_typmod_srid(a.atttypmod), 0), postgis_constraint_srid((n.nspname)::text, (c.relname)::text, (a.attname)::text), 0) AS srid, (replace(replace(COALESCE(NULLIF(upper(postgis_typmod_type(a.atttypmod)), 'GEOMETRY'::text), (postgis_constraint_type((n.nspname)::text, (c.relname)::text, (a.attname)::text))::text, 'GEOMETRY'::text), 'ZM'::text, ''::text), 'Z'::text, ''::text))::character varying(30) AS type FROM pg_class c, pg_attribute a, pg_type t, pg_namespace n WHERE (((((((((t.typname = 'geometry'::name) AND (a.attisdropped = false)) AND (a.atttypid = t.oid)) AND (a.attrelid = c.oid)) AND (c.relnamespace = n.oid)) AND ((c.relkind = 'r'::"char") OR (c.relkind = 'v'::"char"))) AND (NOT pg_is_other_temp_schema(c.relnamespace))) AND (NOT ((n.nspname = 'public'::name) AND (c.relname = 'raster_columns'::name)))) AND has_table_privilege(c.oid, 'SELECT'::text));


--
-- Name: goal_contributions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE goal_contributions (
    id integer NOT NULL,
    contribution_id integer,
    contribution_type character varying(255),
    goal_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    goal_participant_id integer
);


--
-- Name: goal_contributions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goal_contributions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goal_contributions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goal_contributions_id_seq OWNED BY goal_contributions.id;


--
-- Name: goal_participants; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE goal_participants (
    id integer NOT NULL,
    goal_id integer,
    user_id integer,
    goal_completed integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: goal_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goal_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goal_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goal_participants_id_seq OWNED BY goal_participants.id;


--
-- Name: goal_rules; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE goal_rules (
    id integer NOT NULL,
    goal_id integer,
    operator character varying(255),
    operator_class character varying(255),
    arguments character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: goal_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goal_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goal_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goal_rules_id_seq OWNED BY goal_rules.id;


--
-- Name: goals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE goals (
    id integer NOT NULL,
    description text,
    number_of_contributions_required integer,
    goal_type character varying(255),
    ends_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    completed boolean DEFAULT false
);


--
-- Name: goals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goals_id_seq OWNED BY goals.id;


--
-- Name: guide_photos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE guide_photos (
    id integer NOT NULL,
    guide_taxon_id integer,
    title character varying(255),
    description character varying(255),
    photo_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" integer DEFAULT 0
);


--
-- Name: guide_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE guide_photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guide_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE guide_photos_id_seq OWNED BY guide_photos.id;


--
-- Name: guide_ranges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE guide_ranges (
    id integer NOT NULL,
    guide_taxon_id integer,
    medium_url character varying(512),
    thumb_url character varying(512),
    original_url character varying(512),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    license character varying(255),
    source_url character varying(512),
    rights_holder character varying(255),
    source_id integer,
    file_file_name character varying(255),
    file_content_type character varying(255),
    file_file_size integer,
    file_updated_at timestamp without time zone,
    "position" integer DEFAULT 0
);


--
-- Name: guide_ranges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE guide_ranges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guide_ranges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE guide_ranges_id_seq OWNED BY guide_ranges.id;


--
-- Name: guide_sections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE guide_sections (
    id integer NOT NULL,
    guide_taxon_id integer,
    title character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" integer DEFAULT 0,
    license character varying(255),
    source_url character varying(255),
    rights_holder character varying(255),
    source_id integer,
    creator_id integer,
    updater_id integer
);


--
-- Name: guide_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE guide_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guide_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE guide_sections_id_seq OWNED BY guide_sections.id;


--
-- Name: guide_taxa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE guide_taxa (
    id integer NOT NULL,
    guide_id integer,
    taxon_id integer,
    name character varying(255),
    display_name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" integer DEFAULT 0,
    source_identifier character varying(255)
);


--
-- Name: guide_taxa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE guide_taxa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guide_taxa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE guide_taxa_id_seq OWNED BY guide_taxa.id;


--
-- Name: guide_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE guide_users (
    id integer NOT NULL,
    guide_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: guide_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE guide_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guide_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE guide_users_id_seq OWNED BY guide_users.id;


--
-- Name: guides; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE guides (
    id integer NOT NULL,
    title character varying(255),
    description text,
    published_at timestamp without time zone,
    latitude numeric,
    longitude numeric,
    user_id integer,
    place_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    license character varying(255) DEFAULT 'CC-BY-SA'::character varying,
    icon_file_name character varying(255),
    icon_content_type character varying(255),
    icon_file_size integer,
    icon_updated_at timestamp without time zone,
    map_type character varying(255) DEFAULT 'terrain'::character varying,
    zoom_level integer,
    taxon_id integer,
    source_url character varying(255),
    downloadable boolean DEFAULT false,
    ngz_file_name character varying(255),
    ngz_content_type character varying(255),
    ngz_file_size integer,
    ngz_updated_at timestamp without time zone
);


--
-- Name: guides_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE guides_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: guides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE guides_id_seq OWNED BY guides.id;


--
-- Name: identifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE identifications (
    id integer NOT NULL,
    observation_id integer,
    taxon_id integer,
    user_id integer,
    type character varying(255),
    body text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    current boolean DEFAULT true,
    taxon_change_id integer
);


--
-- Name: identifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE identifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: identifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE identifications_id_seq OWNED BY identifications.id;


--
-- Name: invites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE invites (
    id integer NOT NULL,
    user_id integer,
    invite_address character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: invites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE invites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE invites_id_seq OWNED BY invites.id;


--
-- Name: list_rules; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE list_rules (
    id integer NOT NULL,
    list_id integer,
    operator character varying(255),
    operand_id integer,
    operand_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: list_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE list_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: list_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE list_rules_id_seq OWNED BY list_rules.id;


--
-- Name: listed_taxa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE listed_taxa (
    id integer NOT NULL,
    taxon_id integer,
    list_id integer,
    last_observation_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    taxon_ancestor_ids character varying(255),
    place_id integer,
    description text,
    comments_count integer DEFAULT 0,
    user_id integer,
    updater_id integer,
    occurrence_status_level integer,
    establishment_means character varying(32),
    first_observation_id integer,
    observations_count integer DEFAULT 0,
    observations_month_counts character varying(255),
    taxon_range_id integer,
    source_id integer,
    manually_added boolean DEFAULT false,
    primary_listing boolean DEFAULT true
);


--
-- Name: listed_taxa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE listed_taxa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: listed_taxa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE listed_taxa_id_seq OWNED BY listed_taxa.id;


--
-- Name: lists; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lists (
    id integer NOT NULL,
    title character varying(255),
    description text,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    type character varying(255),
    comprehensive boolean DEFAULT false,
    taxon_id integer,
    last_synced_at timestamp without time zone,
    place_id integer,
    project_id integer,
    source_id integer,
    show_obs_photos boolean DEFAULT true
);


--
-- Name: lists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lists_id_seq OWNED BY lists.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE messages (
    id integer NOT NULL,
    user_id integer,
    from_user_id integer,
    to_user_id integer,
    thread_id integer,
    subject character varying(255),
    body text,
    read_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: oauth_access_grants; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oauth_access_grants (
    id integer NOT NULL,
    resource_owner_id integer NOT NULL,
    application_id integer NOT NULL,
    token character varying(255) NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    scopes character varying(255)
);


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth_access_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth_access_grants_id_seq OWNED BY oauth_access_grants.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oauth_access_tokens (
    id integer NOT NULL,
    resource_owner_id integer,
    application_id integer NOT NULL,
    token character varying(255) NOT NULL,
    refresh_token character varying(255),
    expires_in integer,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    scopes character varying(255)
);


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth_access_tokens_id_seq OWNED BY oauth_access_tokens.id;


--
-- Name: oauth_applications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE oauth_applications (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    redirect_uri character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    owner_id integer,
    owner_type character varying(255),
    trusted boolean DEFAULT false,
    image_file_name character varying(255),
    image_content_type character varying(255),
    image_file_size integer,
    image_updated_at timestamp without time zone,
    url character varying(255),
    description text
);


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE oauth_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE oauth_applications_id_seq OWNED BY oauth_applications.id;


--
-- Name: observation_field_values; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_field_values (
    id integer NOT NULL,
    observation_id integer,
    observation_field_id integer,
    value character varying(2048),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    updater_id integer
);


--
-- Name: observation_field_values_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE observation_field_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: observation_field_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE observation_field_values_id_seq OWNED BY observation_field_values.id;


--
-- Name: observation_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_fields (
    id integer NOT NULL,
    name character varying(255),
    datatype character varying(255),
    user_id integer,
    description character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    allowed_values text
);


--
-- Name: observation_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE observation_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: observation_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE observation_fields_id_seq OWNED BY observation_fields.id;


--
-- Name: observation_links; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_links (
    id integer NOT NULL,
    observation_id integer,
    rel character varying(255),
    href character varying(255),
    href_name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: observation_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE observation_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: observation_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE observation_links_id_seq OWNED BY observation_links.id;


--
-- Name: observation_photos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_photos (
    id integer NOT NULL,
    observation_id integer NOT NULL,
    photo_id integer NOT NULL,
    "position" integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    uuid character varying(255)
);


--
-- Name: observation_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE observation_photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: observation_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE observation_photos_id_seq OWNED BY observation_photos.id;


--
-- Name: observation_sounds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_sounds (
    id integer NOT NULL,
    observation_id integer,
    sound_id integer
);


--
-- Name: observation_sounds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE observation_sounds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: observation_sounds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE observation_sounds_id_seq OWNED BY observation_sounds.id;


--
-- Name: observation_zooms_10; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_10 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_11; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_11 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_12; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_12 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_125; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_125 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_2; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_2 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_2000; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_2000 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_250; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_250 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_3; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_3 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_4; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_4 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_4000; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_4000 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_5; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_5 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_500; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_500 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_6; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_6 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_63; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_63 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_7; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_7 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_8; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_8 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_9; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_9 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observation_zooms_990; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observation_zooms_990 (
    taxon_id integer,
    geom geometry,
    count integer NOT NULL
);


--
-- Name: observations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observations (
    id integer NOT NULL,
    observed_on date,
    description text,
    latitude numeric(15,10),
    longitude numeric(15,10),
    map_scale integer,
    timeframe text,
    species_guess character varying(255),
    user_id integer,
    taxon_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    place_guess character varying(255),
    id_please boolean DEFAULT false,
    observed_on_string character varying(255),
    iconic_taxon_id integer,
    num_identification_agreements integer DEFAULT 0,
    num_identification_disagreements integer DEFAULT 0,
    time_observed_at timestamp without time zone,
    time_zone character varying(255),
    location_is_exact boolean DEFAULT false,
    delta boolean DEFAULT false,
    positional_accuracy integer,
    private_latitude numeric(15,10),
    private_longitude numeric(15,10),
    private_positional_accuracy integer,
    geoprivacy character varying(255),
    quality_grade character varying(255) DEFAULT 'casual'::character varying,
    user_agent character varying(255),
    positioning_method character varying(255),
    positioning_device character varying(255),
    out_of_range boolean,
    license character varying(255),
    uri character varying(255),
    observation_photos_count integer DEFAULT 0,
    comments_count integer DEFAULT 0,
    geom geometry(Point),
    cached_tag_list character varying(768) DEFAULT NULL::character varying,
    zic_time_zone character varying(255),
    oauth_application_id integer,
    observation_sounds_count integer DEFAULT 0,
    identifications_count integer DEFAULT 0,
    private_geom geometry(Point),
    community_taxon_id integer,
    captive boolean DEFAULT false,
    site_id integer,
    uuid character varying(255),
    public_positional_accuracy integer,
    mappable boolean DEFAULT false
);


--
-- Name: observations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE observations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: observations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE observations_id_seq OWNED BY observations.id;


--
-- Name: observations_places; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observations_places (
    id integer NOT NULL,
    observation_id integer NOT NULL,
    place_id integer NOT NULL
);


--
-- Name: observations_places_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE observations_places_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: observations_places_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE observations_places_id_seq OWNED BY observations_places.id;


--
-- Name: observations_posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE observations_posts (
    observation_id integer NOT NULL,
    post_id integer NOT NULL
);


--
-- Name: passwords; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE passwords (
    id integer NOT NULL,
    user_id integer,
    reset_code character varying(255),
    expiration_date timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: passwords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE passwords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: passwords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE passwords_id_seq OWNED BY passwords.id;


--
-- Name: photos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE photos (
    id integer NOT NULL,
    user_id integer,
    native_photo_id character varying(255),
    square_url character varying(255),
    thumb_url character varying(255),
    small_url character varying(255),
    medium_url character varying(255),
    large_url character varying(255),
    original_url character varying(512),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    native_page_url character varying(255),
    native_username character varying(255),
    native_realname character varying(255),
    license integer,
    type character varying(255),
    file_content_type character varying(255),
    file_file_name character varying(255),
    file_file_size integer,
    file_processing boolean,
    mobile boolean DEFAULT false,
    file_updated_at timestamp without time zone,
    metadata text
);


--
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE photos_id_seq OWNED BY photos.id;


--
-- Name: picasa_identities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE picasa_identities (
    id integer NOT NULL,
    user_id integer,
    token character varying(255),
    token_created_at timestamp without time zone,
    picasa_user_id character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: picasa_identities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE picasa_identities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: picasa_identities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE picasa_identities_id_seq OWNED BY picasa_identities.id;


--
-- Name: place_geometries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE place_geometries (
    id integer NOT NULL,
    place_id integer,
    source_name character varying(255),
    source_identifier character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    source_filename character varying(255),
    geom geometry(MultiPolygon) NOT NULL,
    source_id integer
);


--
-- Name: place_geometries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE place_geometries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_geometries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE place_geometries_id_seq OWNED BY place_geometries.id;


--
-- Name: place_taxon_names; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE place_taxon_names (
    id integer NOT NULL,
    place_id integer,
    taxon_name_id integer,
    "position" integer DEFAULT 0
);


--
-- Name: place_taxon_names_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE place_taxon_names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_taxon_names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE place_taxon_names_id_seq OWNED BY place_taxon_names.id;


--
-- Name: places; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE places (
    id integer NOT NULL,
    name character varying(255),
    display_name character varying(255),
    code character varying(255),
    latitude numeric(15,10),
    longitude numeric(15,10),
    swlat numeric(15,10),
    swlng numeric(15,10),
    nelat numeric(15,10),
    nelng numeric(15,10),
    woeid integer,
    parent_id integer,
    check_list_id integer,
    place_type integer,
    bbox_area double precision,
    source_name character varying(255),
    source_identifier character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    delta boolean DEFAULT false,
    user_id integer,
    source_filename character varying(255),
    ancestry character varying(255),
    slug character varying(255),
    source_id integer,
    admin_level integer
);


--
-- Name: places_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE places_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: places_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE places_id_seq OWNED BY places.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    parent_id integer NOT NULL,
    parent_type character varying(255) NOT NULL,
    user_id integer NOT NULL,
    published_at timestamp without time zone,
    title character varying(255) NOT NULL,
    body text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    type character varying(255),
    start_time timestamp without time zone,
    stop_time timestamp without time zone,
    place_id integer,
    latitude numeric(15,10),
    longitude numeric(15,10),
    radius integer
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE preferences (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    owner_id integer NOT NULL,
    owner_type character varying(255) NOT NULL,
    group_id integer,
    group_type character varying(255),
    value text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE preferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE preferences_id_seq OWNED BY preferences.id;


--
-- Name: project_assets; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_assets (
    id integer NOT NULL,
    project_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    asset_file_name character varying(255),
    asset_content_type character varying(255),
    asset_file_size integer,
    asset_updated_at timestamp without time zone
);


--
-- Name: project_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_assets_id_seq OWNED BY project_assets.id;


--
-- Name: project_invitations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_invitations (
    id integer NOT NULL,
    project_id integer,
    user_id integer,
    observation_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: project_invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_invitations_id_seq OWNED BY project_invitations.id;


--
-- Name: project_observation_fields; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_observation_fields (
    id integer NOT NULL,
    project_id integer,
    observation_field_id integer,
    required boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" integer
);


--
-- Name: project_observation_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_observation_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_observation_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_observation_fields_id_seq OWNED BY project_observation_fields.id;


--
-- Name: project_observations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_observations (
    id integer NOT NULL,
    project_id integer,
    observation_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    curator_identification_id integer,
    tracking_code character varying(255)
);


--
-- Name: project_observations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_observations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_observations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_observations_id_seq OWNED BY project_observations.id;


--
-- Name: project_user_invitations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_user_invitations (
    id integer NOT NULL,
    user_id integer,
    invited_user_id integer,
    project_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: project_user_invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_user_invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_user_invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_user_invitations_id_seq OWNED BY project_user_invitations.id;


--
-- Name: project_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_users (
    id integer NOT NULL,
    project_id integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    role character varying(255),
    observations_count integer DEFAULT 0,
    taxa_count integer DEFAULT 0
);


--
-- Name: project_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: project_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE project_users_id_seq OWNED BY project_users.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    user_id integer,
    title character varying(255),
    description text,
    terms text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    icon_file_name character varying(255),
    icon_content_type character varying(255),
    icon_file_size integer,
    icon_updated_at timestamp without time zone,
    project_type character varying(255),
    slug character varying(255),
    observed_taxa_count integer DEFAULT 0,
    featured_at timestamp without time zone,
    source_url character varying(255),
    tracking_codes character varying(255),
    delta boolean DEFAULT false,
    place_id integer,
    map_type character varying(255) DEFAULT 'terrain'::character varying,
    latitude numeric(15,10),
    longitude numeric(15,10),
    zoom_level integer,
    cover_file_name character varying(255),
    cover_content_type character varying(255),
    cover_file_size integer,
    cover_updated_at timestamp without time zone,
    event_url character varying(255),
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    trusted boolean DEFAULT false,
    "group" character varying(255),
    show_from_place boolean,
    parent_id integer
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: provider_authorizations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE provider_authorizations (
    id integer NOT NULL,
    provider_name character varying(255) NOT NULL,
    provider_uid text,
    token text,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    scope character varying(255),
    secret character varying(255)
);


--
-- Name: provider_authorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE provider_authorizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: provider_authorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE provider_authorizations_id_seq OWNED BY provider_authorizations.id;


--
-- Name: quality_metrics; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE quality_metrics (
    id integer NOT NULL,
    user_id integer,
    observation_id integer,
    metric character varying(255),
    agree boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: quality_metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE quality_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quality_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE quality_metrics_id_seq OWNED BY quality_metrics.id;


--
-- Name: raster_columns; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW raster_columns AS
    SELECT current_database() AS r_table_catalog, n.nspname AS r_table_schema, c.relname AS r_table_name, a.attname AS r_raster_column, COALESCE(_raster_constraint_info_srid(n.nspname, c.relname, a.attname), (SELECT st_srid('010100000000000000000000000000000000000000'::geometry) AS st_srid)) AS srid, _raster_constraint_info_scale(n.nspname, c.relname, a.attname, 'x'::bpchar) AS scale_x, _raster_constraint_info_scale(n.nspname, c.relname, a.attname, 'y'::bpchar) AS scale_y, _raster_constraint_info_blocksize(n.nspname, c.relname, a.attname, 'width'::text) AS blocksize_x, _raster_constraint_info_blocksize(n.nspname, c.relname, a.attname, 'height'::text) AS blocksize_y, COALESCE(_raster_constraint_info_alignment(n.nspname, c.relname, a.attname), false) AS same_alignment, COALESCE(_raster_constraint_info_regular_blocking(n.nspname, c.relname, a.attname), false) AS regular_blocking, _raster_constraint_info_num_bands(n.nspname, c.relname, a.attname) AS num_bands, _raster_constraint_info_pixel_types(n.nspname, c.relname, a.attname) AS pixel_types, _raster_constraint_info_nodata_values(n.nspname, c.relname, a.attname) AS nodata_values, _raster_constraint_info_out_db(n.nspname, c.relname, a.attname) AS out_db, _raster_constraint_info_extent(n.nspname, c.relname, a.attname) AS extent FROM pg_class c, pg_attribute a, pg_type t, pg_namespace n WHERE (((((((t.typname = 'raster'::name) AND (a.attisdropped = false)) AND (a.atttypid = t.oid)) AND (a.attrelid = c.oid)) AND (c.relnamespace = n.oid)) AND ((c.relkind = 'r'::"char") OR (c.relkind = 'v'::"char"))) AND (NOT pg_is_other_temp_schema(c.relnamespace)));


--
-- Name: raster_overviews; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW raster_overviews AS
    SELECT current_database() AS o_table_catalog, n.nspname AS o_table_schema, c.relname AS o_table_name, a.attname AS o_raster_column, current_database() AS r_table_catalog, (split_part(split_part(s.consrc, '''::name'::text, 1), ''''::text, 2))::name AS r_table_schema, (split_part(split_part(s.consrc, '''::name'::text, 2), ''''::text, 2))::name AS r_table_name, (split_part(split_part(s.consrc, '''::name'::text, 3), ''''::text, 2))::name AS r_raster_column, (btrim(split_part(s.consrc, ','::text, 2)))::integer AS overview_factor FROM pg_class c, pg_attribute a, pg_type t, pg_namespace n, pg_constraint s WHERE ((((((((((t.typname = 'raster'::name) AND (a.attisdropped = false)) AND (a.atttypid = t.oid)) AND (a.attrelid = c.oid)) AND (c.relnamespace = n.oid)) AND ((c.relkind = 'r'::"char") OR (c.relkind = 'v'::"char"))) AND (s.connamespace = n.oid)) AND (s.conrelid = c.oid)) AND (s.consrc ~~ '%_overview_constraint(%'::text)) AND (NOT pg_is_other_temp_schema(c.relnamespace)));


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: roles_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles_users (
    role_id integer,
    user_id integer
);


--
-- Name: rules; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rules (
    id integer NOT NULL,
    type character varying(255),
    ruler_type character varying(255),
    ruler_id integer,
    operand_type character varying(255),
    operand_id integer,
    operator character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rules_id_seq OWNED BY rules.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: site_admins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE site_admins (
    id integer NOT NULL,
    user_id integer,
    site_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: site_admins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE site_admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE site_admins_id_seq OWNED BY site_admins.id;


--
-- Name: sites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sites (
    id integer NOT NULL,
    name character varying(255),
    url character varying(255),
    place_id integer,
    source_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    logo_file_name character varying(255),
    logo_content_type character varying(255),
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    logo_square_file_name character varying(255),
    logo_square_content_type character varying(255),
    logo_square_file_size integer,
    logo_square_updated_at timestamp without time zone,
    stylesheet_file_name character varying(255),
    stylesheet_content_type character varying(255),
    stylesheet_file_size integer,
    stylesheet_updated_at timestamp without time zone
);


--
-- Name: sites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sites_id_seq OWNED BY sites.id;


--
-- Name: soundcloud_identities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE soundcloud_identities (
    id integer NOT NULL,
    native_username character varying(255),
    native_realname character varying(255),
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: soundcloud_identities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE soundcloud_identities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: soundcloud_identities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE soundcloud_identities_id_seq OWNED BY soundcloud_identities.id;


--
-- Name: sounds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sounds (
    id integer NOT NULL,
    user_id integer,
    native_username character varying(255),
    native_realname character varying(255),
    native_sound_id character varying(255),
    native_page_url character varying(255),
    license integer,
    type character varying(255),
    sound_url character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    native_response text
);


--
-- Name: sounds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sounds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sounds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sounds_id_seq OWNED BY sounds.id;


--
-- Name: sources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sources (
    id integer NOT NULL,
    in_text character varying(255),
    citation character varying(512),
    url character varying(512),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    title character varying(255),
    user_id integer
);


--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sources_id_seq OWNED BY sources.id;


--
-- Name: spatial_ref_sys; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spatial_ref_sys (
    srid integer NOT NULL,
    auth_name character varying(256),
    auth_srid integer,
    srtext character varying(2048),
    proj4text character varying(2048),
    CONSTRAINT spatial_ref_sys_srid_check CHECK (((srid > 0) AND (srid <= 998999)))
);


--
-- Name: states_simplified_1; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE states_simplified_1 (
    id integer NOT NULL,
    place_geometry_id integer,
    place_id integer,
    geom geometry(MultiPolygon) NOT NULL
);


--
-- Name: states_simplified_1_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE states_simplified_1_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: states_simplified_1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE states_simplified_1_id_seq OWNED BY states_simplified_1.id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE subscriptions (
    id integer NOT NULL,
    user_id integer,
    resource_type character varying(255),
    resource_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    taxon_id integer
);


--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE subscriptions_id_seq OWNED BY subscriptions.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    created_at timestamp without time zone
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: taxa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxa (
    id integer NOT NULL,
    name character varying(255),
    rank character varying(255),
    source_identifier character varying(255),
    source_url character varying(255),
    parent_id integer,
    source_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    iconic_taxon_id integer,
    is_iconic boolean DEFAULT false,
    auto_photos boolean DEFAULT true,
    auto_description boolean DEFAULT true,
    version integer,
    name_provider character varying(255),
    delta boolean DEFAULT false,
    creator_id integer,
    updater_id integer,
    observations_count integer DEFAULT 0,
    listed_taxa_count integer DEFAULT 0,
    rank_level integer,
    unique_name character varying(255),
    wikipedia_summary text,
    wikipedia_title character varying(255),
    featured_at timestamp without time zone,
    ancestry character varying(255),
    conservation_status integer,
    conservation_status_source_id integer,
    locked boolean DEFAULT false NOT NULL,
    conservation_status_source_identifier integer,
    is_active boolean DEFAULT true NOT NULL
);


--
-- Name: taxa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxa_id_seq OWNED BY taxa.id;


--
-- Name: taxon_ancestors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_ancestors (
    taxon_id integer NOT NULL,
    ancestor_taxon_id integer NOT NULL
);


--
-- Name: taxon_change_taxa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_change_taxa (
    id integer NOT NULL,
    taxon_change_id integer,
    taxon_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: taxon_change_taxa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_change_taxa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxon_change_taxa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_change_taxa_id_seq OWNED BY taxon_change_taxa.id;


--
-- Name: taxon_changes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_changes (
    id integer NOT NULL,
    description text,
    taxon_id integer,
    source_id integer,
    user_id integer,
    type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    committed_on date,
    change_group character varying(255),
    committer_id integer
);


--
-- Name: taxon_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxon_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_changes_id_seq OWNED BY taxon_changes.id;


--
-- Name: taxon_descriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_descriptions (
    id integer NOT NULL,
    taxon_id integer,
    locale character varying(255),
    body text
);


--
-- Name: taxon_descriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_descriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxon_descriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_descriptions_id_seq OWNED BY taxon_descriptions.id;


--
-- Name: taxon_links; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_links (
    id integer NOT NULL,
    url character varying(255) NOT NULL,
    site_title character varying(255),
    taxon_id integer NOT NULL,
    show_for_descendent_taxa boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer,
    place_id integer,
    species_only boolean DEFAULT false,
    short_title character varying(10)
);


--
-- Name: taxon_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxon_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_links_id_seq OWNED BY taxon_links.id;


--
-- Name: taxon_names; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_names (
    id integer NOT NULL,
    name character varying(255),
    is_valid boolean,
    lexicon character varying(255),
    source_identifier character varying(255),
    source_url character varying(255),
    taxon_id integer,
    source_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name_provider character varying(255),
    creator_id integer,
    updater_id integer,
    "position" integer DEFAULT 0
);


--
-- Name: taxon_names_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxon_names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_names_id_seq OWNED BY taxon_names.id;


--
-- Name: taxon_photos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_photos (
    id integer NOT NULL,
    taxon_id integer NOT NULL,
    photo_id integer NOT NULL,
    "position" integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: taxon_photos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxon_photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_photos_id_seq OWNED BY taxon_photos.id;


--
-- Name: taxon_ranges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_ranges (
    id integer NOT NULL,
    taxon_id integer,
    source character varying(255),
    start_month integer,
    end_month integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    range_type character varying(255),
    range_content_type character varying(255),
    range_file_name character varying(255),
    range_file_size integer,
    description text,
    source_id integer,
    source_identifier integer,
    range_updated_at timestamp without time zone,
    geom geometry(MultiPolygon),
    url character varying(255)
);


--
-- Name: taxon_ranges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_ranges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxon_ranges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_ranges_id_seq OWNED BY taxon_ranges.id;


--
-- Name: taxon_scheme_taxa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_scheme_taxa (
    id integer NOT NULL,
    taxon_scheme_id integer,
    taxon_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    source_identifier character varying(255),
    taxon_name_id integer
);


--
-- Name: taxon_scheme_taxa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_scheme_taxa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxon_scheme_taxa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_scheme_taxa_id_seq OWNED BY taxon_scheme_taxa.id;


--
-- Name: taxon_schemes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_schemes (
    id integer NOT NULL,
    title character varying(255),
    description text,
    source_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: taxon_schemes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_schemes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxon_schemes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_schemes_id_seq OWNED BY taxon_schemes.id;


--
-- Name: taxon_versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxon_versions (
    id integer NOT NULL,
    taxon_id integer,
    version integer,
    name character varying(255),
    rank character varying(255),
    source_identifier character varying(255),
    source_url character varying(255),
    parent_id integer,
    source_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    iconic_taxon_id integer,
    is_iconic boolean DEFAULT false,
    auto_photos boolean DEFAULT true,
    auto_description boolean DEFAULT true,
    lft integer,
    rgt integer,
    name_provider character varying(255),
    delta boolean DEFAULT false,
    creator_id integer,
    updater_id integer,
    rank_level integer
);


--
-- Name: taxon_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxon_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxon_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxon_versions_id_seq OWNED BY taxon_versions.id;


--
-- Name: trip_purposes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trip_purposes (
    id integer NOT NULL,
    trip_id integer,
    purpose character varying(255),
    resource_type character varying(255),
    resource_id integer,
    success boolean,
    complete boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: trip_purposes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE trip_purposes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trip_purposes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE trip_purposes_id_seq OWNED BY trip_purposes.id;


--
-- Name: trip_taxa; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE trip_taxa (
    id integer NOT NULL,
    taxon_id integer,
    trip_id integer,
    observed boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: trip_taxa_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE trip_taxa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trip_taxa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE trip_taxa_id_seq OWNED BY trip_taxa.id;


--
-- Name: updates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE updates (
    id integer NOT NULL,
    subscriber_id integer,
    resource_id integer,
    resource_type character varying(255),
    notifier_type character varying(255),
    notifier_id integer,
    notification character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    resource_owner_id integer,
    viewed_at timestamp without time zone
);


--
-- Name: updates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE updates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: updates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE updates_id_seq OWNED BY updates.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    login character varying(40),
    name character varying(100),
    email character varying(100),
    encrypted_password character varying(128) DEFAULT ''::character varying NOT NULL,
    password_salt character varying(255) DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    remember_token character varying(40),
    remember_token_expires_at timestamp without time zone,
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    state character varying(255) DEFAULT 'passive'::character varying,
    deleted_at timestamp without time zone,
    time_zone character varying(255),
    description text,
    icon_file_name character varying(255),
    icon_content_type character varying(255),
    icon_file_size integer,
    life_list_id integer,
    observations_count integer DEFAULT 0,
    identifications_count integer DEFAULT 0,
    journal_posts_count integer DEFAULT 0,
    life_list_taxa_count integer DEFAULT 0,
    old_preferences text,
    icon_url character varying(255),
    last_ip character varying(255),
    confirmation_sent_at timestamp without time zone,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    suspended_at timestamp without time zone,
    suspension_reason character varying(255),
    icon_updated_at timestamp without time zone,
    uri character varying(255),
    locale character varying(255),
    site_id integer,
    place_id integer,
    spammer boolean,
    spam_count integer DEFAULT 0
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: wiki_page_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wiki_page_attachments (
    id integer NOT NULL,
    page_id integer NOT NULL,
    wiki_page_attachment_file_name character varying(255),
    wiki_page_attachment_content_type character varying(255),
    wiki_page_attachment_file_size integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: wiki_page_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wiki_page_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_page_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wiki_page_attachments_id_seq OWNED BY wiki_page_attachments.id;


--
-- Name: wiki_page_versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wiki_page_versions (
    id integer NOT NULL,
    page_id integer NOT NULL,
    updator_id integer,
    number integer,
    comment character varying(255),
    path character varying(255),
    title character varying(255),
    content text,
    updated_at timestamp without time zone
);


--
-- Name: wiki_page_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wiki_page_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_page_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wiki_page_versions_id_seq OWNED BY wiki_page_versions.id;


--
-- Name: wiki_pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wiki_pages (
    id integer NOT NULL,
    creator_id integer,
    updator_id integer,
    path character varying(255),
    title character varying(255),
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: wiki_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wiki_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wiki_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wiki_pages_id_seq OWNED BY wiki_pages.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY announcements ALTER COLUMN id SET DEFAULT nextval('announcements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY assessment_sections ALTER COLUMN id SET DEFAULT nextval('assessment_sections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY assessments ALTER COLUMN id SET DEFAULT nextval('assessments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY colors ALTER COLUMN id SET DEFAULT nextval('colors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY conservation_statuses ALTER COLUMN id SET DEFAULT nextval('conservation_statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY counties_simplified_01 ALTER COLUMN id SET DEFAULT nextval('counties_simplified_01_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY countries_simplified_1 ALTER COLUMN id SET DEFAULT nextval('countries_simplified_1_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY custom_projects ALTER COLUMN id SET DEFAULT nextval('custom_projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY deleted_observations ALTER COLUMN id SET DEFAULT nextval('deleted_observations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY deleted_users ALTER COLUMN id SET DEFAULT nextval('deleted_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY flags ALTER COLUMN id SET DEFAULT nextval('flags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY flickr_identities ALTER COLUMN id SET DEFAULT nextval('flickr_identities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY flow_task_resources ALTER COLUMN id SET DEFAULT nextval('flow_task_resources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY flow_tasks ALTER COLUMN id SET DEFAULT nextval('flow_tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('friendly_id_slugs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendships ALTER COLUMN id SET DEFAULT nextval('friendships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_contributions ALTER COLUMN id SET DEFAULT nextval('goal_contributions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_participants ALTER COLUMN id SET DEFAULT nextval('goal_participants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goal_rules ALTER COLUMN id SET DEFAULT nextval('goal_rules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goals ALTER COLUMN id SET DEFAULT nextval('goals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY guide_photos ALTER COLUMN id SET DEFAULT nextval('guide_photos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY guide_ranges ALTER COLUMN id SET DEFAULT nextval('guide_ranges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY guide_sections ALTER COLUMN id SET DEFAULT nextval('guide_sections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY guide_taxa ALTER COLUMN id SET DEFAULT nextval('guide_taxa_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY guide_users ALTER COLUMN id SET DEFAULT nextval('guide_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY guides ALTER COLUMN id SET DEFAULT nextval('guides_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY identifications ALTER COLUMN id SET DEFAULT nextval('identifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY invites ALTER COLUMN id SET DEFAULT nextval('invites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY list_rules ALTER COLUMN id SET DEFAULT nextval('list_rules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY listed_taxa ALTER COLUMN id SET DEFAULT nextval('listed_taxa_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lists ALTER COLUMN id SET DEFAULT nextval('lists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('oauth_access_grants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('oauth_access_tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY oauth_applications ALTER COLUMN id SET DEFAULT nextval('oauth_applications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY observation_field_values ALTER COLUMN id SET DEFAULT nextval('observation_field_values_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY observation_fields ALTER COLUMN id SET DEFAULT nextval('observation_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY observation_links ALTER COLUMN id SET DEFAULT nextval('observation_links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY observation_photos ALTER COLUMN id SET DEFAULT nextval('observation_photos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY observation_sounds ALTER COLUMN id SET DEFAULT nextval('observation_sounds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY observations ALTER COLUMN id SET DEFAULT nextval('observations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY observations_places ALTER COLUMN id SET DEFAULT nextval('observations_places_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY passwords ALTER COLUMN id SET DEFAULT nextval('passwords_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY picasa_identities ALTER COLUMN id SET DEFAULT nextval('picasa_identities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY place_geometries ALTER COLUMN id SET DEFAULT nextval('place_geometries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY place_taxon_names ALTER COLUMN id SET DEFAULT nextval('place_taxon_names_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY places ALTER COLUMN id SET DEFAULT nextval('places_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY preferences ALTER COLUMN id SET DEFAULT nextval('preferences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_assets ALTER COLUMN id SET DEFAULT nextval('project_assets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_invitations ALTER COLUMN id SET DEFAULT nextval('project_invitations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_observation_fields ALTER COLUMN id SET DEFAULT nextval('project_observation_fields_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_observations ALTER COLUMN id SET DEFAULT nextval('project_observations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_user_invitations ALTER COLUMN id SET DEFAULT nextval('project_user_invitations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_users ALTER COLUMN id SET DEFAULT nextval('project_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY provider_authorizations ALTER COLUMN id SET DEFAULT nextval('provider_authorizations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY quality_metrics ALTER COLUMN id SET DEFAULT nextval('quality_metrics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rules ALTER COLUMN id SET DEFAULT nextval('rules_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY site_admins ALTER COLUMN id SET DEFAULT nextval('site_admins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sites ALTER COLUMN id SET DEFAULT nextval('sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY soundcloud_identities ALTER COLUMN id SET DEFAULT nextval('soundcloud_identities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sounds ALTER COLUMN id SET DEFAULT nextval('sounds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sources ALTER COLUMN id SET DEFAULT nextval('sources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY states_simplified_1 ALTER COLUMN id SET DEFAULT nextval('states_simplified_1_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY subscriptions ALTER COLUMN id SET DEFAULT nextval('subscriptions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxa ALTER COLUMN id SET DEFAULT nextval('taxa_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon_change_taxa ALTER COLUMN id SET DEFAULT nextval('taxon_change_taxa_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon_changes ALTER COLUMN id SET DEFAULT nextval('taxon_changes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon_descriptions ALTER COLUMN id SET DEFAULT nextval('taxon_descriptions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon_links ALTER COLUMN id SET DEFAULT nextval('taxon_links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon_names ALTER COLUMN id SET DEFAULT nextval('taxon_names_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon_photos ALTER COLUMN id SET DEFAULT nextval('taxon_photos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon_ranges ALTER COLUMN id SET DEFAULT nextval('taxon_ranges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon_scheme_taxa ALTER COLUMN id SET DEFAULT nextval('taxon_scheme_taxa_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon_schemes ALTER COLUMN id SET DEFAULT nextval('taxon_schemes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxon_versions ALTER COLUMN id SET DEFAULT nextval('taxon_versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY trip_purposes ALTER COLUMN id SET DEFAULT nextval('trip_purposes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY trip_taxa ALTER COLUMN id SET DEFAULT nextval('trip_taxa_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY updates ALTER COLUMN id SET DEFAULT nextval('updates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wiki_page_attachments ALTER COLUMN id SET DEFAULT nextval('wiki_page_attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wiki_page_versions ALTER COLUMN id SET DEFAULT nextval('wiki_page_versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wiki_pages ALTER COLUMN id SET DEFAULT nextval('wiki_pages_id_seq'::regclass);


--
-- Name: announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY announcements
    ADD CONSTRAINT announcements_pkey PRIMARY KEY (id);


--
-- Name: assessment_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY assessment_sections
    ADD CONSTRAINT assessment_sections_pkey PRIMARY KEY (id);


--
-- Name: assessments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY assessments
    ADD CONSTRAINT assessments_pkey PRIMARY KEY (id);


--
-- Name: colors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY colors
    ADD CONSTRAINT colors_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: conservation_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY conservation_statuses
    ADD CONSTRAINT conservation_statuses_pkey PRIMARY KEY (id);


--
-- Name: counties_simplified_01_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY counties_simplified_01
    ADD CONSTRAINT counties_simplified_01_pkey PRIMARY KEY (id);


--
-- Name: countries_simplified_1_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY countries_simplified_1
    ADD CONSTRAINT countries_simplified_1_pkey PRIMARY KEY (id);


--
-- Name: custom_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY custom_projects
    ADD CONSTRAINT custom_projects_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: deleted_observations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY deleted_observations
    ADD CONSTRAINT deleted_observations_pkey PRIMARY KEY (id);


--
-- Name: deleted_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY deleted_users
    ADD CONSTRAINT deleted_users_pkey PRIMARY KEY (id);


--
-- Name: flags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY flags
    ADD CONSTRAINT flags_pkey PRIMARY KEY (id);


--
-- Name: flickr_identities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY flickr_identities
    ADD CONSTRAINT flickr_identities_pkey PRIMARY KEY (id);


--
-- Name: flow_task_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY flow_task_resources
    ADD CONSTRAINT flow_task_resources_pkey PRIMARY KEY (id);


--
-- Name: flow_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY flow_tasks
    ADD CONSTRAINT flow_tasks_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: friendships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY friendships
    ADD CONSTRAINT friendships_pkey PRIMARY KEY (id);


--
-- Name: goal_contributions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY goal_contributions
    ADD CONSTRAINT goal_contributions_pkey PRIMARY KEY (id);


--
-- Name: goal_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY goal_participants
    ADD CONSTRAINT goal_participants_pkey PRIMARY KEY (id);


--
-- Name: goal_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY goal_rules
    ADD CONSTRAINT goal_rules_pkey PRIMARY KEY (id);


--
-- Name: goals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY goals
    ADD CONSTRAINT goals_pkey PRIMARY KEY (id);


--
-- Name: guide_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY guide_photos
    ADD CONSTRAINT guide_photos_pkey PRIMARY KEY (id);


--
-- Name: guide_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY guide_ranges
    ADD CONSTRAINT guide_ranges_pkey PRIMARY KEY (id);


--
-- Name: guide_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY guide_sections
    ADD CONSTRAINT guide_sections_pkey PRIMARY KEY (id);


--
-- Name: guide_taxa_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY guide_taxa
    ADD CONSTRAINT guide_taxa_pkey PRIMARY KEY (id);


--
-- Name: guide_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY guide_users
    ADD CONSTRAINT guide_users_pkey PRIMARY KEY (id);


--
-- Name: guides_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY guides
    ADD CONSTRAINT guides_pkey PRIMARY KEY (id);


--
-- Name: identifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY identifications
    ADD CONSTRAINT identifications_pkey PRIMARY KEY (id);


--
-- Name: invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY invites
    ADD CONSTRAINT invites_pkey PRIMARY KEY (id);


--
-- Name: list_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY list_rules
    ADD CONSTRAINT list_rules_pkey PRIMARY KEY (id);


--
-- Name: listed_taxa_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY listed_taxa
    ADD CONSTRAINT listed_taxa_pkey PRIMARY KEY (id);


--
-- Name: lists_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lists
    ADD CONSTRAINT lists_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- Name: observation_field_values_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY observation_field_values
    ADD CONSTRAINT observation_field_values_pkey PRIMARY KEY (id);


--
-- Name: observation_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY observation_fields
    ADD CONSTRAINT observation_fields_pkey PRIMARY KEY (id);


--
-- Name: observation_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY observation_links
    ADD CONSTRAINT observation_links_pkey PRIMARY KEY (id);


--
-- Name: observation_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY observation_photos
    ADD CONSTRAINT observation_photos_pkey PRIMARY KEY (id);


--
-- Name: observations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY observations
    ADD CONSTRAINT observations_pkey PRIMARY KEY (id);


--
-- Name: observations_places_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY observations_places
    ADD CONSTRAINT observations_places_pkey PRIMARY KEY (id);


--
-- Name: observations_sounds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY observation_sounds
    ADD CONSTRAINT observations_sounds_pkey PRIMARY KEY (id);


--
-- Name: passwords_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY passwords
    ADD CONSTRAINT passwords_pkey PRIMARY KEY (id);


--
-- Name: photos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- Name: picasa_identities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY picasa_identities
    ADD CONSTRAINT picasa_identities_pkey PRIMARY KEY (id);


--
-- Name: place_geometries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY place_geometries
    ADD CONSTRAINT place_geometries_pkey PRIMARY KEY (id);


--
-- Name: place_taxon_names_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY place_taxon_names
    ADD CONSTRAINT place_taxon_names_pkey PRIMARY KEY (id);


--
-- Name: places_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY places
    ADD CONSTRAINT places_pkey PRIMARY KEY (id);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (id);


--
-- Name: project_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_assets
    ADD CONSTRAINT project_assets_pkey PRIMARY KEY (id);


--
-- Name: project_invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_invitations
    ADD CONSTRAINT project_invitations_pkey PRIMARY KEY (id);


--
-- Name: project_observation_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_observation_fields
    ADD CONSTRAINT project_observation_fields_pkey PRIMARY KEY (id);


--
-- Name: project_observations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_observations
    ADD CONSTRAINT project_observations_pkey PRIMARY KEY (id);


--
-- Name: project_user_invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_user_invitations
    ADD CONSTRAINT project_user_invitations_pkey PRIMARY KEY (id);


--
-- Name: project_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_users
    ADD CONSTRAINT project_users_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: provider_authorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY provider_authorizations
    ADD CONSTRAINT provider_authorizations_pkey PRIMARY KEY (id);


--
-- Name: quality_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY quality_metrics
    ADD CONSTRAINT quality_metrics_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rules
    ADD CONSTRAINT rules_pkey PRIMARY KEY (id);


--
-- Name: site_admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY site_admins
    ADD CONSTRAINT site_admins_pkey PRIMARY KEY (id);


--
-- Name: sites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);


--
-- Name: soundcloud_identities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY soundcloud_identities
    ADD CONSTRAINT soundcloud_identities_pkey PRIMARY KEY (id);


--
-- Name: sounds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sounds
    ADD CONSTRAINT sounds_pkey PRIMARY KEY (id);


--
-- Name: sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: spatial_ref_sys_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spatial_ref_sys
    ADD CONSTRAINT spatial_ref_sys_pkey PRIMARY KEY (srid);


--
-- Name: states_simplified_1_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY states_simplified_1
    ADD CONSTRAINT states_simplified_1_pkey PRIMARY KEY (id);


--
-- Name: subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: taxa_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxa
    ADD CONSTRAINT taxa_pkey PRIMARY KEY (id);


--
-- Name: taxon_change_taxa_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxon_change_taxa
    ADD CONSTRAINT taxon_change_taxa_pkey PRIMARY KEY (id);


--
-- Name: taxon_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxon_changes
    ADD CONSTRAINT taxon_changes_pkey PRIMARY KEY (id);


--
-- Name: taxon_descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxon_descriptions
    ADD CONSTRAINT taxon_descriptions_pkey PRIMARY KEY (id);


--
-- Name: taxon_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxon_links
    ADD CONSTRAINT taxon_links_pkey PRIMARY KEY (id);


--
-- Name: taxon_names_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxon_names
    ADD CONSTRAINT taxon_names_pkey PRIMARY KEY (id);


--
-- Name: taxon_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxon_photos
    ADD CONSTRAINT taxon_photos_pkey PRIMARY KEY (id);


--
-- Name: taxon_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxon_ranges
    ADD CONSTRAINT taxon_ranges_pkey PRIMARY KEY (id);


--
-- Name: taxon_scheme_taxa_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxon_scheme_taxa
    ADD CONSTRAINT taxon_scheme_taxa_pkey PRIMARY KEY (id);


--
-- Name: taxon_schemes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxon_schemes
    ADD CONSTRAINT taxon_schemes_pkey PRIMARY KEY (id);


--
-- Name: taxon_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxon_versions
    ADD CONSTRAINT taxon_versions_pkey PRIMARY KEY (id);


--
-- Name: trip_purposes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trip_purposes
    ADD CONSTRAINT trip_purposes_pkey PRIMARY KEY (id);


--
-- Name: trip_taxa_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY trip_taxa
    ADD CONSTRAINT trip_taxa_pkey PRIMARY KEY (id);


--
-- Name: updates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY updates
    ADD CONSTRAINT updates_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wiki_page_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wiki_page_attachments
    ADD CONSTRAINT wiki_page_attachments_pkey PRIMARY KEY (id);


--
-- Name: wiki_page_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wiki_page_versions
    ADD CONSTRAINT wiki_page_versions_pkey PRIMARY KEY (id);


--
-- Name: wiki_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wiki_pages
    ADD CONSTRAINT wiki_pages_pkey PRIMARY KEY (id);


--
-- Name: fk_flags_user; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX fk_flags_user ON flags USING btree (user_id);


--
-- Name: index_assessment_sections_on_assessment_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assessment_sections_on_assessment_id ON assessment_sections USING btree (assessment_id);


--
-- Name: index_assessment_sections_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assessment_sections_on_user_id ON assessment_sections USING btree (user_id);


--
-- Name: index_assessments_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assessments_on_project_id ON assessments USING btree (project_id);


--
-- Name: index_assessments_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assessments_on_taxon_id ON assessments USING btree (taxon_id);


--
-- Name: index_assessments_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_assessments_on_user_id ON assessments USING btree (user_id);


--
-- Name: index_colors_taxa_on_taxon_id_and_color_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_colors_taxa_on_taxon_id_and_color_id ON colors_taxa USING btree (taxon_id, color_id);


--
-- Name: index_comments_on_parent_type_and_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_parent_type_and_parent_id ON comments USING btree (parent_type, parent_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);


--
-- Name: index_conservation_statuses_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_conservation_statuses_on_place_id ON conservation_statuses USING btree (place_id);


--
-- Name: index_conservation_statuses_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_conservation_statuses_on_source_id ON conservation_statuses USING btree (source_id);


--
-- Name: index_conservation_statuses_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_conservation_statuses_on_taxon_id ON conservation_statuses USING btree (taxon_id);


--
-- Name: index_conservation_statuses_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_conservation_statuses_on_user_id ON conservation_statuses USING btree (user_id);


--
-- Name: index_counties_simplified_01_on_geom; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_counties_simplified_01_on_geom ON counties_simplified_01 USING gist (geom);


--
-- Name: index_counties_simplified_01_on_place_geometry_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_counties_simplified_01_on_place_geometry_id ON counties_simplified_01 USING btree (place_geometry_id);


--
-- Name: index_counties_simplified_01_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_counties_simplified_01_on_place_id ON counties_simplified_01 USING btree (place_id);


--
-- Name: index_countries_simplified_1_on_geom; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_countries_simplified_1_on_geom ON countries_simplified_1 USING gist (geom);


--
-- Name: index_countries_simplified_1_on_place_geometry_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_countries_simplified_1_on_place_geometry_id ON countries_simplified_1 USING btree (place_geometry_id);


--
-- Name: index_countries_simplified_1_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_countries_simplified_1_on_place_id ON countries_simplified_1 USING btree (place_id);


--
-- Name: index_custom_projects_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_custom_projects_on_project_id ON custom_projects USING btree (project_id);


--
-- Name: index_deleted_observations_on_user_id_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_deleted_observations_on_user_id_and_created_at ON deleted_observations USING btree (user_id, created_at);


--
-- Name: index_deleted_users_on_login; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_deleted_users_on_login ON deleted_users USING btree (login);


--
-- Name: index_deleted_users_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_deleted_users_on_user_id ON deleted_users USING btree (user_id);


--
-- Name: index_flickr_photos_on_flickr_native_photo_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_flickr_photos_on_flickr_native_photo_id ON photos USING btree (native_photo_id);


--
-- Name: index_flow_task_resources_on_flow_task_id_and_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_flow_task_resources_on_flow_task_id_and_type ON flow_task_resources USING btree (flow_task_id, type);


--
-- Name: index_flow_task_resources_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_flow_task_resources_on_resource_type_and_resource_id ON flow_task_resources USING btree (resource_type, resource_id);


--
-- Name: index_flow_tasks_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_flow_tasks_on_user_id ON flow_tasks USING btree (user_id);


--
-- Name: index_guide_photos_on_guide_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_photos_on_guide_taxon_id ON guide_photos USING btree (guide_taxon_id);


--
-- Name: index_guide_photos_on_photo_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_photos_on_photo_id ON guide_photos USING btree (photo_id);


--
-- Name: index_guide_ranges_on_guide_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_ranges_on_guide_taxon_id ON guide_ranges USING btree (guide_taxon_id);


--
-- Name: index_guide_ranges_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_ranges_on_source_id ON guide_ranges USING btree (source_id);


--
-- Name: index_guide_sections_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_sections_on_creator_id ON guide_sections USING btree (creator_id);


--
-- Name: index_guide_sections_on_guide_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_sections_on_guide_taxon_id ON guide_sections USING btree (guide_taxon_id);


--
-- Name: index_guide_sections_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_sections_on_source_id ON guide_sections USING btree (source_id);


--
-- Name: index_guide_sections_on_updater_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_sections_on_updater_id ON guide_sections USING btree (updater_id);


--
-- Name: index_guide_taxa_on_guide_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_taxa_on_guide_id ON guide_taxa USING btree (guide_id);


--
-- Name: index_guide_taxa_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_taxa_on_taxon_id ON guide_taxa USING btree (taxon_id);


--
-- Name: index_guide_users_on_guide_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_users_on_guide_id ON guide_users USING btree (guide_id);


--
-- Name: index_guide_users_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guide_users_on_user_id ON guide_users USING btree (user_id);


--
-- Name: index_guides_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guides_on_place_id ON guides USING btree (place_id);


--
-- Name: index_guides_on_source_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guides_on_source_url ON guides USING btree (source_url);


--
-- Name: index_guides_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guides_on_taxon_id ON guides USING btree (taxon_id);


--
-- Name: index_guides_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_guides_on_user_id ON guides USING btree (user_id);


--
-- Name: index_identifications_on_current; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_identifications_on_current ON identifications USING btree (user_id, observation_id) WHERE current;


--
-- Name: index_identifications_on_observation_id_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_identifications_on_observation_id_and_created_at ON identifications USING btree (observation_id, created_at);


--
-- Name: index_identifications_on_taxon_change_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_identifications_on_taxon_change_id ON identifications USING btree (taxon_change_id);


--
-- Name: index_identifications_on_user_id_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_identifications_on_user_id_and_created_at ON identifications USING btree (user_id, created_at);


--
-- Name: index_list_rules_on_list_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_list_rules_on_list_id ON list_rules USING btree (list_id);


--
-- Name: index_list_rules_on_operand_type_and_operand_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_list_rules_on_operand_type_and_operand_id ON list_rules USING btree (operand_type, operand_id);


--
-- Name: index_listed_taxa_on_first_observation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_first_observation_id ON listed_taxa USING btree (first_observation_id);


--
-- Name: index_listed_taxa_on_last_observation_id_and_list_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_last_observation_id_and_list_id ON listed_taxa USING btree (last_observation_id, list_id);


--
-- Name: index_listed_taxa_on_list_id_and_taxon_ancestor_ids_and_taxon_i; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_list_id_and_taxon_ancestor_ids_and_taxon_i ON listed_taxa USING btree (list_id, taxon_ancestor_ids, taxon_id);


--
-- Name: index_listed_taxa_on_list_id_and_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_list_id_and_taxon_id ON listed_taxa USING btree (list_id, taxon_id);


--
-- Name: index_listed_taxa_on_place_id_and_created_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_place_id_and_created_at ON listed_taxa USING btree (place_id, created_at);


--
-- Name: index_listed_taxa_on_place_id_and_observations_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_place_id_and_observations_count ON listed_taxa USING btree (place_id, observations_count);


--
-- Name: index_listed_taxa_on_place_id_and_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_place_id_and_taxon_id ON listed_taxa USING btree (place_id, taxon_id);


--
-- Name: index_listed_taxa_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_source_id ON listed_taxa USING btree (source_id);


--
-- Name: index_listed_taxa_on_taxon_ancestor_ids; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_taxon_ancestor_ids ON listed_taxa USING btree (taxon_ancestor_ids);


--
-- Name: index_listed_taxa_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_taxon_id ON listed_taxa USING btree (taxon_id);


--
-- Name: index_listed_taxa_on_taxon_range_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_taxon_range_id ON listed_taxa USING btree (taxon_range_id);


--
-- Name: index_listed_taxa_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_listed_taxa_on_user_id ON listed_taxa USING btree (user_id);


--
-- Name: index_lists_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_lists_on_place_id ON lists USING btree (place_id);


--
-- Name: index_lists_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_lists_on_project_id ON lists USING btree (project_id);


--
-- Name: index_lists_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_lists_on_source_id ON lists USING btree (source_id);


--
-- Name: index_lists_on_type_and_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_lists_on_type_and_id ON lists USING btree (type, id);


--
-- Name: index_lists_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_lists_on_user_id ON lists USING btree (user_id);


--
-- Name: index_messages_on_user_id_and_from_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_user_id_and_from_user_id ON messages USING btree (user_id, from_user_id);


--
-- Name: index_messages_on_user_id_and_to_user_id_and_read_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_user_id_and_to_user_id_and_read_at ON messages USING btree (user_id, to_user_id, read_at);


--
-- Name: index_oauth_access_grants_on_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_grants_on_token ON oauth_access_grants USING btree (token);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON oauth_access_tokens USING btree (token);


--
-- Name: index_oauth_applications_on_owner_id_and_owner_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_oauth_applications_on_owner_id_and_owner_type ON oauth_applications USING btree (owner_id, owner_type);


--
-- Name: index_oauth_applications_on_uid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_applications_on_uid ON oauth_applications USING btree (uid);


--
-- Name: index_observation_field_values_on_observation_field_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_field_values_on_observation_field_id ON observation_field_values USING btree (observation_field_id);


--
-- Name: index_observation_field_values_on_observation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_field_values_on_observation_id ON observation_field_values USING btree (observation_id);


--
-- Name: index_observation_field_values_on_updater_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_field_values_on_updater_id ON observation_field_values USING btree (updater_id);


--
-- Name: index_observation_field_values_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_field_values_on_user_id ON observation_field_values USING btree (user_id);


--
-- Name: index_observation_fields_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_fields_on_name ON observation_fields USING btree (name);


--
-- Name: index_observation_links_on_observation_id_and_href; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_links_on_observation_id_and_href ON observation_links USING btree (observation_id, href);


--
-- Name: index_observation_photos_on_observation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_photos_on_observation_id ON observation_photos USING btree (observation_id);


--
-- Name: index_observation_photos_on_photo_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_photos_on_photo_id ON observation_photos USING btree (photo_id);


--
-- Name: index_observation_photos_on_uuid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_photos_on_uuid ON observation_photos USING btree (uuid);


--
-- Name: index_observation_zooms_10_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_10_on_taxon_id ON observation_zooms_10 USING btree (taxon_id);


--
-- Name: index_observation_zooms_11_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_11_on_taxon_id ON observation_zooms_11 USING btree (taxon_id);


--
-- Name: index_observation_zooms_125_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_125_on_taxon_id ON observation_zooms_125 USING btree (taxon_id);


--
-- Name: index_observation_zooms_12_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_12_on_taxon_id ON observation_zooms_12 USING btree (taxon_id);


--
-- Name: index_observation_zooms_2000_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_2000_on_taxon_id ON observation_zooms_2000 USING btree (taxon_id);


--
-- Name: index_observation_zooms_250_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_250_on_taxon_id ON observation_zooms_250 USING btree (taxon_id);


--
-- Name: index_observation_zooms_2_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_2_on_taxon_id ON observation_zooms_2 USING btree (taxon_id);


--
-- Name: index_observation_zooms_3_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_3_on_taxon_id ON observation_zooms_3 USING btree (taxon_id);


--
-- Name: index_observation_zooms_4000_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_4000_on_taxon_id ON observation_zooms_4000 USING btree (taxon_id);


--
-- Name: index_observation_zooms_4_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_4_on_taxon_id ON observation_zooms_4 USING btree (taxon_id);


--
-- Name: index_observation_zooms_500_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_500_on_taxon_id ON observation_zooms_500 USING btree (taxon_id);


--
-- Name: index_observation_zooms_5_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_5_on_taxon_id ON observation_zooms_5 USING btree (taxon_id);


--
-- Name: index_observation_zooms_63_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_63_on_taxon_id ON observation_zooms_63 USING btree (taxon_id);


--
-- Name: index_observation_zooms_6_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_6_on_taxon_id ON observation_zooms_6 USING btree (taxon_id);


--
-- Name: index_observation_zooms_7_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_7_on_taxon_id ON observation_zooms_7 USING btree (taxon_id);


--
-- Name: index_observation_zooms_8_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_8_on_taxon_id ON observation_zooms_8 USING btree (taxon_id);


--
-- Name: index_observation_zooms_990_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_990_on_taxon_id ON observation_zooms_990 USING btree (taxon_id);


--
-- Name: index_observation_zooms_9_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observation_zooms_9_on_taxon_id ON observation_zooms_9 USING btree (taxon_id);


--
-- Name: index_observations_on_captive; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_captive ON observations USING btree (captive);


--
-- Name: index_observations_on_comments_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_comments_count ON observations USING btree (comments_count);


--
-- Name: index_observations_on_community_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_community_taxon_id ON observations USING btree (community_taxon_id);


--
-- Name: index_observations_on_geom; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_geom ON observations USING gist (geom);


--
-- Name: index_observations_on_mappable; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_mappable ON observations USING btree (mappable);


--
-- Name: index_observations_on_oauth_application_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_oauth_application_id ON observations USING btree (oauth_application_id);


--
-- Name: index_observations_on_observed_on_and_time_observed_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_observed_on_and_time_observed_at ON observations USING btree (observed_on, time_observed_at);


--
-- Name: index_observations_on_out_of_range; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_out_of_range ON observations USING btree (out_of_range);


--
-- Name: index_observations_on_photos_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_photos_count ON observations USING btree (observation_photos_count);


--
-- Name: index_observations_on_private_geom; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_private_geom ON observations USING gist (private_geom);


--
-- Name: index_observations_on_quality_grade; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_quality_grade ON observations USING btree (quality_grade);


--
-- Name: index_observations_on_site_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_site_id ON observations USING btree (site_id);


--
-- Name: index_observations_on_taxon_id_and_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_taxon_id_and_user_id ON observations USING btree (taxon_id, user_id);


--
-- Name: index_observations_on_uri; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_uri ON observations USING btree (uri);


--
-- Name: index_observations_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_user_id ON observations USING btree (user_id);


--
-- Name: index_observations_on_uuid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_on_uuid ON observations USING btree (uuid);


--
-- Name: index_observations_places_on_observation_id_and_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_observations_places_on_observation_id_and_place_id ON observations_places USING btree (observation_id, place_id);


--
-- Name: index_observations_places_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_places_on_place_id ON observations_places USING btree (place_id);


--
-- Name: index_observations_posts_on_observation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_posts_on_observation_id ON observations_posts USING btree (observation_id);


--
-- Name: index_observations_posts_on_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_posts_on_post_id ON observations_posts USING btree (post_id);


--
-- Name: index_observations_sounds_on_observation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_sounds_on_observation_id ON observation_sounds USING btree (observation_id);


--
-- Name: index_observations_sounds_on_sound_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_sounds_on_sound_id ON observation_sounds USING btree (sound_id);


--
-- Name: index_observations_user_datetime; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_observations_user_datetime ON observations USING btree (user_id, observed_on, time_observed_at);


--
-- Name: index_photos_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_photos_on_user_id ON photos USING btree (user_id);


--
-- Name: index_picasa_identities_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_picasa_identities_on_user_id ON picasa_identities USING btree (user_id);


--
-- Name: index_place_geometries_on_geom; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_place_geometries_on_geom ON place_geometries USING gist (geom);


--
-- Name: index_place_geometries_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_place_geometries_on_place_id ON place_geometries USING btree (place_id);


--
-- Name: index_place_geometries_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_place_geometries_on_source_id ON place_geometries USING btree (source_id);


--
-- Name: index_place_taxon_names_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_place_taxon_names_on_place_id ON place_taxon_names USING btree (place_id);


--
-- Name: index_place_taxon_names_on_taxon_name_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_place_taxon_names_on_taxon_name_id ON place_taxon_names USING btree (taxon_name_id);


--
-- Name: index_places_on_admin_level; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_places_on_admin_level ON places USING btree (admin_level);


--
-- Name: index_places_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_places_on_ancestry ON places USING btree (ancestry text_pattern_ops);


--
-- Name: index_places_on_bbox_area; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_places_on_bbox_area ON places USING btree (bbox_area);


--
-- Name: index_places_on_check_list_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_places_on_check_list_id ON places USING btree (check_list_id);


--
-- Name: index_places_on_latitude_and_longitude; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_places_on_latitude_and_longitude ON places USING btree (latitude, longitude);


--
-- Name: index_places_on_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_places_on_parent_id ON places USING btree (parent_id);


--
-- Name: index_places_on_place_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_places_on_place_type ON places USING btree (place_type);


--
-- Name: index_places_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_places_on_slug ON places USING btree (slug);


--
-- Name: index_places_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_places_on_source_id ON places USING btree (source_id);


--
-- Name: index_places_on_swlat_and_swlng_and_nelat_and_nelng; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_places_on_swlat_and_swlng_and_nelat_and_nelng ON places USING btree (swlat, swlng, nelat, nelng);


--
-- Name: index_places_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_places_on_user_id ON places USING btree (user_id);


--
-- Name: index_posts_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_posts_on_place_id ON posts USING btree (place_id);


--
-- Name: index_posts_on_published_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_posts_on_published_at ON posts USING btree (published_at);


--
-- Name: index_preferences_on_owner_and_name_and_preference; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_preferences_on_owner_and_name_and_preference ON preferences USING btree (owner_id, owner_type, name, group_id, group_type);


--
-- Name: index_project_assets_on_asset_content_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_assets_on_asset_content_type ON project_assets USING btree (asset_content_type);


--
-- Name: index_project_assets_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_assets_on_project_id ON project_assets USING btree (project_id);


--
-- Name: index_project_invitations_on_observation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_invitations_on_observation_id ON project_invitations USING btree (observation_id);


--
-- Name: index_project_observation_fields_on_observation_field_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_observation_fields_on_observation_field_id ON project_observation_fields USING btree (observation_field_id);


--
-- Name: index_project_observations_on_curator_identification_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_observations_on_curator_identification_id ON project_observations USING btree (curator_identification_id);


--
-- Name: index_project_observations_on_observation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_observations_on_observation_id ON project_observations USING btree (observation_id);


--
-- Name: index_project_observations_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_observations_on_project_id ON project_observations USING btree (project_id);


--
-- Name: index_project_user_invitations_on_invited_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_user_invitations_on_invited_user_id ON project_user_invitations USING btree (invited_user_id);


--
-- Name: index_project_user_invitations_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_user_invitations_on_project_id ON project_user_invitations USING btree (project_id);


--
-- Name: index_project_user_invitations_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_user_invitations_on_user_id ON project_user_invitations USING btree (user_id);


--
-- Name: index_project_users_on_project_id_and_taxa_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_users_on_project_id_and_taxa_count ON project_users USING btree (project_id, taxa_count);


--
-- Name: index_project_users_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_project_users_on_user_id ON project_users USING btree (user_id);


--
-- Name: index_projects_on_cached_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_projects_on_cached_slug ON projects USING btree (slug);


--
-- Name: index_projects_on_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_parent_id ON projects USING btree (parent_id);


--
-- Name: index_projects_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_place_id ON projects USING btree (place_id);


--
-- Name: index_projects_on_source_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_source_url ON projects USING btree (source_url);


--
-- Name: index_projects_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_user_id ON projects USING btree (user_id);


--
-- Name: index_provider_authorizations_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_provider_authorizations_on_user_id ON provider_authorizations USING btree (user_id);


--
-- Name: index_quality_metrics_on_observation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_quality_metrics_on_observation_id ON quality_metrics USING btree (observation_id);


--
-- Name: index_quality_metrics_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_quality_metrics_on_user_id ON quality_metrics USING btree (user_id);


--
-- Name: index_roles_users_on_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_users_on_role_id ON roles_users USING btree (role_id);


--
-- Name: index_roles_users_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_users_on_user_id ON roles_users USING btree (user_id);


--
-- Name: index_site_admins_on_site_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_site_admins_on_site_id ON site_admins USING btree (site_id);


--
-- Name: index_site_admins_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_site_admins_on_user_id ON site_admins USING btree (user_id);


--
-- Name: index_sites_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sites_on_place_id ON sites USING btree (place_id);


--
-- Name: index_sites_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sites_on_source_id ON sites USING btree (source_id);


--
-- Name: index_slugs_on_n_s_s_and_s; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_slugs_on_n_s_s_and_s ON friendly_id_slugs USING btree (slug, sluggable_type, sequence, scope);


--
-- Name: index_slugs_on_sluggable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_slugs_on_sluggable_id ON friendly_id_slugs USING btree (sluggable_id);


--
-- Name: index_sounds_on_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sounds_on_type ON sounds USING btree (type);


--
-- Name: index_sounds_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sounds_on_user_id ON sounds USING btree (user_id);


--
-- Name: index_sources_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sources_on_user_id ON sources USING btree (user_id);


--
-- Name: index_states_simplified_1_on_geom; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_states_simplified_1_on_geom ON states_simplified_1 USING gist (geom);


--
-- Name: index_states_simplified_1_on_place_geometry_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_states_simplified_1_on_place_geometry_id ON states_simplified_1 USING btree (place_geometry_id);


--
-- Name: index_states_simplified_1_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_states_simplified_1_on_place_id ON states_simplified_1 USING btree (place_id);


--
-- Name: index_subscriptions_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_subscriptions_on_resource_type_and_resource_id ON subscriptions USING btree (resource_type, resource_id);


--
-- Name: index_subscriptions_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_subscriptions_on_taxon_id ON subscriptions USING btree (taxon_id);


--
-- Name: index_subscriptions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_subscriptions_on_user_id ON subscriptions USING btree (user_id);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type ON taggings USING btree (taggable_id, taggable_type);


--
-- Name: index_taxa_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_ancestry ON taxa USING btree (ancestry text_pattern_ops);


--
-- Name: index_taxa_on_conservation_status_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_conservation_status_source_id ON taxa USING btree (conservation_status_source_id);


--
-- Name: index_taxa_on_featured_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_featured_at ON taxa USING btree (featured_at);


--
-- Name: index_taxa_on_is_iconic; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_is_iconic ON taxa USING btree (is_iconic);


--
-- Name: index_taxa_on_listed_taxa_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_listed_taxa_count ON taxa USING btree (listed_taxa_count);


--
-- Name: index_taxa_on_locked; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_locked ON taxa USING btree (locked);


--
-- Name: index_taxa_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_name ON taxa USING btree (name);


--
-- Name: index_taxa_on_observations_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_observations_count ON taxa USING btree (observations_count);


--
-- Name: index_taxa_on_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_parent_id ON taxa USING btree (parent_id);


--
-- Name: index_taxa_on_rank_level; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_rank_level ON taxa USING btree (rank_level);


--
-- Name: index_taxa_on_unique_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxa_on_unique_name ON taxa USING btree (unique_name);


--
-- Name: index_taxon_ancestors_on_ancestor_taxon_id_and_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_taxon_ancestors_on_ancestor_taxon_id_and_taxon_id ON taxon_ancestors USING btree (ancestor_taxon_id, taxon_id);


--
-- Name: index_taxon_ancestors_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_ancestors_on_taxon_id ON taxon_ancestors USING btree (taxon_id);


--
-- Name: index_taxon_change_taxa_on_taxon_change_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_change_taxa_on_taxon_change_id ON taxon_change_taxa USING btree (taxon_change_id);


--
-- Name: index_taxon_change_taxa_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_change_taxa_on_taxon_id ON taxon_change_taxa USING btree (taxon_id);


--
-- Name: index_taxon_changes_on_committer_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_changes_on_committer_id ON taxon_changes USING btree (committer_id);


--
-- Name: index_taxon_changes_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_changes_on_source_id ON taxon_changes USING btree (source_id);


--
-- Name: index_taxon_changes_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_changes_on_taxon_id ON taxon_changes USING btree (taxon_id);


--
-- Name: index_taxon_changes_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_changes_on_user_id ON taxon_changes USING btree (user_id);


--
-- Name: index_taxon_descriptions_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_descriptions_on_taxon_id ON taxon_descriptions USING btree (taxon_id);


--
-- Name: index_taxon_links_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_links_on_place_id ON taxon_links USING btree (place_id);


--
-- Name: index_taxon_links_on_taxon_id_and_show_for_descendent_taxa; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_links_on_taxon_id_and_show_for_descendent_taxa ON taxon_links USING btree (taxon_id, show_for_descendent_taxa);


--
-- Name: index_taxon_links_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_links_on_user_id ON taxon_links USING btree (user_id);


--
-- Name: index_taxon_names_on_lexicon; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_names_on_lexicon ON taxon_names USING btree (lexicon);


--
-- Name: index_taxon_names_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_names_on_taxon_id ON taxon_names USING btree (taxon_id);


--
-- Name: index_taxon_photos_on_photo_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_photos_on_photo_id ON taxon_photos USING btree (photo_id);


--
-- Name: index_taxon_photos_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_photos_on_taxon_id ON taxon_photos USING btree (taxon_id);


--
-- Name: index_taxon_ranges_on_geom; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_ranges_on_geom ON taxon_ranges USING gist (geom);


--
-- Name: index_taxon_ranges_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_ranges_on_taxon_id ON taxon_ranges USING btree (taxon_id);


--
-- Name: index_taxon_scheme_taxa_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_scheme_taxa_on_taxon_id ON taxon_scheme_taxa USING btree (taxon_id);


--
-- Name: index_taxon_scheme_taxa_on_taxon_name_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_scheme_taxa_on_taxon_name_id ON taxon_scheme_taxa USING btree (taxon_name_id);


--
-- Name: index_taxon_scheme_taxa_on_taxon_scheme_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_scheme_taxa_on_taxon_scheme_id ON taxon_scheme_taxa USING btree (taxon_scheme_id);


--
-- Name: index_taxon_schemes_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taxon_schemes_on_source_id ON taxon_schemes USING btree (source_id);


--
-- Name: index_trip_purposes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_trip_purposes_on_resource_type_and_resource_id ON trip_purposes USING btree (resource_type, resource_id);


--
-- Name: index_trip_purposes_on_trip_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_trip_purposes_on_trip_id ON trip_purposes USING btree (trip_id);


--
-- Name: index_trip_taxa_on_taxon_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_trip_taxa_on_taxon_id ON trip_taxa USING btree (taxon_id);


--
-- Name: index_trip_taxa_on_trip_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_trip_taxa_on_trip_id ON trip_taxa USING btree (trip_id);


--
-- Name: index_updates_on_notifier_type_and_notifier_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_updates_on_notifier_type_and_notifier_id ON updates USING btree (notifier_type, notifier_id);


--
-- Name: index_updates_on_resource_owner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_updates_on_resource_owner_id ON updates USING btree (resource_owner_id);


--
-- Name: index_updates_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_updates_on_resource_type_and_resource_id ON updates USING btree (resource_type, resource_id);


--
-- Name: index_updates_on_subscriber_id_and_viewed_at_and_notification; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_updates_on_subscriber_id_and_viewed_at_and_notification ON updates USING btree (subscriber_id, viewed_at, notification);


--
-- Name: index_users_on_identifications_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_identifications_count ON users USING btree (identifications_count);


--
-- Name: index_users_on_journal_posts_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_journal_posts_count ON users USING btree (journal_posts_count);


--
-- Name: index_users_on_life_list_taxa_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_life_list_taxa_count ON users USING btree (life_list_taxa_count);


--
-- Name: index_users_on_login; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_login ON users USING btree (login);


--
-- Name: index_users_on_observations_count; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_observations_count ON users USING btree (observations_count);


--
-- Name: index_users_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_place_id ON users USING btree (place_id);


--
-- Name: index_users_on_site_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_site_id ON users USING btree (site_id);


--
-- Name: index_users_on_spammer; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_spammer ON users USING btree (spammer);


--
-- Name: index_users_on_state; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_state ON users USING btree (state);


--
-- Name: index_users_on_uri; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_uri ON users USING btree (uri);


--
-- Name: index_wiki_page_attachments_on_page_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wiki_page_attachments_on_page_id ON wiki_page_attachments USING btree (page_id);


--
-- Name: index_wiki_page_versions_on_page_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wiki_page_versions_on_page_id ON wiki_page_versions USING btree (page_id);


--
-- Name: index_wiki_page_versions_on_updator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wiki_page_versions_on_updator_id ON wiki_page_versions USING btree (updator_id);


--
-- Name: index_wiki_pages_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_wiki_pages_on_creator_id ON wiki_pages USING btree (creator_id);


--
-- Name: index_wiki_pages_on_path; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_wiki_pages_on_path ON wiki_pages USING btree (path);


--
-- Name: pof_projid_ofid; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX pof_projid_ofid ON project_observation_fields USING btree (project_id, observation_field_id);


--
-- Name: pof_projid_pos; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX pof_projid_pos ON project_observation_fields USING btree (project_id, "position");


--
-- Name: taxon_names_lower_name_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX taxon_names_lower_name_index ON taxon_names USING btree (lower((name)::text));


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: updates_unique_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX updates_unique_key ON updates USING btree (resource_type, resource_id, notifier_type, notifier_id, subscriber_id, notification);


--
-- Name: geometry_columns_delete; Type: RULE; Schema: public; Owner: -
--

CREATE RULE geometry_columns_delete AS ON DELETE TO geometry_columns DO INSTEAD NOTHING;


--
-- Name: geometry_columns_insert; Type: RULE; Schema: public; Owner: -
--

CREATE RULE geometry_columns_insert AS ON INSERT TO geometry_columns DO INSTEAD NOTHING;


--
-- Name: geometry_columns_update; Type: RULE; Schema: public; Owner: -
--

CREATE RULE geometry_columns_update AS ON UPDATE TO geometry_columns DO INSTEAD NOTHING;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20090820033338');

INSERT INTO schema_migrations (version) VALUES ('20090920043428');

INSERT INTO schema_migrations (version) VALUES ('20091005055004');

INSERT INTO schema_migrations (version) VALUES ('20091023222943');

INSERT INTO schema_migrations (version) VALUES ('20091024022010');

INSERT INTO schema_migrations (version) VALUES ('20091123044434');

INSERT INTO schema_migrations (version) VALUES ('20091216052325');

INSERT INTO schema_migrations (version) VALUES ('20091221195909');

INSERT INTO schema_migrations (version) VALUES ('20091223030137');

INSERT INTO schema_migrations (version) VALUES ('20100119024356');

INSERT INTO schema_migrations (version) VALUES ('20100610052004');

INSERT INTO schema_migrations (version) VALUES ('20100709225557');

INSERT INTO schema_migrations (version) VALUES ('20100807184336');

INSERT INTO schema_migrations (version) VALUES ('20100807184524');

INSERT INTO schema_migrations (version) VALUES ('20100807184540');

INSERT INTO schema_migrations (version) VALUES ('20100815222147');

INSERT INTO schema_migrations (version) VALUES ('20101002052112');

INSERT INTO schema_migrations (version) VALUES ('20101010224648');

INSERT INTO schema_migrations (version) VALUES ('20101017010641');

INSERT INTO schema_migrations (version) VALUES ('20101120231112');

INSERT INTO schema_migrations (version) VALUES ('20101128052201');

INSERT INTO schema_migrations (version) VALUES ('20101203223538');

INSERT INTO schema_migrations (version) VALUES ('20101218044932');

INSERT INTO schema_migrations (version) VALUES ('20101226171854');

INSERT INTO schema_migrations (version) VALUES ('20110107064406');

INSERT INTO schema_migrations (version) VALUES ('20110112061527');

INSERT INTO schema_migrations (version) VALUES ('20110202063613');

INSERT INTO schema_migrations (version) VALUES ('20110228043741');

INSERT INTO schema_migrations (version) VALUES ('20110316040303');

INSERT INTO schema_migrations (version) VALUES ('20110326195224');

INSERT INTO schema_migrations (version) VALUES ('20110330050657');

INSERT INTO schema_migrations (version) VALUES ('20110331173629');

INSERT INTO schema_migrations (version) VALUES ('20110331174611');

INSERT INTO schema_migrations (version) VALUES ('20110401221815');

INSERT INTO schema_migrations (version) VALUES ('20110402222428');

INSERT INTO schema_migrations (version) VALUES ('20110405041648');

INSERT INTO schema_migrations (version) VALUES ('20110405041654');

INSERT INTO schema_migrations (version) VALUES ('20110405041659');

INSERT INTO schema_migrations (version) VALUES ('20110408005124');

INSERT INTO schema_migrations (version) VALUES ('20110409064704');

INSERT INTO schema_migrations (version) VALUES ('20110414202308');

INSERT INTO schema_migrations (version) VALUES ('20110415221429');

INSERT INTO schema_migrations (version) VALUES ('20110415225622');

INSERT INTO schema_migrations (version) VALUES ('20110415230149');

INSERT INTO schema_migrations (version) VALUES ('20110428074115');

INSERT INTO schema_migrations (version) VALUES ('20110429004856');

INSERT INTO schema_migrations (version) VALUES ('20110429075345');

INSERT INTO schema_migrations (version) VALUES ('20110502182056');

INSERT INTO schema_migrations (version) VALUES ('20110502221926');

INSERT INTO schema_migrations (version) VALUES ('20110505040504');

INSERT INTO schema_migrations (version) VALUES ('20110513230256');

INSERT INTO schema_migrations (version) VALUES ('20110514221925');

INSERT INTO schema_migrations (version) VALUES ('20110526205447');

INSERT INTO schema_migrations (version) VALUES ('20110529052159');

INSERT INTO schema_migrations (version) VALUES ('20110531065431');

INSERT INTO schema_migrations (version) VALUES ('20110610193807');

INSERT INTO schema_migrations (version) VALUES ('20110709200352');

INSERT INTO schema_migrations (version) VALUES ('20110714185244');

INSERT INTO schema_migrations (version) VALUES ('20110731201217');

INSERT INTO schema_migrations (version) VALUES ('20110801001844');

INSERT INTO schema_migrations (version) VALUES ('20110805044702');

INSERT INTO schema_migrations (version) VALUES ('20110807035642');

INSERT INTO schema_migrations (version) VALUES ('20110809064402');

INSERT INTO schema_migrations (version) VALUES ('20110809064437');

INSERT INTO schema_migrations (version) VALUES ('20110811040139');

INSERT INTO schema_migrations (version) VALUES ('20110905185019');

INSERT INTO schema_migrations (version) VALUES ('20110913060143');

INSERT INTO schema_migrations (version) VALUES ('20111003210305');

INSERT INTO schema_migrations (version) VALUES ('20111014181723');

INSERT INTO schema_migrations (version) VALUES ('20111014182046');

INSERT INTO schema_migrations (version) VALUES ('20111027041911');

INSERT INTO schema_migrations (version) VALUES ('20111027211849');

INSERT INTO schema_migrations (version) VALUES ('20111028190803');

INSERT INTO schema_migrations (version) VALUES ('20111102210429');

INSERT INTO schema_migrations (version) VALUES ('20111108184751');

INSERT INTO schema_migrations (version) VALUES ('20111202065742');

INSERT INTO schema_migrations (version) VALUES ('20111209033826');

INSERT INTO schema_migrations (version) VALUES ('20111212052205');

INSERT INTO schema_migrations (version) VALUES ('20111226210945');

INSERT INTO schema_migrations (version) VALUES ('20120102213824');

INSERT INTO schema_migrations (version) VALUES ('20120105232343');

INSERT INTO schema_migrations (version) VALUES ('20120106222437');

INSERT INTO schema_migrations (version) VALUES ('20120109221839');

INSERT INTO schema_migrations (version) VALUES ('20120109221956');

INSERT INTO schema_migrations (version) VALUES ('20120119183954');

INSERT INTO schema_migrations (version) VALUES ('20120119184143');

INSERT INTO schema_migrations (version) VALUES ('20120120232035');

INSERT INTO schema_migrations (version) VALUES ('20120123001206');

INSERT INTO schema_migrations (version) VALUES ('20120123190202');

INSERT INTO schema_migrations (version) VALUES ('20120214200727');

INSERT INTO schema_migrations (version) VALUES ('20120413012920');

INSERT INTO schema_migrations (version) VALUES ('20120413013521');

INSERT INTO schema_migrations (version) VALUES ('20120416221933');

INSERT INTO schema_migrations (version) VALUES ('20120425042326');

INSERT INTO schema_migrations (version) VALUES ('20120427014202');

INSERT INTO schema_migrations (version) VALUES ('20120504214431');

INSERT INTO schema_migrations (version) VALUES ('20120521225005');

INSERT INTO schema_migrations (version) VALUES ('20120524173746');

INSERT INTO schema_migrations (version) VALUES ('20120525190526');

INSERT INTO schema_migrations (version) VALUES ('20120529181631');

INSERT INTO schema_migrations (version) VALUES ('20120609003704');

INSERT INTO schema_migrations (version) VALUES ('20120628014940');

INSERT INTO schema_migrations (version) VALUES ('20120628014948');

INSERT INTO schema_migrations (version) VALUES ('20120628015126');

INSERT INTO schema_migrations (version) VALUES ('20120629011843');

INSERT INTO schema_migrations (version) VALUES ('20120702194230');

INSERT INTO schema_migrations (version) VALUES ('20120702224519');

INSERT INTO schema_migrations (version) VALUES ('20120704055118');

INSERT INTO schema_migrations (version) VALUES ('20120711053525');

INSERT INTO schema_migrations (version) VALUES ('20120711053620');

INSERT INTO schema_migrations (version) VALUES ('20120712040410');

INSERT INTO schema_migrations (version) VALUES ('20120713074557');

INSERT INTO schema_migrations (version) VALUES ('20120717184355');

INSERT INTO schema_migrations (version) VALUES ('20120719171324');

INSERT INTO schema_migrations (version) VALUES ('20120725194234');

INSERT INTO schema_migrations (version) VALUES ('20120801204921');

INSERT INTO schema_migrations (version) VALUES ('20120808224842');

INSERT INTO schema_migrations (version) VALUES ('20120810053551');

INSERT INTO schema_migrations (version) VALUES ('20120821195023');

INSERT INTO schema_migrations (version) VALUES ('20120830020828');

INSERT INTO schema_migrations (version) VALUES ('20120902210558');

INSERT INTO schema_migrations (version) VALUES ('20120904064231');

INSERT INTO schema_migrations (version) VALUES ('20120906014934');

INSERT INTO schema_migrations (version) VALUES ('20120919201617');

INSERT INTO schema_migrations (version) VALUES ('20120926220539');

INSERT INTO schema_migrations (version) VALUES ('20120929003044');

INSERT INTO schema_migrations (version) VALUES ('20121011181051');

INSERT INTO schema_migrations (version) VALUES ('20121031200130');

INSERT INTO schema_migrations (version) VALUES ('20121101180101');

INSERT INTO schema_migrations (version) VALUES ('20121115043256');

INSERT INTO schema_migrations (version) VALUES ('20121116214553');

INSERT INTO schema_migrations (version) VALUES ('20121119073505');

INSERT INTO schema_migrations (version) VALUES ('20121128022641');

INSERT INTO schema_migrations (version) VALUES ('20121224231303');

INSERT INTO schema_migrations (version) VALUES ('20121227214513');

INSERT INTO schema_migrations (version) VALUES ('20121230023106');

INSERT INTO schema_migrations (version) VALUES ('20121230210148');

INSERT INTO schema_migrations (version) VALUES ('20130102225500');

INSERT INTO schema_migrations (version) VALUES ('20130103065755');

INSERT INTO schema_migrations (version) VALUES ('20130108182219');

INSERT INTO schema_migrations (version) VALUES ('20130108182802');

INSERT INTO schema_migrations (version) VALUES ('20130116165914');

INSERT INTO schema_migrations (version) VALUES ('20130116225224');

INSERT INTO schema_migrations (version) VALUES ('20130131001533');

INSERT INTO schema_migrations (version) VALUES ('20130131061500');

INSERT INTO schema_migrations (version) VALUES ('20130201224839');

INSERT INTO schema_migrations (version) VALUES ('20130205052838');

INSERT INTO schema_migrations (version) VALUES ('20130206192217');

INSERT INTO schema_migrations (version) VALUES ('20130208003925');

INSERT INTO schema_migrations (version) VALUES ('20130208222855');

INSERT INTO schema_migrations (version) VALUES ('20130226064319');

INSERT INTO schema_migrations (version) VALUES ('20130227211137');

INSERT INTO schema_migrations (version) VALUES ('20130301222959');

INSERT INTO schema_migrations (version) VALUES ('20130304024311');

INSERT INTO schema_migrations (version) VALUES ('20130306020925');

INSERT INTO schema_migrations (version) VALUES ('20130311061913');

INSERT INTO schema_migrations (version) VALUES ('20130312070047');

INSERT INTO schema_migrations (version) VALUES ('20130313192420');

INSERT INTO schema_migrations (version) VALUES ('20130403235431');

INSERT INTO schema_migrations (version) VALUES ('20130409225631');

INSERT INTO schema_migrations (version) VALUES ('20130411225629');

INSERT INTO schema_migrations (version) VALUES ('20130418190210');

INSERT INTO schema_migrations (version) VALUES ('20130429215442');

INSERT INTO schema_migrations (version) VALUES ('20130501005855');

INSERT INTO schema_migrations (version) VALUES ('20130502190619');

INSERT INTO schema_migrations (version) VALUES ('20130514012017');

INSERT INTO schema_migrations (version) VALUES ('20130514012037');

INSERT INTO schema_migrations (version) VALUES ('20130514012051');

INSERT INTO schema_migrations (version) VALUES ('20130514012105');

INSERT INTO schema_migrations (version) VALUES ('20130514012120');

INSERT INTO schema_migrations (version) VALUES ('20130516200016');

INSERT INTO schema_migrations (version) VALUES ('20130521001431');

INSERT INTO schema_migrations (version) VALUES ('20130523203022');

INSERT INTO schema_migrations (version) VALUES ('20130603221737');

INSERT INTO schema_migrations (version) VALUES ('20130603234330');

INSERT INTO schema_migrations (version) VALUES ('20130604012213');

INSERT INTO schema_migrations (version) VALUES ('20130607221500');

INSERT INTO schema_migrations (version) VALUES ('20130611025612');

INSERT INTO schema_migrations (version) VALUES ('20130613223707');

INSERT INTO schema_migrations (version) VALUES ('20130624022309');

INSERT INTO schema_migrations (version) VALUES ('20130628035929');

INSERT INTO schema_migrations (version) VALUES ('20130701224024');

INSERT INTO schema_migrations (version) VALUES ('20130704010119');

INSERT INTO schema_migrations (version) VALUES ('20130708233246');

INSERT INTO schema_migrations (version) VALUES ('20130708235548');

INSERT INTO schema_migrations (version) VALUES ('20130709005451');

INSERT INTO schema_migrations (version) VALUES ('20130709212550');

INSERT INTO schema_migrations (version) VALUES ('20130711181857');

INSERT INTO schema_migrations (version) VALUES ('20130721235136');

INSERT INTO schema_migrations (version) VALUES ('20130730200246');

INSERT INTO schema_migrations (version) VALUES ('20130814211257');

INSERT INTO schema_migrations (version) VALUES ('20130903235202');

INSERT INTO schema_migrations (version) VALUES ('20130910053330');

INSERT INTO schema_migrations (version) VALUES ('20130917071826');

INSERT INTO schema_migrations (version) VALUES ('20130926224132');

INSERT INTO schema_migrations (version) VALUES ('20130926233023');

INSERT INTO schema_migrations (version) VALUES ('20130929024857');

INSERT INTO schema_migrations (version) VALUES ('20131008061545');

INSERT INTO schema_migrations (version) VALUES ('20131011234030');

INSERT INTO schema_migrations (version) VALUES ('20131023224910');

INSERT INTO schema_migrations (version) VALUES ('20131024045916');

INSERT INTO schema_migrations (version) VALUES ('20131031160647');

INSERT INTO schema_migrations (version) VALUES ('20131031171349');

INSERT INTO schema_migrations (version) VALUES ('20131119214722');

INSERT INTO schema_migrations (version) VALUES ('20131123022658');

INSERT INTO schema_migrations (version) VALUES ('20131128214012');

INSERT INTO schema_migrations (version) VALUES ('20131128234236');

INSERT INTO schema_migrations (version) VALUES ('20131204211450');

INSERT INTO schema_migrations (version) VALUES ('20131220044313');

INSERT INTO schema_migrations (version) VALUES ('20140101210916');

INSERT INTO schema_migrations (version) VALUES ('20140104202529');

INSERT INTO schema_migrations (version) VALUES ('20140113145150');

INSERT INTO schema_migrations (version) VALUES ('20140114210551');

INSERT INTO schema_migrations (version) VALUES ('20140124190652');

INSERT INTO schema_migrations (version) VALUES ('20140205200914');

INSERT INTO schema_migrations (version) VALUES ('20140220201532');

INSERT INTO schema_migrations (version) VALUES ('20140225074921');

INSERT INTO schema_migrations (version) VALUES ('20140307003642');

INSERT INTO schema_migrations (version) VALUES ('20140313030123');

INSERT INTO schema_migrations (version) VALUES ('20140416193430');

INSERT INTO schema_migrations (version) VALUES ('20140604055610');

INSERT INTO schema_migrations (version) VALUES ('20140611180054');

INSERT INTO schema_migrations (version) VALUES ('20140620021223');

INSERT INTO schema_migrations (version) VALUES ('20140701212522');

INSERT INTO schema_migrations (version) VALUES ('20140704062909');

INSERT INTO schema_migrations (version) VALUES ('20140731201815');

INSERT INTO schema_migrations (version) VALUES ('20140820152353');

INSERT INTO schema_migrations (version) VALUES ('20140904004901');

INSERT INTO schema_migrations (version) VALUES ('20140912201349');

INSERT INTO schema_migrations (version) VALUES ('20141003193707');

INSERT INTO schema_migrations (version) VALUES ('20141015212020');

INSERT INTO schema_migrations (version) VALUES ('20141015213053');

INSERT INTO schema_migrations (version) VALUES ('20141112011137');

INSERT INTO schema_migrations (version) VALUES ('20141201211037');

INSERT INTO schema_migrations (version) VALUES ('20141203024242');

INSERT INTO schema_migrations (version) VALUES ('20141204224856');

INSERT INTO schema_migrations (version) VALUES ('20141213001622');

INSERT INTO schema_migrations (version) VALUES ('20141213195804');

INSERT INTO schema_migrations (version) VALUES ('20141231210447');

INSERT INTO schema_migrations (version) VALUES ('20150104021132');

INSERT INTO schema_migrations (version) VALUES ('20150104033219');

INSERT INTO schema_migrations (version) VALUES ('20150126194129');

INSERT INTO schema_migrations (version) VALUES ('20150128143204');