import 'package:flutter/material.dart';
import 'package:instalike/screens/add_post_screen.dart';
import 'package:instalike/screens/feed_screen.dart';
import 'package:instalike/screens/profile_screen.dart';
import 'package:instalike/screens/search_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text('notif'),
  ProfileScreen()
];
