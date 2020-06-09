import 'package:flutter/material.dart';


class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("ابحث عن عامل متخصص في المجال في جميع المجالات  مثل الميكانيكي او السباك او النقاش او عامل البلاط او البني والعديد من العمال");
  sliderModel.setTitle("ابحث");
  sliderModel.setImageAssetPath("images/SP5.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("تواصل مع العامل  من  مكانك  وسيكون لديك في خلال ساعات");
  sliderModel.setTitle("اطلب");
  sliderModel.setImageAssetPath("images/sp2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("انجز عملك في اقرب وقت وباسرع عمل مع المتخصص في المجال المناسب ");
  sliderModel.setTitle("انجز عملك");
  sliderModel.setImageAssetPath("images/sp3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}