/* -----------------------------------------------------------------------------
 * rubyprimtypes.swg
 * ----------------------------------------------------------------------------- */
/* ------------------------------------------------------------
 * Primitive Types
 * ------------------------------------------------------------ */

/* auxiliary ruby fail method */

%fragment("SWIG_ruby_failed","header")
{
SWIGINTERN VALUE
SWIG_ruby_failed(VALUE SWIGUNUSEDPARM(arg1), VALUE SWIGUNUSEDPARM(arg2))
{
  return Qnil;
} 
}

/* boolean */

%fragment(SWIG_From_frag(bool),"header") {
SWIGINTERNINLINE VALUE
SWIG_From_dec(bool)(bool value)
{
  return value ? Qtrue : Qfalse;
}
}

%fragment(SWIG_AsVal_frag(bool),"header",
	  fragment=SWIG_AsVal_frag(int)) {
SWIGINTERN int
SWIG_AsVal_dec(bool)(VALUE obj, bool *val)
{
  if (obj == Qtrue) {
    if (val) *val = true;
    return SWIG_OK;
  } else if (obj == Qfalse) {
    if (val) *val = false;
    return SWIG_OK;
  } else {
    int res = 0;
    if (SWIG_AsVal(int)(obj, &res) == SWIG_OK) {    
      if (val) *val = res ? true : false;
      return SWIG_OK;
    }
  }  
  return SWIG_TypeError;
}
}

/* long */

%fragment(SWIG_From_frag(long),"header",
	  fragment="<limits.h>") {
  %define_as(SWIG_From_dec(long),           LONG2NUM)
}

%fragment(SWIG_AsVal_frag(long),"header",fragment="SWIG_ruby_failed") {
SWIGINTERN VALUE SWIG_AUX_NUM2LONG(VALUE arg)
{
  VALUE *args = (VALUE *)arg;
  VALUE obj = args[0];
  VALUE type = TYPE(obj);
  long *res = (long *)(args[1]);
  *res = type == T_FIXNUM ? NUM2LONG(obj) : rb_big2long(obj);
  return obj;
}

SWIGINTERN int
SWIG_AsVal_dec(long)(VALUE obj, long* val)
{
  VALUE type = TYPE(obj);
  if ((type == T_FIXNUM) || (type == T_BIGNUM)) {
    long v;
    VALUE a[2];
    a[0] = obj;
    a[1] = (VALUE)(&v);
    if (rb_rescue(VALUEFUNC(SWIG_AUX_NUM2LONG), (VALUE)a, VALUEFUNC(SWIG_ruby_failed), 0) != Qnil) {
      if (val) *val = v;
      return SWIG_OK;
    }
  }
  return SWIG_TypeError;
}
}

/* unsigned long */

%fragment(SWIG_From_frag(unsigned long),"header",
	  fragment=SWIG_From_frag(long)) {
SWIGINTERNINLINE VALUE
SWIG_From_dec(unsigned long)(unsigned long value)
{
  return ULONG2NUM(value); 
}
}

%fragment(SWIG_AsVal_frag(unsigned long),"header",fragment="SWIG_ruby_failed") {
SWIGINTERN VALUE SWIG_AUX_NUM2ULONG(VALUE arg)
{
  VALUE *args = (VALUE *)arg;
  VALUE obj = args[0];
  VALUE type = TYPE(obj);
  unsigned long *res = (unsigned long *)(args[1]);
  *res = type == T_FIXNUM ? NUM2ULONG(obj) : rb_big2ulong(obj);
  return obj;
}

SWIGINTERN int
SWIG_AsVal_dec(unsigned long)(VALUE obj, unsigned long *val) 
{
  VALUE type = TYPE(obj);
  if ((type == T_FIXNUM) || (type == T_BIGNUM)) {
    unsigned long v;
    VALUE a[2];
    a[0] = obj;
    a[1] = (VALUE)(&v);
    if (rb_rescue(VALUEFUNC(SWIG_AUX_NUM2ULONG), (VALUE)a, VALUEFUNC(SWIG_ruby_failed), 0) != Qnil) {
      if (rb_funcall(obj, swig_lowerthan_id, 1, INT2FIX(0)) != Qfalse)
        return SWIG_OverflowError;
      if (val) *val = v;
      return SWIG_OK;
    }
  }
  return SWIG_TypeError;
}
}

/* long long */

