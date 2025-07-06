"""Image Hash Command-line tool."""

import typer
from typing_extensions import Annotated
from imgphash.image_phash import ImagePHash


def image_phash_cli(  # pylint: disable=too-many-arguments
    filename: Annotated[
        str,
        typer.Argument(help="The file name."),
    ] = "",
    *,
    mode: Annotated[
        str,
        typer.Option(
            help="The hash mode : [averageHash, blockMeanHash, "
            "colorMomentHash, marrHildrethHash, pHash, radialVarianceHash]."
        ),
    ] = "pHash",
    flip_v: Annotated[
        bool,
        typer.Option(
            help="Flip the image vertically (so hash will be flip resistant)."
        ),
    ] = False,
    flip_h: Annotated[
        bool,
        typer.Option(
            help="Flip the image horizontally (so hash will be flip "
            "resistant)."
        ),
    ] = False,
    compare: Annotated[
        str,
        typer.Option(
            help="Compare to an other image filename and return distance."
        ),
    ] = "",
    block_mean_hash_mode: Annotated[
        int,
        typer.Option(help="block_mean_hash_mode int, default:0"),
    ] = 0,
    marr_hildreth_hash_alpha: Annotated[
        float,
        typer.Option(help="marr_hildreth_hash_alpha float, default:2.0"),
    ] = 2.0,
    marr_hildreth_hash_scale: Annotated[
        float,
        typer.Option(help="marr_hildreth_hash_scale float, default:1.0"),
    ] = 1.0,
    radial_variance_hash_sigma: Annotated[
        float,
        typer.Option(help="radial_variance_hash_sigma float, default:1.0"),
    ] = 1.0,
    radial_variance_hash_num_of_angle_line: Annotated[
        int,
        typer.Option(
            help="radial_variance_hash_num_of_angle_line int, default:180"
        ),
    ] = 180,
) -> str:
    """img-phash-tools."""
    img_hash = ImagePHash(
        filename=filename, mode=mode, flip_v=flip_v, flip_h=flip_h
    )
    img_hash.block_mean_hash_mode = block_mean_hash_mode
    img_hash.marr_hildreth_hash_scale = marr_hildreth_hash_scale
    img_hash.marr_hildreth_hash_alpha = marr_hildreth_hash_alpha
    img_hash.radial_variance_hash_num_of_angle_line = (
        radial_variance_hash_num_of_angle_line
    )
    img_hash.radial_variance_hash_sigma = radial_variance_hash_sigma
    f_hash = img_hash.image_hash_file()
    print(ImagePHash.hash_to_str(f_hash))
    if compare != "":
        img_hash2 = ImagePHash(
            filename=compare, mode=mode, flip_v=flip_v, flip_h=flip_h
        )
        img_hash2.block_mean_hash_mode = block_mean_hash_mode
        img_hash2.marr_hildreth_hash_scale = marr_hildreth_hash_scale
        img_hash2.marr_hildreth_hash_alpha = marr_hildreth_hash_alpha
        img_hash2.radial_variance_hash_num_of_angle_line = (
            radial_variance_hash_num_of_angle_line
        )
        img_hash2.radial_variance_hash_sigma = radial_variance_hash_sigma
        f_hash2 = img_hash2.image_hash_file()
        print(ImagePHash.hash_to_str(f_hash2))
        print(str(ImagePHash.hamming_distance(f_hash, f_hash2)))
    return ImagePHash.hash_to_str(f_hash)


app = typer.Typer()
app.command()(image_phash_cli)


if __name__ == "__main__":
    app()
