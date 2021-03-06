using PyCallJLD
using Base.Test
using PyCall, JLD

dir = tempdir()
tmp = joinpath(dir, "temp.jld")

try
    const deque = pyimport("collections")["deque"]

    obj = [deque([1,2,3]), deque([4,5,6])]
    save(tmp, "x", obj)
    @test load(tmp, "x") == obj

    save(tmp, "x", PyObject("fé"))
    @test load(tmp, "x") == PyObject("fé")

    obj = PyObject(rand(UInt8, 1000))
    save(tmp, "x", obj)
    @test load(tmp, "x") == obj
finally
    # Disabled because it fails on Travis-Linux
    #rm(dir, force=true, recursive=true)
end
