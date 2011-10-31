package
{
public function f$(func:Function):Function
{
    return function(...args):*
    {
        return function(...dontCare):*
        {
            func.apply(null, args);
        }
    }
}
}
