<?php

namespace AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

use AppBundle\Form\Type\ContactType;

class DefaultController extends Controller
{
    public function indexAction(Request $request)
    {
        $form = $this->createForm(ContactType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $message = \Swift_Message::newInstance()
                ->setSubject($form->get('subject')->getData())
                ->setFrom($form->get('email')->getData())
                ->setTo('welcominh@gmail.com')
                ->setBody(
                    $this->renderView(
                        'AppBundle:Default:contact.html.twig',
                        array(
                            'email'     => $form->get('email')->getData(),
                            'subject'   => $form->get('subject')->getData(),
                            'message'   => $form->get('message')->getData()
                        )
                    )
                )
            ;

            if($form->get('antibot')->getData() != 7) {

                $this->get('session')->getFlashBag()->add(
                    'contact_sent',
                    'Erreur ! Robot détécté. Message non envoyé !'
                );

            } else {

                $this->get('mailer')->send($message);

                $this->get('session')->getFlashBag()->add(
                    'contact_sent',
                    'Votre message a bien été envoyé. Nous vous répondrons dans les plus brefs délais.'
                );
            }
            return $this->redirect($this->generateUrl('homepage'));
        }

        return $this->render('AppBundle:Default:index.html.twig', array(
            'form_contact' => $form->createView(),
        ));
    }
}
