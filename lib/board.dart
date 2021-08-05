import 'package:flutter/material.dart';
import 'package:squares/board_state.dart';
import 'package:squares/piece_set.dart';
import 'package:squares/square.dart';
import 'package:squares/types.dart';

class Board extends StatelessWidget {
  final PieceSet pieceSet;
  final BoardState state;
  final int ranks;
  final int files;
  final Color? light;
  final Color? dark;
  final Color? highlightFromColour;
  final Color? highlightToColour;
  final Color? checkColour;
  final Color? checkmateColour;
  final int? selectedFrom;
  final int? selectedTo;
  final int? checkSquare;
  final bool gameOver;
  final Function(int)? onTap;
  final List<int> highlights;

  Board({
    required this.pieceSet,
    required this.state,
    this.ranks = 8,
    this.files = 8,
    this.light,
    this.dark,
    this.highlightFromColour,
    this.highlightToColour,
    this.checkColour,
    this.checkmateColour,
    this.selectedFrom,
    this.selectedTo,
    this.checkSquare,
    this.gameOver = false,
    this.onTap,
    this.highlights = const [],
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color _light = light ?? theme.primaryColorLight;
    Color _dark = dark ?? theme.primaryColorDark;
    Color _highlightFrom = highlightFromColour ?? theme.accentColor;
    Color _highlightTo = highlightToColour ?? theme.accentColor;
    Color _check = checkColour ?? theme.secondaryHeaderColor;
    Color _checkmate = checkmateColour ?? theme.errorColor;
    return AspectRatio(
        aspectRatio: files / ranks,
        child: Container(
            child: Column(
          children: List.generate(
              ranks,
              (rank) => Expanded(
                      child: Row(
                    children: List.generate(files, (file) {
                      int id = rank * files + file;
                      String symbol = state.board[id];
                      Widget? piece = symbol.isNotEmpty ? pieceSet.piece(context, symbol) : null;
                      Color squareColour = ((rank + file) % 2 == 0) ? _light : _dark;
                      if (selectedFrom == id) squareColour = _highlightFrom;
                      if (selectedTo == id) squareColour = _highlightTo;
                      if (checkSquare == id) squareColour = gameOver ? _checkmate : _check;
                      bool hasHighlight = highlights.contains(id);
                      return Square(
                        id: rank * files + file,
                        colour: squareColour,
                        piece: piece,
                        onTap: onTap != null ? () => onTap!(id) : null,
                        highlight: hasHighlight ? Colors.orange.withAlpha(120) : null,
                      );
                    }),
                  ))),
        )));
  }
}
