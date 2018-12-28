# Resamplex

Resamplex is a supervised image resizer that is based on evadne/supervised-scaler (specifically its "resampler" dependency) and depends on libvips (https://jcupitt.github.io/libvips/). NOTE: Absolutely NO use of ImageMagick or GraphicsMagick!

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `resamplex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:resamplex, "~> 0.1.0"}
  ]
end
```

## Usage
```elixir
{:ok, path_to_converted_temp_file} = Resamplex.request("path/to/file.(jpg|png)", maxWidth, maxHeight)
```
Input file can be jpg or png (and possibly others such as pdf or webm, haven't tested)
Output is always jpg currently. Quality cannot yet be specified.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/resamplex](https://hexdocs.pm/resamplex).