%fragment(SWIG_From_frag(long long),"header",
	  fragment=SWIG_From_frag(long),
	  fragment="SWIG_LongLongAvailable") {
%#ifdef SWIG_LONG_LONG_AVAILABLE
SWIGINTERNINLINE VALUE 
SWIG_From_dec(long long)(long long value)
{
  return LL2NUM(value);
}
%#endif
}

%fragment(SWIG_AsVal_frag(long long),"header",
	  fragment="SWIG_ruby_failed",
	  fragment="SWIG_LongLongAvailable") {
%#ifdef SWIG_LONG_LONG_AVAILABLE
SWIGINTERN VALUE SWIG_AUX_NUM2LL(VALUE arg)
{
  VALUE *args = (VALUE *)arg;
  VALUE obj = args[0];
  VALUE type = TYPE(obj);
  long long *res = (long long *)(args[1]);
  *res = type == T_FIXNUM ? NUM2LL(obj) : rb_big2ll(obj);
  return obj;
}

SWIGINTERN int
SWIG_AsVal_dec(long long)(VALUE obj, long long *val)
{
  VALUE type = TYPE(obj);
  if ((type == T_FIXNUM) || (type == T_BIGNUM)) {
    long long v;
    VALUE a[2];
    a[0] = obj;
    a[1] = (VALUE)(&v);
    if (rb_rescue(VALUEFUNC(SWIG_AUX_NUM2LL), (VALUE)a, VALUEFUNC(SWIG_ruby_failed), 0) != Qnil) {
      if (val) *val = v;
      return SWIG_OK;
    }
  }
  return SWIG_TypeError;
}
%#endif
}

/* unsigned long long */

%fragment(SWIG_From_frag(unsigned long long),"header",
	  fragment="SWIG_LongLongAvailable") {
%#ifdef SWIG_LONG_LONG_AVAILABLE
SWIGINTERNINLINE VALUE 
SWIG_From_dec(unsigned long long)(unsigned long long value)
{
  return ULL2NUM(value);
}
%#endif
}

%fragment(SWIG_AsVal_frag(unsigned long long),"header",
	  fragment="SWIG_ruby_failed",
	  fragment="SWIG_LongLongAvailable") {
%#ifdef SWIG_LONG_LONG_AVAILABLE
SWIGINTERN VALUE SWIG_AUX_NUM2ULL(VALUE arg)
{
  VALUE *args = (VALUE *)arg;
  VALUE obj = args[0];
  VALUE type = TYPE(obj);
  long long *res = (long long *)(args[1]);
  *res = type == T_FIXNUM ? NUM2ULL(obj) : rb_big2ull(obj);
  return obj;
}

SWIGINTERN int
SWIG_AsVal_dec(unsigned long long)(VALUE obj, unsigned long long *val)
{ 
  VALUE type = TYPE(obj);
  if ((type == T_FIXNUM) || (type == T_BIGNUM)) {
    unsigned long long v;
    VALUE a[2];
    a[0] = obj;
    a[1] = (VALUE)(&v);
    if (rb_rescue(VALUEFUNC(SWIG_AUX_NUM2ULL), (VALUE)a, VALUEFUNC(SWIG_ruby_failed), 0) != Qnil) {
      if (rb_funcall(obj, swig_lowerthan_id, 1, INT2FIX(0)) != Qfalse)
        return SWIG_OverflowError;
      if (val) *val = v;
      return SWIG_OK;
    }
  }
  return SWIG_TypeError;
}
%#endif
}

/* double */

%fragment(SWIG_From_frag(double),"header") {
  %define_as(SWIG_From_dec(double),  rb_float_new)
}

%fragment(SWIG_AsVal_frag(double),"header",fragment="SWIG_ruby_failed") {
SWIGINTERN VALUE SWIG_AUX_NUM2DBL(VALUE arg)
{
  VALUE *args = (VALUE *)arg;
  VALUE obj = args[0];
  VALUE type = TYPE(obj);
  double *res = (double *)(args[1]);
  *res = NUM2DBL(obj); (void)type;
  return obj;
}

SWIGINTERN int
SWIG_AsVal_dec(double)(VALUE obj, double *val)
{
  VALUE type = TYPE(obj);
  if ((type == T_FLOAT) || (type == T_FIXNUM) || (type == T_BIGNUM)) {
    double v;
    VALUE a[2];
    a[0] = obj;
    a[1] = (VALUE)(&v);
    if (rb_rescue(VALUEFUNC(SWIG_AUX_NUM2DBL), (VALUE)a, VALUEFUNC(SWIG_ruby_failed), 0) != Qnil) {
      if (val) *val = v;
      return SWIG_OK;
    }
  }
  return SWIG_TypeError;
}
}


